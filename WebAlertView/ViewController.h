//
//  ViewController.h
//  WebAlertView
//
//  Created by Tristan Lopes on 24/08/12.
//  Copyright (c) 2012 Tristan Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWLWebAlertView.h"

@interface ViewController : UIViewController <UIAlertViewDelegate> {
    TWLWebAlertView *_webAlertView;
}

@end
