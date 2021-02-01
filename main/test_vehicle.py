
import matplotlib.pyplot as plt
import numpy as np
from tqdm import tqdm


from add_path import add_path
add_path()
from src.plan.graph_search import graph_search
from src.maps.base_map import base_map
from src.maps.Tokyo import Tokyo_map
from src.vehicle.Roadster import Roadster

def main():
    map1 = base_map()
    car = Roadster(map1, Vx=0.2)

    iters = int(1e5)
    store = np.array([])
    for i in tqdm(range(iters)):
        acc = 0
        steering = -car.ey * 0.01 - car.epsi * 0.5
        action = [acc, steering]
        
        state, reward, done = car.step(action)
        
        store = np.append(store, car.ey)
        
        if done:
            break
    
    plt.figure()
    plt.plot(store)
    plt.show()
    plt.savefig('images/p1.svg',format = 'svg')

if __name__ == '__main__':
    main()