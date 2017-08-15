//
//  ViewController.h
//  DigitRecognizer
//
//  Created by Eridy Lukau on 15.08.17.
//  Copyright © 2017 deeplearning_lukau. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    BOOL fingerMovedOnScreen;
    CGPoint fingersLastPoint;
    
    CGFloat opacity;
    CGFloat brush;
    
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    
}


@end

