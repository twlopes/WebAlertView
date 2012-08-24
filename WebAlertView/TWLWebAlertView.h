//
//  WebAlertView.h
//  WebAlertView
//
//  Created by Tristan Lopes on 24/08/12.
//  Copyright (c) 2012 Tristan Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TWLExternalURLView.h"
#import "TWLVideoViewController.h"

@interface TWLWebAlertView : UIAlertView{
    TWLExternalURLView *_externalURLView;
    
    UIWindow *_windowVideo;
    TWLVideoViewController *_vcVideo;
    
    bool _didModifyHeight;
}

@property (nonatomic, retain) TWLExternalURLView *externalURLView;

- (void)loadURL:(NSString*)url;
- (void)removeYouTubeNotifications;

@end
