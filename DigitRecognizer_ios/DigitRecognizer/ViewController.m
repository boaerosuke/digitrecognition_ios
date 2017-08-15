//
//  ViewController.m
//  DigitRecognizer
//
//  Created by Eridy Lukau on 15.08.17.
//  Copyright © 2017 deeplearning_lukau. All rights reserved.
//

#import "ViewController.h"
#import <CoreML/CoreML.h>
#import <Vision/Vision.h>
#import "keras_mnist_cnn.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *drawingCanvas;
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (strong,nonatomic) CIImage *imageToDetect;



@end

@implementation ViewController
- (IBAction)predictButtonPressed:(id)sender {
    [self predictDigit];
}
- (IBAction)clearButtonPressed:(id)sender {
    self.drawingCanvas.image = nil;
    self.imageToDetect = nil;
    self.resultLabel.text = @"Draw a number or tap on an image";
}
- (IBAction)testFunfButtonPressed:(id)sender {
    self.drawingCanvas.image = [UIImage imageNamed:@"funf.png"];
    self.resultLabel.text = @"Hit predict...";
    
}
- (IBAction)testVierButtonPressed:(id)sender {
    self.drawingCanvas.image = [UIImage imageNamed:@"vier.png"];
    self.resultLabel.text = @"Hit predict...";

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setUpCanvasColors];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma predictions
-(void)predictDigit{
  
    //unscaled image
    //self.imageToDetect = [[CIImage alloc]initWithImage:self.drawingCanvas.image];
    
    //scaled image to 28x28
    UIImage *scaledCanvasImage = [self imageWithImage:self.drawingCanvas.image scaledToSize:CGSizeMake(28, 28)];
    self.imageToDetect = [[CIImage alloc]initWithImage:scaledCanvasImage];
    
    MLModel *ml_model = [[[keras_mnist_cnn alloc] init] model];
    VNCoreMLModel *vnc_core_ml_model = [VNCoreMLModel modelForMLModel: ml_model error:nil];
    
    VNCoreMLRequest *request = [[VNCoreMLRequest alloc] initWithModel: vnc_core_ml_model completionHandler: (VNRequestCompletionHandler) ^(VNRequest *request, NSError *error){
        NSArray *results = [request.results copy];
        
        VNCoreMLFeatureValueObservation *res = ((VNCoreMLFeatureValueObservation *)(results[0]));
        
        NSNumber *prediction = [NSNumber numberWithFloat:0];
        NSNumber *compare= [NSNumber numberWithFloat:0];
        int atIndex = 0;
        
        
        for(int i = 0; i<[res.featureValue multiArrayValue].count; i++){
            
            compare = [[res.featureValue multiArrayValue] objectAtIndexedSubscript:i];
            if([compare floatValue] > [prediction floatValue]){
                prediction = compare;
                atIndex = i;
            }
        }
        
       // double predictionPercentage = [[[res.featureValue multiArrayValue] objectAtIndexedSubscript:atIndex] doubleValue];
        
        NSString *result = @"";
        self.resultLabel.text = [result stringByAppendingFormat: @"Digit may be: %i", atIndex];
    }];
    
    NSDictionary *options_dict = [[NSDictionary alloc] init];
    NSArray *request_array = @[request];
    
    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCIImage:self.imageToDetect options:options_dict];
    dispatch_queue_t myCustomQueue;
    myCustomQueue = dispatch_queue_create("com.lukau.VNImageRequestHandlerQueue", NULL);
    
    self.resultLabel.text = @"Predicting...";
    dispatch_sync(myCustomQueue, ^{
        [handler performRequests:request_array error:nil];
        
    });
}

//helper method to scale uiimage
- (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

# pragma Canvas Setup
-(void)setUpCanvasColors{
    
    //stroke width
    brush = 10.0;
    // stroke opacity
    opacity = 1.0;
    
    //BrushColor White
    red = 255.0/255.0;
    green = 255.0/255.0;
    blue = 255.0/255.0;
    
    
    // Black
    /*
     red = 0.0/255.0;
     green = 0.0/255.0;
     blue = 0.0/255.0;
     */
    
    
    //Canvas Background
    self.drawingCanvas.backgroundColor = [UIColor blackColor];
    
}

#pragma Touch and Draw Delegates
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    fingerMovedOnScreen = NO;
    UITouch *touch = [touches anyObject];
    fingersLastPoint = [touch locationInView:self.drawingCanvas];
    
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    fingerMovedOnScreen = YES;
    UITouch *touch = [touches anyObject];
    
    CGPoint currentPoint = [touch locationInView:self.drawingCanvas];
    UIGraphicsBeginImageContext(self.drawingCanvas.frame.size);
    
    [self.drawingCanvas.image drawInRect:CGRectMake(0,
                                                    0,
                                                    self.drawingCanvas.frame.size.width,
                                                    self.drawingCanvas.frame.size.height)];
    
    CGContextMoveToPoint(UIGraphicsGetCurrentContext(), fingersLastPoint.x, fingersLastPoint.y);
    CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), currentPoint.x, currentPoint.y);
    CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
    CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush );
    CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, 1.0);
    CGContextSetBlendMode(UIGraphicsGetCurrentContext(),kCGBlendModeNormal);
    CGContextStrokePath(UIGraphicsGetCurrentContext());
    self.drawingCanvas.image = UIGraphicsGetImageFromCurrentImageContext();
    [self.drawingCanvas setAlpha:opacity];
    UIGraphicsEndImageContext();
    
    fingersLastPoint = currentPoint;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    if(!fingerMovedOnScreen) {
        UIGraphicsBeginImageContext(self.drawingCanvas.frame.size);
        [self.drawingCanvas.image drawInRect:CGRectMake(0,
                                                        0,
                                                        self.drawingCanvas.frame.size.width,
                                                        self.drawingCanvas.frame.size.height)];
        CGContextSetLineCap(UIGraphicsGetCurrentContext(), kCGLineCapRound);
        CGContextSetLineWidth(UIGraphicsGetCurrentContext(), brush);
        CGContextSetRGBStrokeColor(UIGraphicsGetCurrentContext(), red, green, blue, opacity);
        CGContextMoveToPoint(UIGraphicsGetCurrentContext(), fingersLastPoint.x, fingersLastPoint.y);
        CGContextAddLineToPoint(UIGraphicsGetCurrentContext(), fingersLastPoint.x, fingersLastPoint.y);
        CGContextStrokePath(UIGraphicsGetCurrentContext());
        CGContextFlush(UIGraphicsGetCurrentContext());
        self.drawingCanvas.image = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
    }
}

@end
