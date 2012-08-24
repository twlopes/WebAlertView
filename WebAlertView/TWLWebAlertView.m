//
//  WebAlertView.m
//  WebAlertView
//
//  Created by Tristan Lopes on 24/08/12.
//  Copyright (c) 2012 Tristan Lopes. All rights reserved.
//

#import "TWLWebAlertView.h"

@implementation TWLWebAlertView

@synthesize externalURLView=_externalURLView;

- (id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _didModifyHeight=NO;
        
        [self videoNotifications];
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    //http://mobile.tutsplus.com/tutorials/iphone/ios-sdk-uialertview-custom-graphics/
    // makes it pretty
    
    
    // Drawing code
    // context
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // base shape
    CGRect activeBounds = self.bounds;
    CGFloat cornerRadius = 7.5f;
    CGFloat inset = 6.5f;
    CGFloat originX = activeBounds.origin.x + inset;
    CGFloat originY = activeBounds.origin.y + inset;
    CGFloat width = activeBounds.size.width - (inset*2.0f);
    CGFloat height = activeBounds.size.height - (inset*2.0f);
    
    CGRect bPathFrame = CGRectMake(originX, originY, width, height);
    CGPathRef path = [UIBezierPath bezierPathWithRoundedRect:bPathFrame cornerRadius:cornerRadius].CGPath;
    
    // fill and outer drop shadow
    CGContextAddPath(context, path);
    
    CGContextSetFillColorWithColor(context, [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f].CGColor);
    
    
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 6.0f, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor);
    CGContextDrawPath(context, kCGPathFill);
    
    // clip context
    CGContextSaveGState(context); //Save Context State Before Clipping To "path"
    CGContextAddPath(context, path);
    CGContextClip(context);
    
    // draw gradient
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    size_t count = 3;
    CGFloat locations[3] = {0.0f, 0.57f, 1.0f};
    
    CGFloat components[12] =
    {
        20.0f/255.0f, 110.0f/255.0f, 210.0f/255.0f, 1.0f,     //1
        10.0f/255.0f, 80.0f/255.0f, 150.0f/255.0f, 1.0f,     //2
        0.0f/255.0f, 50.0f/255.0f, 100.0f/255.0f, 1.0f      //3
    };
    
    CGGradientRef gradient = CGGradientCreateWithColorComponents(colorSpace, components, locations, count);
    CGPoint startPoint = CGPointMake(activeBounds.size.width * 0.5f, 0.0f);
    CGPoint endPoint = CGPointMake(activeBounds.size.width * 0.5f, activeBounds.size.height);
    CGContextDrawLinearGradient(context, gradient, startPoint, endPoint, 0);
    CGColorSpaceRelease(colorSpace);
    CGGradientRelease(gradient);
    
    
    
    // hatched background
    //CGFloat buttonOffset = 92.5f; //Offset buttonOffset by half point for crisp lines
    
    if(self.numberOfButtons>0){
        CGFloat buttonOffset = activeBounds.size.height - 66.5f;
        CGContextSaveGState(context); //Save Context State Before Clipping "hatchPath"
        CGRect hatchFrame = CGRectMake(0.0f, buttonOffset, activeBounds.size.width, (activeBounds.size.height - buttonOffset+1.0f));
        CGContextClipToRect(context, hatchFrame);
        
        CGFloat spacer = 4.0f;
        int rows = (activeBounds.size.width + activeBounds.size.height/spacer);
        CGFloat padding = 0.0f;
        CGMutablePathRef hatchPath = CGPathCreateMutable();
        for(int i=1; i<=rows; i++) {
            CGPathMoveToPoint(hatchPath, NULL, spacer * i, padding);
            CGPathAddLineToPoint(hatchPath, NULL, padding, spacer * i);
        }
        CGContextAddPath(context, hatchPath);
        CGPathRelease(hatchPath);
        CGContextSetLineWidth(context, 1.0f);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.15f].CGColor);
        CGContextDrawPath(context, kCGPathStroke);
        CGContextRestoreGState(context); //Restore Last Context State Before Clipping "hatchPath"
        
        // line
        CGMutablePathRef linePath = CGPathCreateMutable();
        CGFloat linePathY = (buttonOffset - 1.0f);
        CGPathMoveToPoint(linePath, NULL, 0.0f, linePathY);
        CGPathAddLineToPoint(linePath, NULL, activeBounds.size.width, linePathY);
        CGContextAddPath(context, linePath);
        CGPathRelease(linePath);
        CGContextSetLineWidth(context, 1.0f);
        CGContextSaveGState(context); //Save Context State Before Drawing "linePath" Shadow
        CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.6f].CGColor);
        CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 1.0f), 0.0f, [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:0.2f].CGColor);
        CGContextDrawPath(context, kCGPathStroke);
        CGContextRestoreGState(context); //Restore Context State After Drawing "linePath" Shadow
    }
    
    // inner shadow
    CGContextAddPath(context, path);
    CGContextSetLineWidth(context, 3.0f);
    CGContextSetStrokeColorWithColor(context, [UIColor colorWithRed:210.0f/255.0f green:210.0f/255.0f blue:210.0f/255.0f alpha:1.0f].CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 0.0f), 6.0f, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:1.0f].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
    
    // redraw path to avoid pixelation
    CGContextRestoreGState(context); //Restore First Context State Before Clipping "path"
    CGContextAddPath(context, path);
    CGContextSetLineWidth(context, 3.0f);
    
    CGContextSetStrokeColorWithColor(context, [UIColor whiteColor].CGColor);
    CGContextSetShadowWithColor(context, CGSizeMake(0.0f, 0.0f), 0.0f, [UIColor colorWithRed:0.0f/255.0f green:0.0f/255.0f blue:0.0f/255.0f alpha:0.1f].CGColor);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)layoutSubviews{
    
    // if the alert view has no buttons (and we haven't changed the height yet), remove the bottom bit
    if(self.numberOfButtons==0 && _didModifyHeight==NO){
        CGRect frame = self.frame;
        frame.size.height-=55;
        self.frame=frame;
        
        _didModifyHeight=YES;
    }
    
    // pretty-ness
    for (UIView *subview in self.subviews){ //Fast Enumeration
        if ([subview isMemberOfClass:[UIImageView class]]) {
            subview.hidden = YES; //Hide UIImageView Containing Blue Background
        }
        
        if ([subview isMemberOfClass:[UILabel class]]) { //Point to UILabels To Change Text
            UILabel *label = (UILabel*)subview; //Cast From UIView to UILabel
            label.textColor = [UIColor whiteColor];
            label.shadowColor = [UIColor blackColor];
            label.shadowOffset = CGSizeMake(0.0f, 1.0f);
        }
    }
    
    // if we notice there is a movie here, make sure to fit it and center the alertview
    for(UIView *view in self.subviews){
        if([view isKindOfClass:[TWLExternalURLView class]]){
            if(self.frame.size.height<=view.frame.size.height){
                CGRect frame = self.frame;
                frame.size.height+=view.frame.size.height;
                frame.origin.y-=view.frame.size.height/2;
                self.frame=frame;
            }
        }
    }
    
    // pretty-fication does strange things to the buttons
    for(UIView *view in self.subviews){
        if([view isKindOfClass:[UIButton class]]){
            CGRect frame = view.frame;
            frame.origin.y=self.frame.size.height-60;
            view.frame=frame;
        }
    }
}

