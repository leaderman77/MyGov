//
//  MGAuthorizationController.h
//  MyGov
//
//  Created by Alpha on 26.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TYWebViewController.h"
#import "CustomIOS7AlertView.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"

@protocol mainMenuRequestsDelegate <NSObject>
-(void)loadAllData;
@end

@interface MGAuthorizationController : UIViewController <AuthViewControllerDelegate, NSURLConnectionDataDelegate,NSURLConnectionDelegate, mainMenuRequestsDelegate, CustomIOS7AlertViewDelegate>
{
    NSURLConnection *connec;
    NSMutableData *dataforc;
    UIActivityIndicatorView *indicator;
}

@property (assign) id <mainMenuRequestsDelegate> mainDelegate;


@property (strong, nonatomic) NSString *accesstoken;
@property (strong, nonatomic) NSString *tokensecret;
@property (nonatomic, retain) NSTimer *myTimer;


@property (strong, nonatomic) NSMutableArray *categoriesList;
@property (strong, nonatomic) NSMutableArray *subCategoriesList;
@property (strong, nonatomic) NSMutableArray *selectionsList;

@property (strong, nonatomic) NSMutableArray *scopeList;
@property (strong, nonatomic) NSMutableArray *visibilityList;
@property (strong, nonatomic) NSMutableArray *typeList;
@property (strong, nonatomic) NSMutableArray *answerTypeList;

//- (IBAction)IDUZ_down:(id)sender;
- (IBAction)IDUZ_Login:(id)sender;

-(void)canGotoMainMenu;

@end
