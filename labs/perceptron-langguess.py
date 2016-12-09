
# coding: utf-8

# In[11]:

import numpy as np
weights = np.array([0.5,0.48,-0.7])
alpha = 0.1
streetlights = np.array( [[ 1, 0, 1 ],
 [ 0, 1, 1 ],
 [ 0, 0, 1 ],
 [ 1, 1, 1 ],
 [ 0, 1, 1 ],
 [ 1, 0, 1 ] ] )
walk_vs_stop = np.array( [ 0, 1, 0, 1, 1, 0 ] )
input = streetlights[0] # [1,0,1]
goal_prediction = walk_vs_stop[0] # equals 0... i.e. "stop"
for iteration in range(20):
 prediction = input.dot(weights)
 error = (goal_prediction - prediction) ** 2
 delta = prediction - goal_prediction
 weights = weights - (alpha * (input * delta))
 print ("Error:" + str(error) + " Prediction:" + str(prediction))


# In[24]:

import numpy as np
from string import ascii_lowercase

alpha = 0.01
training = []
category = []
lines=[]

with open('/home/smt/Icon2016/labs/test.txt', 'r') as f:
    for line in f:
        lines.append(line)
        training.append([line.lower().count(ch) 
                         for ch in ascii_lowercase])
        category.append("+" in line)
    
weights = np.random.rand(26)
ntraining = np.array(training)
ncategory = np.array(category)

for example in range(140):
    input = ntraining[example] 
    
    goal_prediction = ncategory[example] 
    prediction = max(min(input.dot(weights), 1), 0)
    
    error = (goal_prediction - prediction) ** 2
    delta = prediction - goal_prediction
    weights = weights - (alpha * (input * delta))
    
#    print("Ex: %d Error= %f Goal: %d Prediction: %d " 
#          % (example, error, goal_prediction, prediction))

n = len(ntraining) - 1
for test in range(n, n - 10, -1):
    input = ntraining[test]
    goal_prediction = ncategory[test]
    prediction = input.dot(weights) > 0.5
    
    if (goal_prediction != prediction):
        print ("Test:" + str(test) + " "+lines[test]+" error=" + str(error) + " Prediction:" + str(prediction)+" was"+str(goal_prediction))


# In[13]:

import numpy as np
print(np.random.rand(4))


# In[120]:

import numpy as np
weights = np.array([0.5,0.48,-0.7])
alpha = 0.1
streetlights = np.array( [[ 1, 0, 1 ],
 [ 0, 1, 1 ],
 [ 0, 0, 1 ],
 [ 1, 1, 1 ],
 [ 0, 1, 1 ],
 [ 1, 0, 1 ] ] )
walk_vs_stop = np.array( [ 0, 1, 0, 1, 1, 0 ] )
input = streetlights[0] # [1,0,1]
goal_prediction = walk_vs_stop[0] # equals 0... i.e. "stop"
for iteration in range(20):
 prediction = input.dot(weights)
 error = (goal_prediction - prediction) ** 2
 delta = prediction - goal_prediction
 weights = weights - (alpha * (input * delta))
 print ("Error:" + str(error) + " Prediction:" + str(prediction))


# In[ ]:



