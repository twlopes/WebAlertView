//
//  ViewController.m
//  WebAlertView
//
//  Created by Tristan Lopes on 24/08/12.
//  Copyright (c) 2012 Tristan Lopes. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (void)viewDidAppear:(BOOL)animated{
    _webAlertView = [[TWLWebAlertView alloc] initWithTitle:@"The video goes beneath me!" message:nil delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    [_webAlertView show];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

- (void)alertView:(TWLWebAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex{
    if(buttonIndex==666){
        // its the devil, just quit now
        return;
    }
    
    [_webAlertView show];
}

- (void)willPresentAlertView:(UIAlertView *)alertView{
     NSArray *urlChoices = [NSArray arrayWithObjects:@"http://vimeo.com/39580537", @"http://www.youtube.com/watch?v=vb7PLolg-RA&feature=ymg", @"http://www.dailymotion.com/video/xstnbt_punk-cat-knocks-over-bottle_fun", nil];
     
     int x = arc4random() % [urlChoices count];
     
     [_webAlertView loadURL:[urlChoices objectAtIndex:x]];
}

@end
