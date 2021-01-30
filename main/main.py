import matplotlib.pyplot as plt
import numpy as np
from tqdm import tqdm


from src.real_track import build_real_track, build_real_path
from src.std_track import build_track, build_path
from src.search import graph_search


def main():

    # set parameters of real track
    track_param= {
        'num' : 4,
        'W' : np.array([3.5,3.5,3.5,3.5]),
        'kap_max' : np.array([0.01,-0.015,0.02,0.015]),
        'F' : np.array([[0.7,0.3],[0.2,0.4],[0.2,0.6],[0.3,0.7]]),
        'Len' : np.array([80,60,70,80])
    }

    # formulate real track
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

    # plt.figure(figsize=(15,10))
    # for i in range(track_param['num']):
    #     track[i].plot2()
        
    # plt.axis('equal')
    # plt.savefig('images/track_map.svg',format='svg')

    # formualte standard track 
    std_track = {}
    for i in range(track_param['num']):
        std_track[i] = build_track(track_param['F'][i])


    gs = graph_search(num_sample=5, iteration=5)

    lt = np.empty(track_param['num'])

    plt.figure(figsize=(15,10))

    for i in range(track_param['num']):
        if i ==0:
            init_bias, V_init = -0.4, 35.0
        else:
            init_bias, V_init =gs.P_exit, gs.V_exit
        
        gs.run(F=track_param['F'][i] , track=track[i], init_bias=init_bias, V_init=V_init )
        gs.show_result()
        
        lt[i] = gs.time
        
    plt.savefig('images/track_planned.svg',format='svg')

if __name__ == '__main__':
    main()

