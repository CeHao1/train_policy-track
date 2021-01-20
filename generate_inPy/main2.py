
import numpy as np
import time as time
from tqdm import tqdm
from funs2 import build_real_track, build_real_path



ind =57
name='F_{}_P_0_to_160000.npy'.format(ind)
# path='/home/jovyan/work/sv_data/'
path = '/home/work/sv_data/'

data=np.load(path+name,allow_pickle=True)


path1 = data[0]
track=build_real_track(W=3.5,kap_max=0.01,F=path1['F'],Len=50)
real_path = build_real_path()

sv_data = []
# rd = data.shape[0]
rd = 100
for i in tqdm(range(rd)):
    path1 = data[i]
    real_path.retrive_standard_path(F=path1['F'], P=path1['P'], path=path1['path'])
    real_path.retrive_real_path(track)
    real_path.get_kap()
    real_path.get_velocity(V_init=35, ay_max=10.0, ax_max=1.3, ax_min=-9.5)

    sv_data.append({'name':name,'time':real_path.laptime,'V_exit':real_path.V_exit,'kap_average':real_path.kap_average})