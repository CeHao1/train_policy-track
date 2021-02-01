import numpy as np
from tqdm import tqdm
import matplotlib.pyplot as plt


from src.track.std_track import build_track, build_path
from src.track.real_track import build_real_track, build_real_path



class graph_search:
    
    def __init__(self, num_sample=5, num_pts=3, iteration=5):
        self.num_sample =num_sample
        self.num_pts = num_pts
        self.total_iter= num_sample**num_pts
        self.iteration = iteration
           
        size_policy=()
        for i in range(num_pts):
            size_policy+=(num_sample,)
        
        self.policy_lib=np.array(list(np.unravel_index(
                np.arange(num_sample**num_pts),size_policy)))
        
        
    def run(self, F, track, init_bias=0,V_init = 35 ):
        self.F = F
        self.track = track
        self.init_bias = init_bias
        self.V_init = V_init
        
        num_sample = self.num_sample
        num_pts = self.num_pts
        total_iter = self.total_iter
        policy_lib = self.policy_lib
        bnd = np.tile(np.array([-1.0,1.0]),(num_pts,1))
        
        std_track = build_track(F)
        self.std_track = std_track
        
        
        for iter_binary in tqdm(range(self.iteration)):
            policies=[np.linspace(bnd[i][0],bnd[i][1],num_sample) for i in range(num_pts)]
            sv = {'time':np.empty(total_iter), 'V_exit':np.empty(total_iter), 'kap_average':np.empty(total_iter)}
            
            for iter_policy in (range(total_iter)):
                policy=np.array([policies[i][policy_lib[i][iter_policy]] for i in range(num_pts)])
                path=build_path(F, np.hstack(([init_bias],policy)), std_track)
                path.generate()
                real_path = build_real_path()
                real_path.retrive_standard_path(F=F, P=policy, path=path.Y)
                real_path.retrive_real_path(track)
                real_path.get_kap()
                real_path.get_velocity(V_init=V_init, ay_max=10.0, ax_max=1.3, ax_min=-9.5) 
                
                sv['time'][iter_policy] = real_path.laptime
                sv['V_exit'][iter_policy] = real_path.V_exit
                sv['kap_average'][iter_policy] = real_path.kap_average
                
            best_iter = np.argmin(sv['time'])
#             best_iter = np.argmin(sv['kap_average'])
#             best_iter = np.argmax(sv['V_exit'])
            
            best_index = [policy_lib[i][best_iter] for i in range(num_pts)]
            
            for i in range(num_pts):
                bnd[i][0] = policies[i][max(best_index[i]-1,0)]
                bnd[i][1] = policies[i][min(best_index[i]+1,num_sample-1)]

#                 bnd[i][0] = (policies[i][max(best_index[i]-1,0)]*2 + policies[i][best_index[i]])/3
#                 bnd[i][1] = (policies[i][min(best_index[i]+1,num_sample-1)]*2 + policies[i][best_index[i]])/3
                
        self.policy_finally=[policies[i][best_index[i]] for i in range(num_pts)]
        
    def show_result(self):
        F = self.F
        track = self.track
        init_bias = self.init_bias
        V_init =self.V_init
        std_track = self.std_track
        policy_finally = self.policy_finally
        
        policy = np.hstack(([init_bias],policy_finally))
        path=build_path(F, np.hstack(([init_bias],self.policy_finally)), std_track)
        path.generate()
        real_path = build_real_path()
        real_path.retrive_standard_path(F=F, P=policy, path=path.Y)
        real_path.retrive_real_path(track)
        real_path.get_kap()
        real_path.get_velocity(V_init=V_init, ay_max=10.0, ax_max=1.3, ax_min=-9.5) 
        
        self.V_exit = real_path.V_exit
        self.P_exit = self.policy_finally[-1]
        self.time = real_path.laptime
        
        real_path.plot2()