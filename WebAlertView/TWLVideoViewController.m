//
//  TWLVideoViewController.m
//  WebAlertView
//
//  Created by Tristan Lopes on 24/08/12.
//  Copyright (c) 2012 Tristan Lopes. All rights reserved.
//

#import "TWLVideoViewController.h"

@interface TWLVideoViewController ()

@end

@implementation TWLVideoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated{
    if([self.view.subviews count]>0){
        
        UIView *view = [self.view.subviews objectAtIndex:0];
        CGRect frame = view.frame;
        
        // had some rotation issues, could have been just me and this actually stuffs up other people
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        
        if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown){
            frame.size.width=self.view.frame.size.width;
            frame.size.height=self.view.frame.size.height;
        }else{
            frame.size.width=self.view.frame.size.height;
            frame.size.height=self.view.frame.size.width;
        }
        view.frame = frame;
        
        // recursively loop through all subviews and fix their heights
        [self fixHeights:self.view];
        
        self.view.backgroundColor = [UIColor blackColor];
    }else{
        // if there are no views...hide me
        self.view.backgroundColor = [UIColor clearColor];
    }
}

- (void)fixHeights:(UIView*)view{
    for(UIView *children in view.subviews){
        
        CGRect frame = children.frame;
        
        UIInterfaceOrientation orientation = [[UIApplication sharedApplication] statusBarOrientation];
        
        if(orientation==UIDeviceOrientationPortrait || orientation==UIDeviceOrientationPortraitUpsideDown){
            if(frame.size.height>self.view.frame.size.height){
                frame.size.height -= self.view.frame.size.height;
                
                children.frame=frame;
            }
        }else{
            if(frame.size.width>self.view.frame.size.width){
                frame.size.width -= self.view.frame.size.width;
                
                children.frame=frame;
            }
        }
        
        [self fixHeights:children];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
