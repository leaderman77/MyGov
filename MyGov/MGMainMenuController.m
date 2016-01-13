//
//  MGMainMenuController.m
//  MyGov
//
//  Created by Alpha on 27.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGMainMenuController.h"
#import "MGSettingsController.h"
#import "MGAboutAppController.h"
#import "MGHistoryController.h"
#import "MGPostAppealController.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "TSLanguageManager.h"

@interface MGMainMenuController () {
    UIButton *btn;
    int doneCount;
    
    CustomIOS7AlertView *alertView;
    UILabel *navBarLabel;
}

@end

@implementation MGMainMenuController

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
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view setBackgroundColor:RGB(244, 244, 244)];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *navBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0-[TYSingleton getinstance].insetY, 320, 66)];
    navBar.image = [UIImage imageNamed:@"navbar_.png"];
    
    [self.view addSubview:navBar];
    
    navBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 7, 280, 65)];
    navBarLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    navBarLabel.lineBreakMode = NSLineBreakByWordWrapping;
    navBarLabel.numberOfLines = 2;
    navBarLabel.text = [TSLanguageManager localizedString:@"MAIN_TITLE_MENU"]; //@"Единый портал государственных интерактивных услуг";
    navBarLabel.textAlignment = NSTextAlignmentCenter;
    navBarLabel.textColor = [UIColor whiteColor];
    navBarLabel.backgroundColor = [UIColor clearColor];
    
    
    [navBar addSubview:navBarLabel];
    
    // add group of buttons
    int theNumberOfButtons = 7;  // -1 from the need number
    
    
    if(IsIphone5)
    {
        float theY = 120.f;
        for (int n=0; n < theNumberOfButtons; n++) {
            if (n == 0) {
                btn = [[UIButton alloc] initWithFrame:CGRectMake(15/2, theY-[TYSingleton getinstance].insetY, 305, 53)];
            } else if ( n > 1) {
                btn = [[UIButton alloc] initWithFrame:CGRectMake(15/2, btn.frame.origin.y+65, 305, 53)];
            } //else if (n > 2) {
            //btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 65*n, 305, 53)];
            //}
            //[btn setTitle:[NSString stringWithFormat:@"%i", n] forState:UIControlStateNormal];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, 250, 40)];
            label.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            
            UIImageView *mLogo = [[UIImageView alloc] initWithFrame:CGRectMake(12, 8.5, 35, 35)];
            mLogo.contentMode = UIViewContentModeCenter;
            
            switch (n) {
                case 1:
                    label.text = @"История обращений";
                    mLogo.image = [UIImage imageNamed:@"calendar.png"];
                    [btn addTarget:self action:@selector(history:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 2:
                    label.text = @"Подать обращение";
                    mLogo.image = [UIImage imageNamed:@"getMsg.png"];
                    [btn addTarget:self action:@selector(treatment:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 3:
                    label.text = @"Call центр";
                    mLogo.image = [UIImage imageNamed:@"telephone.png"];
                    [btn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 4:
                    label.text = @"О приложении";
                    mLogo.image = [UIImage imageNamed:@"info-2.png"];
                    [btn addTarget:self action:@selector(about:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 5:
                    label.text = @"Настройки";
                    mLogo.image = [UIImage imageNamed:@"settings.png"];
                    [btn addTarget:self action:@selector(settings:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 6:
                    label.text = @"Выход";
                    mLogo.image = [UIImage imageNamed:@"epigu_exit_icon.png"];
                    [btn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                default:
                    break;
            }
            
            [btn addSubview:label];
            [btn addSubview:mLogo];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_m.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_m_click.png"] forState:UIControlStateHighlighted];
            
            btn.tag = n;
            
            btn.alpha = 0;
            [self showButtonWithFadeIn:btn];
            
            [self.view addSubview:btn];
            //NSLog(@"%i", n);
        }
    }
    else
    {

        float theY = 75.f;
        for (int n=0; n < theNumberOfButtons; n++) {
            if (n == 0) {
                btn = [[UIButton alloc] initWithFrame:CGRectMake(15/2, theY-[TYSingleton getinstance].insetY, 305, 53)];
            } else if ( n > 1) {
                btn = [[UIButton alloc] initWithFrame:CGRectMake(15/2, btn.frame.origin.y+65, 305, 53)];
            } //else if (n > 2) {
            //btn = [[UIButton alloc] initWithFrame:CGRectMake(10, 65*n, 305, 53)];
            //}
            //[btn setTitle:[NSString stringWithFormat:@"%i", n] forState:UIControlStateNormal];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(55, 5, 250, 40)];
            label.font = [UIFont fontWithName:@"HelveticaNeue" size:18];
            label.textAlignment = NSTextAlignmentLeft;
            label.textColor = [UIColor whiteColor];
            label.backgroundColor = [UIColor clearColor];
            
            UIImageView *mLogo = [[UIImageView alloc] initWithFrame:CGRectMake(12, 8.5, 35, 35)];
            mLogo.contentMode = UIViewContentModeCenter;
            
            switch (n) {
                case 1:
                    label.text = @"История обращений";
                    mLogo.image = [UIImage imageNamed:@"calendar.png"];
                    [btn addTarget:self action:@selector(history:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 2:
                    label.text = @"Подать обращение";
                    mLogo.image = [UIImage imageNamed:@"getMsg.png"];
                    [btn addTarget:self action:@selector(treatment:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 3:
                    label.text = @"Call центр";
                    mLogo.image = [UIImage imageNamed:@"telephone.png"];
                    [btn addTarget:self action:@selector(call:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 4:
                    label.text = @"О приложении";
                    mLogo.image = [UIImage imageNamed:@"info-2.png"];
                    [btn addTarget:self action:@selector(about:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 5:
                    label.text = @"Настройки";
                    mLogo.image = [UIImage imageNamed:@"settings.png"];
                    [btn addTarget:self action:@selector(settings:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                case 6:
                    label.text = @"Выход";
                    mLogo.image = [UIImage imageNamed:@"epigu_exit_icon.png"];
                    [btn addTarget:self action:@selector(logout:) forControlEvents:UIControlEventTouchUpInside];
                    break;
                default:
                    break;
            }
            
            [btn addSubview:label];
            [btn addSubview:mLogo];
            
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_m.png"] forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btn_m_click.png"] forState:UIControlStateHighlighted];
            
            btn.tag = n;
            
            btn.alpha = 0;
            [self showButtonWithFadeIn:btn];
            
            [self.view addSubview:btn];
            //NSLog(@"%i", n);
        }
    }
    

    
    //NSLog(@"Space: %i", titlesOffsetY );
    
    
    /*
    self.categoriesList = [[NSMutableArray alloc] init];
    self.subCategoriesList = [[NSMutableArray alloc] init];
    self.scopeList = [[NSMutableArray alloc] init];
    self.visibilityList = [[NSMutableArray alloc] init];
    self.typeList = [[NSMutableArray alloc] init];
    self.answerTypeList = [[NSMutableArray alloc] init];
    */
    //[self loadAllData];
    

    
}

-(void)viewWillAppear:(BOOL)animated {
    DLog(@"WillApper event!");
    
    navBarLabel.text = [TSLanguageManager localizedString:@"MAIN_TITLE_MENU"];
}

-(void)viewDidDisappear:(BOOL)animated {
    //NSLog(@"Removing...");
}

-(void)loadAllData {
    // Requests
    
    // get history
    [self getHistoryList];
    
    
    alertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView tag]);
        //[alertView close];
    }];
    
    [alertView setUseMotionEffects:true];
    
    // And launch the dialog
    [alertView show];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2-(200/2)+30, 200, 100)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [imageView setImage:[UIImage imageNamed:@"box_al.png"]];
    
    [demoView addSubview:imageView];
    
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 40)];
    tLabel.text = @"Загрузка данных...";
    tLabel.textAlignment = NSTextAlignmentCenter;
    tLabel.textColor = [UIColor whiteColor];
    tLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
    tLabel.backgroundColor = [UIColor clearColor];
    
    [demoView addSubview:tLabel];
    
    UIButton *repeat = [[UIButton alloc] initWithFrame:CGRectMake(310/2 - 181/2, 145, 181, 42)];
    [repeat setTitle:@"Повторить" forState:UIControlStateNormal];
    [repeat setBackgroundImage:[UIImage imageNamed:@"btn_al.png"] forState:UIControlStateNormal];
    [repeat setBackgroundImage:[UIImage imageNamed:@"btn_al.png"] forState:UIControlStateNormal];
    [repeat.titleLabel setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    
    //[demoView addSubview:repeat];
    
    
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    spinner.frame = CGRectMake(demoView.frame.size.width/2 - 70/2, 30, 70, 70);
    //[spinner setCenter:CGPointMake(self.view.frame.size.width/2.0, self.view.frame.size.height/2.0)]; // I do this because I'm in landscape mode
    [demoView addSubview:spinner]; // spinner is not visible until started
    
    [spinner startAnimating];
    
    return demoView;
}

-(void)history:(UIButton *)sender {
    
    [self loadAllData];
}


-(void)treatment:(UIButton *)sender {
    
    if ([TYSingleton getinstance].sendOrNot)
    {
        self.postAppeal = nil;
        self.postAppeal = Nil;
        [TYSingleton getinstance].sendOrNot = NO;
    }
    
    if (self.postAppeal == nil || self.postAppeal == Nil) {
        self.postAppeal = [[MGPostAppealController alloc] init];
    }
    
    [self.navigationController pushViewController:self.postAppeal animated:YES];
}

-(void)call:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callNumber]];
}

-(void)about:(UIButton *)sender {
    MGAboutAppController *about = [[MGAboutAppController alloc] init];
    [self.navigationController pushViewController:about animated:YES];
}

-(void)settings:(UIButton *)sender {
    MGSettingsController *settings = [[MGSettingsController alloc] init];
    [self.navigationController pushViewController:settings animated:YES];
}
-(void)logout:(UIButton *)sender
{
    [TYSingleton getinstance].IDUZToken = @"";
    [TYSingleton getinstance].MyList = [[NSMutableArray  alloc] initWithCapacity:0];
    [TYSingleton getinstance].authtype = @"";
    [TYSingleton getinstance].token_secret = @"";
    [TYSingleton getinstance].currentAddress = @"";
    [TYSingleton getinstance].dictAllSph = [[NSMutableArray alloc] initWithCapacity:0];
    [TYSingleton getinstance].dictAllReg = [[NSMutableArray alloc] initWithCapacity:0];
    [TYSingleton getinstance].dictIDSph = [[NSMutableDictionary alloc] initWithCapacity:0];
    [TYSingleton getinstance].dictIDReg = [[NSMutableDictionary alloc] initWithCapacity:0];
    [TYSingleton getinstance].updateStat = @"false";
    [TYSingleton getinstance].deleteStat = @"0";
    [TYSingleton getinstance].currentAddress = @"Выбрать местоположение";
    [TYSingleton getinstance].IDUZclick = @"";
    [TYSingleton getinstance].userPrivateData = [[NSMutableDictionary alloc] init];
    [TYSingleton getinstance].allCatID = [[NSMutableArray alloc] init];
    [TYSingleton getinstance].allSubID = [[NSMutableArray alloc] init];
    [TYSingleton getinstance].allAuthorityId = [[NSMutableDictionary alloc] init];
    [TYSingleton getinstance].imageFromPhone = [[UIImage alloc] init];
    [TYSingleton getinstance].imageFromPhoneName = @"";
    
    [TYSingleton getinstance].oauth_token = @"";
    [TYSingleton getinstance].oauth_token_secret = @"";
    

    for(NSHTTPCookie *cookie in [[NSHTTPCookieStorage sharedHTTPCookieStorage] cookies]) {
        DLog(@"cookie, %@", [cookie domain]);
        if([[cookie domain] isEqualToString:@"www.id.uz"]||[[cookie domain] isEqualToString:@"id.uz"])
        {
            
            [[NSHTTPCookieStorage sharedHTTPCookieStorage] deleteCookie:cookie];
        }
    }
    
    MGAuthorizationController *auth = [[MGAuthorizationController alloc] init];
    [self.navigationController pushViewController:auth animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showButtonWithFadeIn:(UIButton *)button {
    int delayTag = button.tag;
    float delayTime = 0.0;
    
    if (delayTag == 1) {
        delayTime = 0.1;
    } else if (delayTag == 2) {
        delayTime = 0.2;
    } else if (delayTag == 3) {
        delayTime = 0.3;
    } else if (delayTag == 4) {
        delayTime = 0.4;
    } else if (delayTag == 5) {
        delayTime = 0.5;
    } else if (delayTag == 6) {
        delayTime = 0.6;
    }
    
    [UIView animateWithDuration:0.75
                          delay:delayTime
                        options:(UIViewAnimationCurveEaseOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         //[imageView setImage:image];
                         button.alpha = 1;
                     }
                     completion:nil];
}


#pragma  mark - NSConnection Methods

-(void)getCategories {
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://saidazim.my.dev.gov.uz/"]];
//    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
//                                                            path:@"http://saidazim.my.dev.gov.uz/mobileapi/getCategories"
//                                                      parameters:nil];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://my.gov.uz/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"https://my.gov.uz/mobileapi/getCategories"
                                                      parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         //         NSLog(@"response: %@",jsons);
         
         //NSLog(@"JSON Cat: %@", jsons);
         for (NSDictionary *obj in jsons) {
             //NSString *name = [obj objectForKey:@"name_ru"];
             //NSLog(@"Name: %@", name);
             [self.categoriesList addObject:obj];
             //NSString *id_obj = [obj objectForKey:@"id"];
             //NSLog(@"ID: %@", id_obj);
         }
         [TYSingleton getinstance].step2Headers = self.categoriesList;
         //NSLog(@"LIST: %@", self.categoriesList);
         [self allLoadedCkeck:1];
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         DLog(@"error: %@", [operation error]);
         
     }];
    
    [operation start];
}

-(void)getSubCategories {
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://saidazim.my.dev.gov.uz/"]];
//    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
//                                                            path:@"http://saidazim.my.dev.gov.uz/mobileapi/getAuthorities"
//                                                      parameters:nil];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://my.gov.uz/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"https://my.gov.uz/mobileapi/getAuthorities"
                                                      parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         //         NSLog(@"response: %@",jsons);
         
         //NSLog(@"JSON SubCat: %@", jsons);
         for (NSDictionary *obj in jsons) {
             [self.subCategoriesList addObject:obj];
         }
         [TYSingleton getinstance].step2Body = self.subCategoriesList;
         //NSLog(@"LIST2: %@", self.subCategoriesList);
         
         NSMutableArray *arrWithCategories = [[NSMutableArray alloc] init];
         self.selectionsList = [[NSMutableArray alloc] init];
         
         for (int i=0; i < [[[TYSingleton getinstance] step2Headers] count]; i++) {
             //NSLog(@"OBJ: %@", [[[TYSingleton getinstance]step2Headers] objectAtIndex:i]);
             NSMutableArray *arr = [[NSMutableArray alloc] init]; //WithObjects:
                                    //[[[[TYSingleton getinstance] step2Headers] objectAtIndex:i] objectForKey:@"name_ru"], nil];
             NSMutableArray *selArr = [[NSMutableArray alloc] init];
             
             for (int j=0; j < [self.subCategoriesList count]; j++) {
                 NSString *cat = [NSString stringWithFormat:@"%@",[[[[TYSingleton getinstance] step2Headers] objectAtIndex:i] objectForKey:@"id"]];
                 NSString *body_id = [NSString stringWithFormat:@"%@",[[[[TYSingleton getinstance] step2Body] objectAtIndex:j] objectForKey:@"cat_id"]];
                 if ([cat isEqualToString:body_id]) {
                     [arr addObject:[NSString stringWithFormat:@"%@",[[[[TYSingleton getinstance] step2Body] objectAtIndex:j] objectForKey:@"name_ru"]]];
                     [selArr addObject:@"NO"];
                 }
             }
             [selArr addObject:@"NO"];
             //[arr addObject:[[[[TYSingleton getinstance] step2Headers] objectAtIndex:i] objectForKey:@"name_ru"]];
             [arrWithCategories addObject:arr];
             //arrWithCategories = arr;
             [self.selectionsList addObject:selArr];
             
         }
         //NSLog(@"### LIST OF CATS: %@", arrWithCategories);
         //NSLog(@"### LIST OF SELS: %i, %i", [[self.selectionsList objectAtIndex:0] count], [[arrWithCategories objectAtIndex:0] count]);
         [TYSingleton getinstance].step2Body = arrWithCategories;
         [TYSingleton getinstance].selectedRows = self.selectionsList;
         [self allLoadedCkeck:1];
     } 
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         DLog(@"error: %@", [operation error]);
         
     }];
    
    [operation start];
}


-(void)getScopes {
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://saidazim.my.dev.gov.uz/"]];
//    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
//                                                            path:@"http://saidazim.my.dev.gov.uz/mobileapi/serviceFieldsValue"
//                                                      parameters:nil];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://my.gov.uz/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"https://my.gov.uz/mobileapi/serviceFieldsValue"
                                                      parameters:nil];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         //         NSLog(@"response: %@",jsons);
         
         //NSLog(@"JSON Cat: %@", jsons);
         for (NSDictionary *obj in jsons) {
             NSString *name = [obj objectForKey:@"name_ru"];
             NSString *p_id = [obj objectForKey:@"field_id"];
             DLog(@"Name: %@ : %@", p_id, name);
             //[self.categoriesList addObject:obj];
             //NSString *id_obj = [obj objectForKey:@"id"];
             //NSLog(@"ID: %@", id_obj);
             if ([p_id isEqualToString:@"171"]) {
                 [self.scopeList addObject:name];
             }
             if ([p_id isEqualToString:@"293"]) {
                 [self.visibilityList addObject:name];
             }
             if ([p_id isEqualToString:@"294"]) {
                 [self.typeList addObject:name];
             }
             if ([p_id isEqualToString:@"295"]) {
                 [self.answerTypeList addObject:name];
             }
         }
         [TYSingleton getinstance].step3Scopes = self.scopeList;
         [TYSingleton getinstance].step3Visibility = self.visibilityList;
         [TYSingleton getinstance].step3Type = self.typeList;
         [TYSingleton getinstance].step3AnswerType = self.answerTypeList;
         
         DLog(@"SCOPES: %@, %@, %@, %@", self.scopeList, self.visibilityList, self.typeList, self.answerTypeList);
         [self allLoadedCkeck:1];
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         DLog(@"error: %@", [operation error]);
         
     }];
    
    [operation start];
}

-(void)allLoadedCkeck:(int )number {
    doneCount += number;
    
    if (doneCount == 3) {
        DLog(@"All 3 Ready! %i", doneCount);
        [alertView close];
    }
}

-(void)getHistoryList {
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://saidazim.my.dev.gov.uz/"]];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://my.gov.uz/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    DLog(@"#### History Call ####: oa: %@ %@", [TYSingleton getinstance].oauth_token,
          [TYSingleton getinstance].oauth_token_secret);
    NSDictionary *parameters = @{@"token" : [TYSingleton getinstance].oauth_token,
                                 @"token_secret" : [TYSingleton getinstance].oauth_token_secret,
                                 @"language":[TSLanguageManager selectedLanguage]};
    
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
//                                                            path:@"http://saidazim.my.dev.gov.uz/mobileapi/getUserAppeals"
//                                                      parameters:parameters];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"https://my.gov.uz/mobileapi/getRequestList"
                                                      parameters:parameters];
    
    
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
//                                                            path:@"https://my.gov.uz/mobileapi/getUserAppeals"
//                                                      parameters:parameters];
//    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         NSLog(@"Response History: %@",jsons);
         NSLog(@"JSon count: %i", [jsons count]);
         //NSLog(@"JSON Cat: %@", jsons);
         for (NSDictionary *obj in jsons) {
             //NSLog(@"HS: %@", obj);
         }
         
         [alertView close];
         MGHistoryController *history = [[MGHistoryController alloc] init];
         
         NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
         [dic setValue:jsons forKey:@"data"];
         
         history.appealData = dic;
         
         [self.navigationController pushViewController:history animated:YES];
     }
                                     failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         DLog(@"error: %@", [operation error]);
     }];
    
    [operation start];
}


/*

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"It didn't happened! :( ");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:dataforc options:NSJSONReadingAllowFragments error:&error];
    if ([jsonObject isKindOfClass:[NSArray class]]){
        NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
        //NSLog(@"IF dict: %@", deserializedDictionary);
        for (NSDictionary *obj in deserializedDictionary) {
            NSString *name = [obj objectForKey:@"name_ru"];
            NSLog(@"%@", name);
            [self.categoriesList addObject:[NSString stringWithFormat:@"%@", name]];
            NSString *id_obj = [obj objectForKey:@"id"];
            NSLog(@"ID: %@", id_obj);
            NSString *cat = [obj objectForKey:@"cat_id"];
            NSLog(@"Cat: %@", cat);
        }
        [TYSingleton getinstance].step2Headers = self.categoriesList;
    }
    //NSLog(@"Cat list: %@", self.categoriesList);
}

-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == connec)
    {
        [dataforc appendData:data];
        
    }
}
*/



@end