#pragma mark - Video

- (void)loadURL:(NSString *)url{
    // hardcoded spacing if we can't dynamically figure it out
    float xStart=12.5+3;
    float yOffset=27.5;
    float xOffset=12.5+3;
    
    for(UIView *view in self.subviews){
        // if there is a visible label make sure to put the video underneath
        if([view isKindOfClass:[UILabel class]]){
            if(view.frame.size.height>5){
                xStart = view.frame.origin.x+view.frame.size.height+6;
            }
        }
        
        // if there are buttons, fit out video in the alert view with a slightly smaller alignment
        if([view isKindOfClass:[UIButton class]]){
            yOffset = view.frame.size.height+27.5;
            xOffset = view.frame.origin.x+3;
            
            break;
        }
    }
    
    // we add our video here
    if(_externalURLView==nil){
        
        // create a new window
        _windowVideo = [[UIWindow alloc] initWithFrame:CGRectMake(0,0,[UIScreen mainScreen].applicationFrame.size.width,[UIScreen mainScreen].applicationFrame.size.height)];
        _windowVideo.windowLevel = UIWindowLevelAlert;
        
        // add our view controller to the window
        _vcVideo = [[TWLVideoViewController alloc] init];
        _windowVideo.rootViewController=_vcVideo;
        
        _externalURLView = [[TWLExternalURLView alloc] initWithFrame:CGRectMake(xOffset, xStart, self.frame.size.width-(xOffset*2), /*alertView.frame.size.height-yOffset*/150)];
        
        _externalURLView.layer.cornerRadius=5;
        _externalURLView.layer.masksToBounds=YES;
        [self addSubview:_externalURLView];
        
        // do some stuff to make sure the buttons are in the correct spot
        for(UIView *view in self.subviews){
            if([view isKindOfClass:[UIButton class]]){
                CGRect frame = view.frame;
                frame.origin.y += _externalURLView.frame.size.height;
                view.frame = frame;
            }
        }
        
        // make sure the alertview is centered vertically
        CGRect frame = self.frame;
        frame.size.height+=_externalURLView.frame.size.height;
        frame.origin.y-=_externalURLView.frame.size.height/2;
        self.frame=frame;
        
        // listen for notifications
        [self youtubeNotifications];
    }
    
    [_externalURLView loadURL:url];
    
    [self layoutIfNeeded];
}

-(void)videoStarted:(NSNotification *)notification{
    // get the UIMoviePlayerController
    UIViewController *view = [notification object];
    
    // remove any lingering views in our video player
    for(UIView *v in _vcVideo.view.subviews){
        [v removeFromSuperview];
    }
    
    // put the video player view in our video player
    [view.view removeFromSuperview];
    [_vcVideo.view addSubview:view.view];
    
    _windowVideo.rootViewController=nil;
    _windowVideo.rootViewController=_vcVideo;
    
    [_windowVideo makeKeyAndVisible];
    
    _windowVideo.hidden = NO;
}


-(void)videoFinished:(NSNotification *)notification{
    _windowVideo.hidden=YES;
    
    [_externalURLView removeFromSuperview];
    [self addSubview:_externalURLView];
    [_externalURLView loadURL:_externalURLView.urlString];
}

- (void)windowNowHidden:(NSNotification*)notification{
    [self dismissWithClickedButtonIndex:666 animated:NO];
}


- (void)windowNowVisible:(NSNotification*)notification{
    [self show];
}

#pragma mark - Notifications

- (void)videoNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoStarted:) name:@"UIMoviePlayerControllerDidEnterFullscreenNotification" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(videoFinished:) name:@"UIMoviePlayerControllerDidExitFullscreenNotification" object:nil];
}

- (void)youtubeNotifications{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowNowVisible:) name:UIWindowDidBecomeVisibleNotification object:self.window];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(windowNowHidden:) name:UIWindowDidBecomeHiddenNotification object:self.window];
}

- (void)removeYouTubeNotifications{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeVisibleNotification object:self.window];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIWindowDidBecomeHiddenNotification object:self.window];
}

@end
