# Handwritten digit recognition with Keras/MNIST on iOS

This deep learning sample application shows how to use a Keras model with the iOS CoreML framework in Objective-C. The used model implements a convolutional deep- neural network that is written in Keras in order to recognize handwritten digits based on the MNIST data model. The  `.h5` model that is created by Keras is then converted into a `.mlmodel` using `coremltools` that can be used in iOS new CoreML framework. Although the results of this model are not perfect, it is a good start into Machine learning in iOS in general. You can clone or download this repo and try to play around with the application and test the model.


## Implementation Prerequisites
In order to implement this completely by yourself you will need to have your working-station setup as follows:

**Deep Learning**
- Tensorflow (newest version)
- Python 2.7
- Keras (newest version)
- coremltools (newest version)

**iOS Development**
- MACOS Sierra 10.12.6 (this is mandatory for Xcode Version 9.0 beta)
- Xcode 9.0 (accessible with a developer account, currently beta)
- _optional_ iOS 11 installed on your iPhone (if you want to test the app on your iPhone, Simulator is totally sufficient.)
