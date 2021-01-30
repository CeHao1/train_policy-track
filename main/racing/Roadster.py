'''
To simulate Mazda Roadster in Tokyo Expressway Central Outter Loop in GT Sport game
Ce Hao built this environment on 01/30/2021
The frame is identical to gym cartpole
'''

import numpy as np


class Roadster:

"""
Description
    A racing vehicle Mazda Roadster runs in Tokyo Expressway.
    This class has a vehicle model and a track model.


Observation:
    Type: 
    0:  s           course_v, distance along centerline
    1:  epsi       error of orientation
    2:  ey         error of lateral distance
    3:  Vx          longitudinal velocity
    4:  Vy          lateral velocity
    5:  acc
    6:  steering

Actions:
    Type:
    0:  acc         acceleration
    1:  steering    steering angle



Reward:
    

Starting State:
    

Episode Termination:
    1. abs(ey) >= half_width
    2. course_v >= terminal distance
    3. abs(epsi) >= pi/2

"""

def __init__(self, map, s=0, epsi=0, ey=0, Vx=0):

    # map is where the vehilce runs
    self.map = map

    # vehicle parameters
    self.m = 1060
    self.Iz = 1493.4
    self.lf = 1.0462
    self.lr = 1.2638
    # self.Caf = 33240*2
    # self.Car = 33240*2
    self.a11 = 4800*2
    self.a12 = 7.0
    self.a21 = 3720*2
    self.a22 = 10.3
    self.w_wind = 2.7e-4
    self.dt = 1/60
    self.ds = 0.01


    # limits
    self.acc_limit = [1.3 , -9.5]
    self.steering_limit = [-30.0/180.0*np.pi, 30.0/180.0*np.pi]
    self.ey_limit = [-3.5 , 3.5]
    self.epsi_limit = [-np.pi/2.0 , np.pi/2.0]


    # initialize states
    self.time = 0
    self.s = s
    self.epsi = epsi
    self.ey = ey
    self.Vx = Vx
    self.Vy = 0
    self.dpsi = 0


def step(self, action):
    acc = max(self.acc_limit[0], min(self.acc_limit[1], action[0]))
    delta = max(self.steering_limit[0], min(self.steering_limit[1], action[1]))

    m = self.m
    Iz = self.Iz
    lf = self.lf
    lr = self.lr
    a11 = self.a11
    a12 = self.a12
    a21 = self.a21
    a22 = self.a22
    w_wind = self.w_wind
    dt = self.dt

    s = self.s
    epsi = self.epsi
    ey = self.ey
    Vx = self.Vx
    Vy = self.Vy
    dpsi = self.dpsi

    # get curvature
    kap = self.map.get_kap(s)

    # slip angle
    alpf = delta - np.atan2(Vy + lf*dpsi, Vx)
    alpr = -np.atan2(Vy - lr*dpsi, Vx)

    # tanh tire model
    Fyf = a11 * np.tanh(a12*alpf)
    Fyr = a21 * np.tanh(a22*alpr)

    # update states
    temp = ((Vx*np.cos(epsi) - Vy*np.sin(epsi)) / (1 - kap*ey))
    self.time   += dt
    self.s      += dt * temp 
    self.epsi   += dt * (dpsi - temp*kap)
    self.ey     += dt * (Vx*np.sin(epsi) + Vy*np.cos(epsi))
    self.Vx     += dt * (acc - (Fyf*np.sin(delta))/m + dpsi*Vx - w_wind*Vx**2)
    self.Vy     += dt * ((Fyf+np.cos(delta) + Fyr - dpsi*Vx)/m)
    self.dpsi   += dt * ((lf*Fyf*np.cos(delta) - lr*Fyr)/Iz)

    state = np.array([self.s, self.epsi, self.ey, self.Vx, self.Vy, self.dpsi])

    # done
    done = bool(
        self.s >= self.map.s[-1] or
        self.epsi <= self.epsi_limit[0]
        self.epsi >= self.epsi_limit[1]
        self.ey <= self.ey_limit[0]
        self.ey >= self.ey_limit[1]
    )

    reward = None

    return state, reward, done

    