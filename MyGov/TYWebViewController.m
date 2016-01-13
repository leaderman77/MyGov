//
//  TYWebViewController.m
//  Yordam
//
//  Created by Tanzilya Yakshimbetova on 1/18/14.
//  Copyright (c) 2014 GS. All rights reserved.
//

#import "TYWebViewController.h"
#import "ASIHTTPRequest+YOAuthv1Request.h"
#import "AuthCredentials.h"
#import "SBJson.h"
#import "ymacros.h"
#import "ycocoaadditions.h"
#import "yoauthadditions.h"

@interface TYWebViewController ()

@end

@implementation TYWebViewController
@synthesize delegate = _delegate;
@synthesize WebView = _WebView;
@synthesize accesstoken = _accesstoken;
@synthesize tokensecret = _tokensecret;
@synthesize verifier = _verifier;
@synthesize step = _step;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
       if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f)
       {
           
        // iPhone Classic
        self = [super initWithNibName:@"TYWebView3.5" bundle:nibBundleOrNil];
    }
    else
    {
        // iPhone 5 or maybe a larger iPhone ??
        self = [super initWithNibName:@"TYWebViewController" bundle:nibBundleOrNil];
    }
    return self;

}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIView *navb;
    if ([[[UIDevice currentDevice] systemVersion] floatValue] < 7.0f) {
        navb = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        [self.WebView setFrame:CGRectMake(0, 44, 320, [[UIScreen mainScreen] applicationFrame].size.height-44)];
    }
    else
    {
        navb = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 64)];
        [self.WebView setFrame:CGRectMake(0, 64, 320, [[UIScreen mainScreen] applicationFrame].size.height-64)];
    }
    
    [navb setBackgroundColor:[UIColor colorWithRed:39.0/255.0 green:187.0/255.0 blue:230.0/255.0 alpha:1.0f]];
    UIButton *backBTN = [[UIButton alloc] initWithFrame:CGRectMake(0, navb.frame.size.height-30, 40, 18)];
    
    [backBTN setImage:[UIImage imageNamed:@"navbar_icon_back"] forState:UIControlStateNormal];
    [backBTN addTarget:self action:@selector(Cancel:) forControlEvents:UIControlEventTouchUpInside];
    [navb addSubview:backBTN];
    UILabel *LSetting= [[UILabel alloc] initWithFrame:CGRectMake(130,  navb.frame.size.height-31, 60, 20)];
    [LSetting setText:@"ID.UZ"];
    [LSetting setFont:[UIFont boldSystemFontOfSize:20.0]];
    [LSetting setTextColor:[UIColor whiteColor]];
    [LSetting setBackgroundColor:[UIColor clearColor]];
    [navb addSubview:LSetting];
    [self.view addSubview:navb];
    
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"https://id.uz/oauth/request_token"]];
    request.delegate = self; // указываем что мы будем обрабатывать ответ
    [request setRequestMethod:@"POST"]; // тип запроса POST
    // вызываем функцию подготовки запроса, которая добавит нужные параметры в url
    [request prepareOAuthv1AuthorizationHeaderUsingConsumerKey:kLinkedInKey
                                             consumerSecretKey:kLinkedInSecret
                                                         token:nil
                                                   tokenSecret:nil
                                               signatureMethod:YOAuthv1SignatureMethodHMAC_SHA1
                                                         realm:nil
                                                      verifier:nil
                                                      callback:@"http://globalsolutions.uz/mygov/callback"]; // линк нашего приложения
    self.step = @"0"; // это первый шаг
    // [request setDownloadProgressDelegate:self.progr];
    NSLog(@"<<<<<<<<<<<<<<<<<<<<<<<<<<<REQUEST %@ ", request.description);
    [request startAsynchronous];

}

-(IBAction)Cancel:(id)sender
{
    [TYSingleton getinstance].IDUZclick = @"";
    
    [self.WebView stopLoading];
    [self dismissViewControllerAnimated:YES completion:^{}];

}

- (void)requestFailed:(ASIHTTPRequest *)request {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                     message:@"Проверьте подключение к интернету"
                                                    delegate:nil
                                           cancelButtonTitle:@"OK"
                                           otherButtonTitles:nil];
    
    [alert show];
    [TYSingleton getinstance].IDUZclick = @"";
    [self dismissViewControllerAnimated:YES completion:^{}];
}

