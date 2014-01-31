Violence-detection-from-audio
=============================
Detection of violence from media by analyzing audio streams

Abstract

In the context of present day scenario, where multimedia data is proliferating at an exponential rate, it is getting increasingly important to automate the monitoring of the content. Manual inspection for the censoring of sensitive content takes a toll when thousands of files require constant assessment. The need to protect certain social groups has given rise to the need for massive content filtering systems which focus on certain aspects of media like, violence. In this paper, we propose a model wherein the violent scenes are detected from audio after learning representations of audio features.

Running instructions 

Training Data
1.	Save the .wav files in to the ‘sounds’ folder.
2.	Using the ‘test.m’ file, we perform MFCC function on all the .wav files. After the completion of this, we get the MFCC of all the audio files separately (13xn). All the vectors are concatenated in “data.mat” . Dimensions in “dimensions.mat”.
3.	Go to ‘deltacepstrum.m’, it gives  ‘deltadata.mat’ in its ‘new_D’ variable.
4.	Go to ‘start.m’.  Performs kmeans on deltadata.mat. saved in ‘delta_idx.mat’' , and centroids of clusters are saved in ‘centroids.mat’. This file also segments ‘delta_idx’ file into respective audio files and generates the respective featurevectors for each of the audio files.
5.	Run learn.m to get results for different classifiers
6.	Use svmexp.m to get results for cross validation. You can also change the classifier if you want.
7.	Use test_example_SAE.m to use auto-encoder to reduce the number of dimensions of the data and then you can run it on different classifiers
8.	Use test_example_SAE_CV to run autoencoder and do cross validation on the data. 

Test Data
1.	Save the test files in .wav format in the testdata folder.
2.	Go to test_createdata.m to perform MFCC on all the test files. The vectors are concatenated in test_data and dimension in test_dimensions.
3.	Run test_cepstrum.m
4.	Run test_clustering.m . It gives the feature vectors of each of the test audio files in the testfeatures folder. You need to create a subfolder in the testfeatures folder for each audio file.
5.	Run test_learn.m . You can change the classifiers in this file to be performed on the data.
6.	Run test_plottingresults.m . It gives a value to each 3 sec clip. Saved in testresults folder.

__________________________________________________________________________________
