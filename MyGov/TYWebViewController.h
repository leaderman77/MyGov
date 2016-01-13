//
//  TYWebViewController.h
//  Yordam
//
//  Created by Tanzilya Yakshimbetova on 1/18/14.
//  Copyright (c) 2014 GS. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ydefines.h"
#import "TYSingleton.h"
#import "ASIHTTPRequest.h"
#import "IMTWebView.h"

@class TYWebViewController;
@protocol AuthViewControllerDelegate
- (void)authViewControllerDidFinish:(TYWebViewController *)controller;
@end

@interface TYWebViewController : UIViewController <UIWebViewDelegate, ASIHTTPRequestDelegate , IMTWebViewProgressDelegate>

@property (weak, nonatomic) IBOutlet IMTWebView *WebView;
@property (assign, nonatomic) id<AuthViewControllerDelegate> delegate;
@property (copy, nonatomic) NSString *accesstoken;
@property (copy, nonatomic) NSString *tokensecret;
@property (copy, nonatomic) NSString *verifier;
@property (copy, nonatomic) NSString *step; // нужен что бы в будующем понимать на каком шаге авторизации мы находимся


@property (weak, nonatomic) IBOutlet UIProgressView *progres;

@end
