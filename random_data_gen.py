import numpy as np
import matplotlib.pyplot as plt
import math
class dataGen:
    def __init__(self, n_pose, n_landmark):
        self.n_pose = n_pose
        self.n_landmark = n_landmark
    def r_matrix(self, phi):
        return np.array([[math.cos(phi), -math.sin(phi)],
                         [math.sin(phi), math.cos(phi)]])
    def get_data(self):
        # height_matrix = self.n_pose + (self.n_pose * self.n_landmark)
        odom_true = np.zeros((self.n_pose,2))
        # odom_true
        # | post_v post_w |
        odom_true[:,0] = 1
        odom_true[:,1] = 2*np.random.rand(self.n_pose)-1
        
        pose = np.zeros(self.n_pose, 3)
        Phi = 0
        Ti = np.zeros(2,1)
        temp_vel = np.zeros(self.n_pose, 2)
        for n in range(odom_true.shape[0]):
            dR = self.r_matrix(odom_true[n,1])
            

        obs_true = np.zeros((self.n_pose * self.n_landmark, 2))

        return odom_true, obs_true
    def __str__(self):
        odom_true, obs_true = self.get_data()
        return "The odom matrix is \n{}\nThe observation matrix is \n{}".format(odom_true, obs_true)

if __name__ == "__main__":
    d_gen = dataGen(5,3)
    print(d_gen)