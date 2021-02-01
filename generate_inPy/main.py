import numpy as np
from tqdm import tqdm
from funs import build_track, build_path, build_feature


if __name__ == '__main__':
    feature=build_feature()

    F_start = input('Input start index of F: ')
    F_end = input('Input end index of F, max is {}:'.format(build_feature().total_num_F))
    P_start = input('Input start index of P, default if {}: '.format(0))
    P_end = input('Input end index of P, max and default is {}: '.format(build_feature().total_num_P))

    F_start = int(F_start)
    F_end = int(F_end)

    P_start=0 if P_start=='' else int(P_start)
    P_end=build_feature().total_num_P if P_end=='' else int(P_end)


    for ind_F in range(F_start,F_end):
        feature.fetch_feature_F(ind_F)
        track=build_track(feature.F)
        print('Current F is ',ind_F)
        
        data = []
        
        for ind_P in (range(P_start,P_end)):
            feature.fetch_feature_P(ind_P)
            path=build_path(feature.F,feature.P,track)
            path.generate()
            
            data.append({'F':feature.F,'P':feature.P,'path':path.Y})
            
        name='F_{}_P_{}_to_{}.npy'.format(ind_F,P_start,P_end)
        #path='/home/work/sv_data/'
        path = 'D:/sv_data/'
        np.save(path+name,data)
