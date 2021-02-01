import sys, os.path
sys.path.insert(0, os.path.join(os.path.dirname(__file__), 'race'))


# sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))

from src.plan.graph_search import graph_search
from src.maps.base_map import base_map
from src.maps.Tokyo import Tokyo_map
from src.vehicle.Roadster import Roadster

def main():
    map1 = base_map()


if __name__ == '__main__':
    main()