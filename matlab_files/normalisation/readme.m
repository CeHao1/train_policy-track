
 functions
1. bias : from frenet to cartisian
2. get_kap: calculate curvature
3. get_norm_path(2): get normalized path
4. extend_normal: convert path from normalized path to real track
5. plan_each_seg: directly plan path in the real track (not useful now)
6. plan_policy: spline interpolation
7. seg_track: get the segment on index


mains
1. plan3: plan in the normalized track and project it to real track
2. plan4: do plan3 in the sequential corners
3. need**: use fun3+diff policies+fun6 to generate modules