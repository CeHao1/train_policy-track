
import numpy as np
from scipy.interpolate import CubicSpline
import matplotlib.pyplot as plt


import sys
sys.path.append('..')

from src.real_track import build_real_track

"""
Map structure:
    Type:
    1:  s           course_v
    2:  X           X position of waypoints
    3:  Y           Y position of waypoints
    4:  psi         orientation at waypoints
    5:  kap         curvature at waypoints
    6:  Left_edge   distance to left edge
    7:  Right_edge  distance to right edge
    
"""

class customized_map:

    def __init__(self):
        self.track_param= {
            'num' : 4,
            'W' : np.array([3.5,3.5,3.5,3.5]),
            'kap_max' : np.array([0.01,-0.015,0.02,0.015]),
            'F' : np.array([[0.7,0.3],[0.2,0.4],[0.2,0.6],[0.3,0.7]]),
            'Len' : np.array([80,60,70,80])
            }

        self.s = np.array([0])
        self.X = np.array([0])
        self.Y = np.array([0])
        self.psi = np.array([0])
        self.kap = np.array([0])
        self.Left_edge = np.array([0])
        self.Right_edge = np.array([0])

        self.get_track()
        self.intp()

    def get_track(self):
        track_param = self.track_param
        
        track = {}
        for i in range(track_param['num']):
            if i > 0:
                psi_init = track[i-1].psi[-1]
                pos_init = [track[i-1].Center_X[-1], track[i-1].Center_Y[-1]]
            else:
                psi_init, pos_init = 0, [0,0]
                
            track[i] = build_real_track(W = track_param['W'][i], kap_max = track_param['kap_max'][i], 
                                        F = track_param['F'][i] ,Len = track_param['Len'][i],
                                        psi_init = psi_init, pos_init = pos_init)

            self.s = np.append(self.s[:-1], track[i].S + self.s[-1])
            self.X = np.append(self.X[:-1], track[i].Center_X)
            self.Y = np.append(self.Y[:-1], track[i].Center_Y)
            self.psi = np.append(self.psi[:-1], track[i].psi)
            self.kap = np.append(self.kap[:-1], track[i].kap)
            self.Left_edge = np.append(self.Left_edge[:-1], np.ones(track[i].S.shape[0]) * track[i].W)
            self.Right_edge = np.append(self.Right_edge[:-1], -np.ones(track[i].S.shape[0]) * track[i].W)
            self.track = track
        
    def intp(self):
        self.X_intp = CubicSpline(self.s, self.X)
        self.Y_intp =CubicSpline(self.s, self.Y)
        self.psi_intp = CubicSpline(self.s, self.psi)
        self.kap_intp = CubicSpline(self.s, self.kap)
        self.Left_edge_intp = CubicSpline(self.s, self.Left_edge)
        self.Right_edge_intp = CubicSpline(self.s, self.Right_edge)
        
    def get_kap(self,s):
        return self.kap_intp(s)

    def bias(self,X,Y,psi,W):
        X2 = X - W * np.sin(psi)
        Y2 = Y + W * np.cos(psi)
        return X2,Y2

    def plot(self):
        track = self.track
        track_param = self.track_param

        plt.figure(figsize=(15,10))
        for i in range(track_param['num']):
            track[i].plot2()
        plt.axis('equal')
        plt.show()