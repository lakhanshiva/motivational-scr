import numpy as np
"""
Two armed bandit
"""


class Bandit:
    def __init__(self, bandit_probs):
        self.N = len(bandit_probs) # number of arms of bandit
        self.succ_probs = bandit_probs # Success probabilities

class EpsilonGreedy:
    def __init__(self, bandit, eps, init_prob = 1.0):
        self.eps = eps
        self.k = np.zeros(bandit.N, dtype=np.int) #action counter
        self.Q = np.zeros(bandit.N, dtype=np.float) #action value

    def update_Q(self, action, reward):
        self.k[action] = self.k[action] + 1; #incr action counter
        self.Q[action] = self.Q[action] + (1./self.k[action]) * (reward - self.Q[action])

    def get_action(self, bandit):
        rand = np.random.random() # Returns a float b/w 0 and 1
        if (rand < self.eps):
            action_idx = np.random.randint(bandit.N) #explore random arm of bandit
            return action_idx
        else:
            action_idx = np.argmax(self.Q)
            
            return action_idx
