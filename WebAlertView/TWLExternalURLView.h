//
//  TWLExternalURLView.h
//  WebAlertView
//
//  Created by Tristan Lopes on 24/08/12.
//  Copyright (c) 2012 Tristan Lopes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TWLExternalURLView : UIView <UIWebViewDelegate>
{
    UIWebView *_webView;
    
    UIButton *_btnLink;
    NSString *_urlString;
}

@property (nonatomic,retain) UIWebView *webView;
@property (nonatomic,retain) NSString *urlString;

- (TWLExternalURLView *)initWithframe:(CGRect)frame;
- (TWLExternalURLView *)initWithStringAsURL:(NSString *)urlString frame:(CGRect)frame;

- (void)loadURL:(NSString*)urlString;

+(bool)isVideo:(NSString*)url;

@end
