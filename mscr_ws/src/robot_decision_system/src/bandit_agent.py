# 2-armed bandit

import numpy as np

def main():

    class Bandit:

        def __init__(self, bandit_win_prob):
            self.numbandits = 2 # 2 bandits
            self.win_prob = bandit_win_prob

    class Agent:


        def __init__(self, bandit, epsilon):
            assert 0. <= epsilon <= 1.0
            self.epsilon = epsilon
            # Intervention effectiveness table
            self.effectiveness = np.zeros(bandit.numbandits, dtype=np.float)

        def sample_intervention(self, bandit, explore_default=False):
            choice = np.random.random()
            if (choice <self.epsilon) or explore_default:
                intervention = np.random.randint(bandit.numbandits)
                return intervention
            else:
                # choose intervention with best win prob
                intervention = max(range(self.bandit.numbandits), key=lambda x:self.effectiveness[x]))
		return intervention

        def update_effectiveness(self):
            







    
