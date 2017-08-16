# Handwritten digit recognition with Keras/MNIST on iOS



This deep learning sample application shows how to use a Keras model with the iOS CoreML framework in Objective-C. The used model implements a convolutional deep- neural network that is written in Keras in order to recognize handwritten digits based on the MNIST data model. The  `.h5` model that is created by Keras is then converted into a `.mlmodel` using `coremltools` that can be used in iOS new CoreML framework. Although the results of this model are not perfect, it is a good start into Machine learning in iOS in general. You can clone or download this repo and try to play around with the application and test the model.

![alt text](https://cdn-images-1.medium.com/max/800/1*85o8rJYctX2iTCx34wiyig.png "Digit Recognizer")


A complete Tutorial for this App can be found [here](https://medium.com/@EridyLukau/handwritten-digit-recognition-with-mnist-on-ios-with-keras-e85e194f9fa5 "How to use a Keras deep learning neural network in iOS?")

## Implementation Prerequisites
In order to implement this completely by yourself you will need to have your working-station setup as follows:

**Deep Learning**
- Tensorflow 1.2.1
- Python 2.7
- Keras 2.0.6
- coremltools 0.5.1

**iOS Development**
- MACOS Sierra 10.12.6 (this is mandatory for Xcode Version 9.0 beta)
- Xcode 9.0 (accessible with a developer account, currently beta)
- _optional_ iOS 11 installed on your iPhone (if you want to test the app on your iPhone, Simulator is totally sufficient.)