- (void)webView:(IMTWebView *)_webView didReceiveResourceNumber:(int)resourceNumber totalResources:(int)totalResources {
    if (resourceNumber>0)
    {
        [self.progres setHidden:NO];
    }
    [self.progres setProgress:((float)resourceNumber) / ((float)totalResources)];
    if (resourceNumber == totalResources) {
        _webView.resourceCount = 0;
        _webView.resourceCompletedCount = 0;
        [self.progres setProgress:1.0f animated:YES];
        [self.progres setHidden:YES];
    }
}


- (void)requestFinished:(ASIHTTPRequest *)request {
    
    NSDictionary *params = [request.responseString decodedUrlencodedParameters];
    NSLog(@"PARAMS: %@", params);
    self.accesstoken = [params objectForKey:YOAuthv1OAuthTokenKey];
    self.tokensecret = [params objectForKey:YOAuthv1OAuthTokenSecretKey];
    NSLog(@"OAthToken : %@", [params objectForKey:@"oauth_token"]);
    NSLog(@"OAthTokenS : %@", [params objectForKey:@"oauth_token_secret"]);
    [TYSingleton getinstance].oauth_token = [params objectForKey:@"oauth_token"];
    [TYSingleton getinstance].oauth_token_secret = [params objectForKey:@"oauth_token_secret"];
     if (self.accesstoken && self.tokensecret) {
        if ([self.step isEqualToString:@"0"]) {
            NSString *url = [NSString stringWithFormat:@"https://www.id.uz/users/login?token=%@&oauth_token_secret=%@&oauth_callback_confirmed=true&redirect=http://globalsolutions.uz/mygov/callback", self.accesstoken, self.tokensecret];
            NSMutableURLRequest *r = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
            [self.WebView loadRequest:r];
            
        } else {
            // если шаг не первый, то завершаем процесс авторизации
            [TYSingleton getinstance].IDUZclick = @"iduz";
            [self.delegate authViewControllerDidFinish:self];
            [self dismissViewControllerAnimated:YES completion:^{}];
        }
    }
    
}

- (void)viewDidUnload
{
    [self setWebView:nil];
    [super viewDidUnload];
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillDisappear:(BOOL)animated
{
    //[[NSURLCache sharedURLCache] removeAllCachedResponses];


}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - UIWebViewDelegate


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url = request.URL;
    NSString *s = [url absoluteString];
    NSString *host = [url host];
    NSDictionary *params = [s queryParameters];
    
    if ([request.allHTTPHeaderFields objectForKey:@"Accept-Language"]) {
        NSLog(@"YES!");
        host = @"globalsolutions.uz";
    }
    NSLog(@"PARAMS INCOME # : %@", params);
    // если загружаемый урл принадлежит нашему приложению
    //NSLog(@"HOST: %@", host);
    if ([host isEqualToString:@"globalsolutions.uz"]) { //globalsolutions.uz
        NSDictionary *params = [s queryParameters];
        NSLog(@"PARAMS : %@", params);
        // проверяем не заприщен ли доступ
        if ([params objectForKey:@"error"] == nil) {
            // ## Срабатывает если нажали "Разрешить"
            NSLog(@"Разрешили");
            self.verifier = [params objectForKey:YOAuthv1OAuthVerifierKey]; // сохраняем верификационный код
            NSLog(@"PARAMS WITH VERIFIER: %@", params);
            ASIHTTPRequest *r = [ASIHTTPRequest requestWithURL:[NSURL URLWithString:@"https://id.uz/oauth/access_token"]];
            [r setRequestMethod:@"POST"];
            r.delegate = self;
            // отправляем запрос с авторизации наших токенов
            
            [r prepareOAuthv1AuthorizationHeaderUsingConsumerKey:kLinkedInKey
                                               consumerSecretKey:kLinkedInSecret
                                                           token:self.accesstoken
                                                     tokenSecret:self.tokensecret
                                                 signatureMethod:YOAuthv1SignatureMethodHMAC_SHA1
                                                           realm:nil
                                                        verifier:self.verifier
                                                        callback:nil];
            self.step = @"1"; //дальше пошел второй шаг
            [r startAsynchronous];
        } else {
            NSLog(@"Не разрешили");
            // ## Срабатывает если Не Разрешили!
            NSString *deniedMsg = [NSString stringWithFormat:@"Authorize denied: %@", [params objectForKey:@"error"]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[self class] description]
                                                             message:deniedMsg
                                                            delegate:nil
                                                   cancelButtonTitle:@"OK"
                                                   otherButtonTitles:nil];
            [alert show];
                        
            [self dismissViewControllerAnimated:YES completion:^{
            }];
        }

        return NO;
    }
    
    return YES;
}





@end
