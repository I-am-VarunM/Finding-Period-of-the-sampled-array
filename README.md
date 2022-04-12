# Finding-Period-of-the-sampled-array
The matlab code triangle_gen.m can be run on matlab directly.
In my code I have set the frequency of the traingular wave as 400Hz which can be changed accordingly as per the usage.
The sampling frequency is more than twice the frequency of the wave. Since the derivative of the wave is not continuous we would be requiring more number of samples to reconstruct it.
To reconstruct the signal we are convolving with the sinc function which inturn gives us the function with ripples.
To remove the ripples we are passing the signal through a moving average filter which can smoothen the ripples to some extent.
Then we are calculating the distance betweent he peaks in the signal to get the period of the wave per every cycle.
