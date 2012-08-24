//
//  TWLExternalURLView.m
//  WebAlertView
//
//  Created by Tristan Lopes on 24/08/12.
//  Copyright (c) 2012 Tristan Lopes. All rights reserved.
//

#import "TWLExternalURLView.h"

@implementation TWLExternalURLView

@synthesize webView=_webView, urlString=_urlString;

#pragma mark -
#pragma mark Initialization

- (TWLExternalURLView *)initWithframe:(CGRect)frame
{
    if (self = [super init])
    {
		// Create webview with requested frame size
        //self = (ExternalVideoView*)[[UIWebView alloc] initWithFrame:frame];
        self = (TWLExternalURLView*)[[UIView alloc] initWithFrame:frame];
        _urlString=nil;
	}
    
    return self;
    
}

- (TWLExternalURLView *)initWithStringAsURL:(NSString *)urlString frame:(CGRect)frame;
{
    
    if (self = [super init])
    {
		// Create webview with requested frame size
        self = (TWLExternalURLView*)[[UIView alloc] initWithFrame:frame];
        
        [self loadURL:urlString];
	}
    
    return self;
    
}

#pragma mark -
#pragma mark functions

- (void)loadURL:(NSString *)urlString{
    
    _urlString=urlString;
    
    if(_webView!=nil){
        [_webView removeFromSuperview];
        _webView = nil;
    }
    
    if(_btnLink!=nil){
        [_btnLink removeFromSuperview];
        _btnLink = nil;
    }
    
    if([urlString rangeOfString:@"youtube"].length > 0 || [urlString rangeOfString:@"youtu"].length > 0){
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
        _webView.delegate=self;
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        if ([currSysVer compare:@"5.0" options:NSNumericSearch] != NSOrderedAscending) {
            _webView.scrollView.scrollsToTop=NO;
        }else{
            for (UIView *subview in [_webView subviews]) {
                if ([subview isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *scrollView = (UIScrollView *)subview;
                    scrollView.scrollsToTop=NO;
                }
            }
        }
        [self addSubview:_webView];
        
        NSString *youTubeVideoHTML = @"<html><head>\
        <body style=\"margin:0\">\
        <embed id=\"yt\" src=\"%@\" type=\"application/x-shockwave-flash\" \
        width=\"%0.0f\" height=\"%0.0f\"></embed>\
        </body></html>";
        
        // Populate HTML with the URL and requested frame size
        NSString *html = [NSString stringWithFormat:youTubeVideoHTML, urlString, self.frame.size.width, self.frame.size.height];
        
        // Load the html into the webview
        [_webView loadHTMLString:html baseURL:nil];
    }else if([urlString rangeOfString:@"vimeo"].length > 0){
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
        _webView.delegate=self;
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        if ([currSysVer compare:@"5.0" options:NSNumericSearch] != NSOrderedAscending) {
            _webView.scrollView.scrollsToTop=NO;
        }else{
            for (UIView *subview in [_webView subviews]) {
                if ([subview isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *scrollView = (UIScrollView *)subview;
                    scrollView.scrollsToTop=NO;
                }
            }
        }
        [self addSubview:_webView];
        
        int pos=-1;
        
        for(int i=[urlString length]-1; i>0 && pos==-1; i--){
            unichar c = [urlString characterAtIndex:i];
            
            if([[NSString stringWithFormat:@"%C", c] isEqualToString:@"/"]){
                pos=i;
            }
        }
        
        NSString *videoID = [urlString substringFromIndex:pos+1];
        
        NSString *html = [NSString stringWithFormat:@"<html>"
                          @"<head>"
                          @"<meta name = \"viewport\" content =\"initial-scale = 1.0, user-scalable = no, width = %0.0f\"/></head>"
                          @"<frameset border=\"0\">"
                          @"<frame src=\"http://player.vimeo.com/video/%@?title=0&amp;byline=0&amp;portrait=1&amp;autoplay=1\" width=\"%0.0f\" height=\"%0.0f\" frameborder=\"0\"></frame>"
                          @"</frameset>"
                          @"</html>", self.frame.size.width, videoID, self.frame.size.width, self.frame.size.height];
        
        [_webView loadHTMLString:html baseURL:nil];
    }else if([urlString rangeOfString:@"dailymotion"].length > 0){
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
        _webView.delegate=self;
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        if ([currSysVer compare:@"5.0" options:NSNumericSearch] != NSOrderedAscending) {
            _webView.scrollView.scrollsToTop=NO;
        }else{
            for (UIView *subview in [_webView subviews]) {
                if ([subview isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *scrollView = (UIScrollView *)subview;
                    scrollView.scrollsToTop=NO;
                }
            }
        }
        [self addSubview:_webView];
        
        NSArray *folderSplit = [urlString componentsSeparatedByString:@"/"];
        NSString *idDailymotion=nil;
        
        if([folderSplit count]>0){
            int i=0;
            for(NSString *str in folderSplit){
                if([str isEqualToString:@"video"]){
                    i++; // we need the next thingy
                    break;
                }
                
                i++;
            }
            
            NSArray *idSplit = [[folderSplit objectAtIndex:i ] componentsSeparatedByString:@"_"];
            
            if([idSplit count]>0){
                idDailymotion=[idSplit objectAtIndex:0];
            }
            
        }
        
        NSString *dailyHTML = @"<html><head>\
        <body style=\"margin:0\">\
        <iframe frameborder=\"0\" width=\"%0.0f\" height=\"%0.0f\" src=\"http://www.dailymotion.com/embed/video/%@\"></iframe>\
        </body></html>";
        
        // Populate HTML with the URL and requested frame size
        NSString *html = [NSString stringWithFormat:dailyHTML, self.frame.size.width, self.frame.size.height, idDailymotion];
        
        // Load the html into the webview
        [_webView loadHTMLString:html baseURL:nil];
    }else if([TWLExternalURLView isVideo:urlString]){
        
        
        
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,0,self.frame.size.width, self.frame.size.height)];
        _webView.delegate=self;
        NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
        if ([currSysVer compare:@"5.0" options:NSNumericSearch] != NSOrderedAscending) {
            _webView.scrollView.scrollsToTop=NO;
        }else{
            for (UIView *subview in [_webView subviews]) {
                if ([subview isKindOfClass:[UIScrollView class]]) {
                    UIScrollView *scrollView = (UIScrollView *)subview;
                    scrollView.scrollsToTop=NO;
                }
            }
        }
        [self addSubview:_webView];
        
        NSString *embedHTML = @"\
        <html><head>\
        <style type=\"text/css\">\
        body {\
        background-color: transparent;\
        color: white;\
        }\
        </style>\
        </head><body style=\"margin:0\">\
        <iframe src=\"%@\" \
        width=\"%0.0f\" height=\"%0.0f\"></iframe>\
        </body></html>";
        NSString *html = [NSString stringWithFormat:embedHTML, urlString, self.frame.size.width, self.frame.size.height];
        
        [_webView.scrollView setScrollEnabled:NO];
        [_webView loadHTMLString:html baseURL:nil];
    }else{
        
        // in this example this will probably not play friendly with a UIAlertView
        
        _btnLink = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        _btnLink.frame=CGRectMake(0,0,self.frame.size.width, self.frame.size.height);
        [_btnLink setTitle:urlString forState:UIControlStateNormal];
        [_btnLink addTarget:self action:@selector(openLink) forControlEvents:UIControlEventTouchUpInside];
        _btnLink.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        [self addSubview:_btnLink];
    }
}

#pragma mark -
#pragma mark Externals

+(bool)isVideo:(NSString*)url{
    if(url!=nil){
        if([url rangeOfString:@"youtube"].length > 0
           || [url rangeOfString:@"youtu"].length > 0
           || [url rangeOfString:@"vimeo"].length > 0
           || [url rangeOfString:@"dailymotion"].length > 0
           || [url rangeOfString:@".m4v"].length > 0
           || [url rangeOfString:@".avi"].length > 0
           || [url rangeOfString:@".mov"].length > 0
           || [url rangeOfString:@".mpg"].length > 0
           || [url rangeOfString:@".mp4"].length > 0
           || [url rangeOfString:@".3gp"].length > 0){
            return YES;
        }
    }
    
    return NO;
}

@end
