# Simple perceptron: guess if a string is in English or not.
# learns its weights from hundred examples, test it on 10s
# Created by Bruno Pouliquen & Marcin Junczys-Dowmunt
#
import numpy as np
from string import ascii_lowercase

alpha = 0.01   # Learning rate
lines=[]       # the sentences read from the test file
training = []  # A matrix containing for each line the count of each char
category = []  # A vector: for each line its category 1(English)/0(other)
fileName='test.txt' # test file containing sentences (English begins with '+')

with open(fileName, 'r') as f:
    for line in f:          
        lines.append(line)  # save the sentence
        training.append([line.lower().count(ch) 
                         for ch in ascii_lowercase]) # add the counts
        category.append("+" in line)  # Adds the category
    
weights = np.random.rand(26) # initialise the weight randomly (26 x 0-1)
ntraining = np.array(training) # Create a "numpy" matrix
ncategory = np.array(category) # Create a "numpy" category vector

for example in range(100):     # for each of the 1st 140 lines (training data)
    input = ntraining[example] # Input vector: the counts for this line
    
    goal_prediction = ncategory[example]  # We should target this category
    prediction = max(min(input.dot(weights), 1), 0) # Compute the prediction
    
    error = 0.5*(goal_prediction - prediction) ** 2 # Calculate the current error
    delta = prediction - goal_prediction # gradient of the error
    weights = weights - (alpha * (input * delta)) # adjust the weights
    
#    print("Ex: %d Error= %f Goal: %d Prediction: %d " 
#          % (example, error, goal_prediction, prediction))

n = len(ntraining) - 1
for test in range(n, n - 10, -1): # For each last 10 lines
    input = ntraining[test]  # Input vector: the counts for this line
    goal_prediction = ncategory[test] 
    prediction = input.dot(weights) > 0.5 # the computed category
    
    if (goal_prediction != prediction): # Here we detected the wrong category
        print ("Test:" + str(test) + " "+lines[test]+" error=" + str(error) + " Prediction:" + str(prediction)+" was"+str(goal_prediction))
