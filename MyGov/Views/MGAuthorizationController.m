//
//  MGAuthorizationController.m
//  MyGov
//
//  Created by Alpha on 26.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGAuthorizationController.h"
#import "MGMainMenuController.h"
#import "MGAppDelegate.h"

@interface MGAuthorizationController () {
    
    UIView *chooseLangView;
    UIButton *authButton;
    
    int doneCount;
    
    CustomIOS7AlertView *alertView;
    TYWebViewController *myWebView;
    
    NSMutableDictionary *userData;
}

@end

@implementation MGAuthorizationController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Authorization View";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    //NSLog(@"CALL NUMBER: %@", callNumber);
    // After choosing language
    // Background image
    UIImageView* bgImage;
    if(IsIphone5)
    {
        bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 568)];
        bgImage.image = [UIImage imageNamed:@"bgIphone5@2x.png"];
        bgImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.view addSubview:bgImage];
        //your stuff
    }
    else
    {
        bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0-[TYSingleton getinstance].insetYOrigin, 320, 480)];
        bgImage.image = [UIImage imageNamed:@"bg_.png"];
        bgImage.contentMode = UIViewContentModeScaleAspectFit;
        
        [self.view addSubview:bgImage];
        //your stuff
    }
    
    

    
    NSLog(@"#### Verson #### %@", [[UIDevice currentDevice] systemVersion]);
    if (SYSTEM_VERSION_LESS_THAN(@"7.0")) {
        //NSLog(@"YESSs");
    }
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"6.1")) {
        //NSLog(@"Greatrer ");
    }

    
    // Main Logo
    UIImageView* logo = [[UIImageView alloc] init];
    logo.image = [UIImage imageNamed:@"mainLogo.png"];
    logo.contentMode = UIViewContentModeCenter;
    
    logo.frame = CGRectMake((self.view.frame.size.width/2 - [[UIImage imageNamed:@"mainLogo.png"] size].width/2),
                            (self.view.frame.size.height/2- [[UIImage imageNamed:@"mainLogo.png"] size].height/2),
                            [[UIImage imageNamed:@"mainLogo.png"] size].width,
                            [[UIImage imageNamed:@"mainLogo.png"] size].height);
    
    [self.view addSubview:logo];
    
    [UIView transitionWithView:logo
                      duration:1.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        logo.frame = CGRectMake((self.view.frame.size.width/2 - [[UIImage imageNamed:@"mainLogo.png"] size].width/2),
                                                (self.view.frame.size.height/2- [[UIImage imageNamed:@"mainLogo.png"] size].height/2)-50,
                                                [[UIImage imageNamed:@"mainLogo.png"] size].width,
                                                [[UIImage imageNamed:@"mainLogo.png"] size].height);
                    } completion:nil];
    
    // Authorization Button
    authButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width/2-254/2,
                                                                     self.view.frame.size.height/2+43,
                                                                     254,
                                                                      43)];
    authButton.alpha = 0;
    
    [UIView transitionWithView:authButton
                      duration:1.0f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        authButton.alpha = 1;
                    } completion:nil];
    
    [authButton setBackgroundImage:[UIImage imageNamed:@"btn.png"] forState:UIControlStateNormal];
    [authButton setBackgroundImage:[UIImage imageNamed:@"btn_click.png"] forState:UIControlStateHighlighted];
    
    NSString *authTitle = [TSLanguageManager localizedString:@"AUTH_ID_BUTTON"];
    [authButton setTitle:authTitle forState:UIControlStateNormal];
    // Deploy
    [authButton addTarget:self action:@selector(IDUZ_Login:) forControlEvents:UIControlEventTouchUpInside];
    // Testing
    //[authButton addTarget:self action:@selector(pushedButtonWithID:) forControlEvents:UIControlEventTouchUpInside];
    
    //NSLog(@"FONT: %@", authButton.titleLabel.font);
    
    [self.view addSubview:authButton];
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    NSLog(@"Check Language: %@", [NSString stringWithFormat:@"%@", [defaults objectForKey:isitFirstLunch]]);
    // is it first lunch?
    if ([defaults objectForKey:isitFirstLunch] == NULL) {
        
        // Choose language View //
        chooseLangView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //[chooseLangView setAlpha:1];
        //[chooseLangView setBackgroundColor:[UIColor blackColor]];
        
        UIImageView *bgLang = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        bgLang.image = [UIImage imageNamed:@"fon.png"];
        [bgLang setAlpha:0.8f];
        
        [chooseLangView insertSubview:bgLang atIndex:0];
        
        [self.view addSubview:chooseLangView];
        [self.view bringSubviewToFront:chooseLangView];
        
        // Buttons to choose
        UIImage* buttonImage = [[UIImage imageNamed:@"btn.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, -1, 10)];
        UIImage* buttonImageHL = [[UIImage imageNamed:@"btn_click.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, -3, 10)];
        
        // Create a custom buttom
        UIButton *uzBut = [UIButton buttonWithType:UIButtonTypeCustom];
        uzBut.frame = CGRectMake(chooseLangView.frame.size.width/2-180/2,
                                 chooseLangView.frame.size.height/2-43/1.3,
                                 180, 43);
        [uzBut setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [uzBut setBackgroundImage:buttonImageHL forState:UIControlStateHighlighted];
        [uzBut setTitle:@"O'zbek tili" forState:UIControlStateNormal];
        [uzBut setTitle:@"O'zbek tili" forState:UIControlStateHighlighted];
        [uzBut addTarget:self action:@selector(UZLanguageClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        //Add it to view - if it is a view controller self.view
        [chooseLangView addSubview:uzBut];
        
        UIButton* ruBut = [UIButton buttonWithType:UIButtonTypeCustom];
        ruBut.frame = CGRectMake(chooseLangView.frame.size.width/2-180/2,
                                 chooseLangView.frame.size.height/2+43/1.3,
                                 180, 43);
        [ruBut setBackgroundImage:buttonImage forState:UIControlStateNormal];
        [ruBut setBackgroundImage:buttonImageHL forState:UIControlStateHighlighted];
        [ruBut setTitle:@"Русский" forState:UIControlStateNormal];
        [ruBut setTitle:@"Русский" forState:UIControlStateHighlighted];
        [ruBut addTarget:self action:@selector(RULanguageClicked:) forControlEvents:UIControlEventTouchUpInside];
        
        [chooseLangView addSubview:ruBut];
    }
    
    self.categoriesList = [[NSMutableArray alloc] init];
    self.subCategoriesList = [[NSMutableArray alloc] init];
    self.scopeList = [[NSMutableArray alloc] init];
    self.visibilityList = [[NSMutableArray alloc] init];
    self.typeList = [[NSMutableArray alloc] init];
    self.answerTypeList = [[NSMutableArray alloc] init];
    
}

-(void)loadAllData {
    // Requests
    
    // get categories
    [self getCategories];
    // get sub categories
    [self getSubCategories];
    // get scopes (step 3)
    [self getScopes];
    // get history list
    //[self getHistoryList];
    //[self performSelector:@selector(getHistoryList) withObject:nil afterDelay:1.0];
    
    
    alertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [alertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [alertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [alertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertViewIn, int buttonIndex) {
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)UZLanguageClicked:(UIButton *)button
{
    NSLog(@"UZ Choosed!");
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"uz" forKey:isitFirstLunch];
    [defaults synchronize];
    
    [TSLanguageManager setSelectedLanguage:@"uz"];
    
    [chooseLangView removeFromSuperview];
    
    NSString *authTitle = [TSLanguageManager localizedString:@"AUTH_ID_BUTTON"];
    [authButton setTitle:authTitle forState:UIControlStateNormal];
}


-(void)RULanguageClicked:(UIButton *)button
{
    NSLog(@"RU Choosed!");
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:@"ru" forKey:isitFirstLunch];
    [defaults synchronize];
    
    [TSLanguageManager setSelectedLanguage:@"ru"];
    
    [chooseLangView removeFromSuperview];
    
    NSString *authTitle = [TSLanguageManager localizedString:@"AUTH_ID_BUTTON"];
    [authButton setTitle:authTitle forState:UIControlStateNormal];
}

-(void)pushedButtonWithID:(UIButton *)button {
    //[self dismissViewControllerAnimated:NO completion:^{
        //MGMainMenuController *mc = [[MGMainMenuController alloc] init];
        
        //[mc loadAllData];
        
        //[self.navigationController pushViewController:mc animated:YES];
        //[self.mainDelegate loadAllData];
    //}];
    
    
    [self loadAllData];
    
    //[UIView beginAnimations:@"transition" context:nil];
    //[UIView setAnimationDuration:0.3];
    //[self.navigationController pushViewController:mc animated:YES];
    
    //[UIView commitAnimations];
    NSLog(@"Pushed!");
}


- (void)loginFailed
{
    NSLog(@"Login Failed!");
}

- (IBAction)IDUZ_Login:(id)sender {
    MGAppDelegate * appDelegate = (MGAppDelegate *) [[UIApplication sharedApplication] delegate];
    [appDelegate updateInterfaceWithReachability:appDelegate.hostReach];
    
    if (appDelegate.netStatus != NotReachable) {
        //myWebView = nil;
        myWebView = [[TYWebViewController alloc] initWithNibName:@"TYWebViewController"
                                                                                bundle:nil];
        myWebView.delegate = self;
        
        
        [self presentViewController:myWebView animated:YES completion:^{}];
        NSLog(@"WebView Pushed Here!");
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Ошибка"
                                                        message:@"Проверьте подключение к интернету"
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


- (void)authViewControllerDidFinish:(TYWebViewController *)controller {
    self.accesstoken = controller.accesstoken;
    self.tokensecret = controller.tokensecret;
    //self.accesstoken = @"e3ed8e40c279885177547b9539617750";
    //self.tokensecret = @"d7fa43a9c18f82b610207945e1fdc46e";
    dataforc = [[NSMutableData alloc] initWithCapacity:0];
    NSString *urlAsString = @"https://my.gov.uz/mobileapi/identification";
//    NSString *urlAsString = @"http://saidazim.my.dev.gov.uz/mobileapi/identification";
    
    NSURL *url = [NSURL URLWithString:urlAsString];
    NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:url];
    [urlRequest setTimeoutInterval:30.0f];
    [urlRequest setHTTPMethod:@"POST"];
    NSMutableString *body = [[NSMutableString alloc] init];
    
    [body appendString:[NSString stringWithFormat:@"token=%@&token_secret=%@&", self.accesstoken, self.tokensecret]];
    [urlRequest setHTTPBody:[body dataUsingEncoding:NSUTF8StringEncoding]];
    connec = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
    [connec start];
    NSLog(@"Trace URL: %@", url);
    NSLog(@"Trace TOKENS: AT:%@  ST:%@", self.accesstoken, self.tokensecret);
}

-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSLog(@"ne poluchilos :( ");
}

-(void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:dataforc options:NSJSONReadingAllowFragments error:&error];
    if ([jsonObject isKindOfClass:[NSDictionary class]]){
        NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
        NSLog(@"Autorization: %@", deserializedDictionary);
        if ([[deserializedDictionary objectForKey:@"status"] isEqualToString:@"success"])
        {
            [TYSingleton getinstance].authtype = @"iduz";
            [TYSingleton getinstance].IDUZToken = self.accesstoken;
            [TYSingleton getinstance].token_secret = self.tokensecret;
            //self.myTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f
              //                                              target:self
                //                                          selector:@selector(tick:)
                  //                                        userInfo:nil
                    //                                       repeats:NO];
            [self loadAllData];
            [TYSingleton getinstance].userPrivateData = [deserializedDictionary mutableCopy];
            //NSString *theMan = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"gender"];
            //NSLog(@"SUCCESS MAAFUCKA %@", [TYSingleton getinstance].userPrivateData);
            //NSLog(@"SUCCESS MAAFUCKA %@", theMan);
        } else if ([[deserializedDictionary objectForKey:@"status"] isEqualToString:@"error"]){
            
            if ([[[deserializedDictionary objectForKey:@"results"] objectAtIndex:0] isEqualToString:@"name"] ||
                [[[deserializedDictionary objectForKey:@"results"] objectAtIndex:0] isEqualToString:@"email"] ||
                [[[deserializedDictionary objectForKey:@"results"] objectAtIndex:0] isEqualToString:@"phone"] ||
                [[[deserializedDictionary objectForKey:@"results"] objectAtIndex:0] isEqualToString:@"gender"] ||
                [[[deserializedDictionary objectForKey:@"results"] objectAtIndex:0] isEqualToString:@"passport_sn"] ||
                [[[deserializedDictionary objectForKey:@"results"] objectAtIndex:0] isEqualToString:@"passport_issued"] ||
                [[[deserializedDictionary objectForKey:@"results"] objectAtIndex:0] isEqualToString:@"passport_issued_date"] ||
                [[[deserializedDictionary objectForKey:@"results"] objectAtIndex:0] isEqualToString:@"passport_address"] ||
                [[[deserializedDictionary objectForKey:@"results"] objectAtIndex:0] isEqualToString:@"passport_exp"]) {
                
                
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Аккаунт не заполнен полностью." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [errorAlert show];
            } else {
                UIAlertView *errorAlert = [[UIAlertView alloc] initWithTitle:@"Ошибка" message:@"Ну удалось авторизоваться в системе." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
                
                [errorAlert show];
            }
            
        }
    }
    NSLog(@"DID_FINISH");
}

-(IBAction)tick:(id)sender
{
    if ([[TYSingleton getinstance].authtype isEqualToString:@"iduz"])
    {
        if (![self.presentedViewController isBeingDismissed]) {
            if ([self.myTimer isValid]) {
                [self.myTimer invalidate];
            }
            [indicator stopAnimating];
            [TYSingleton getinstance].IDUZclick = @"";
            [self dismissViewControllerAnimated:YES completion:^{}];
        }
    }
}


-(void) viewWillAppear:(BOOL)animated
{
    if ([[TYSingleton getinstance].IDUZclick isEqualToString:@"iduz"])
    {
        /*
        indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
        CGRect sc = [[UIScreen mainScreen ] applicationFrame ];
        indicator.center = CGPointMake(sc.size.width/2, sc.size.height/2);
        
        [indicator setColor:[UIColor blackColor]];
        
        [indicator setHidesWhenStopped:YES];
        [self.view addSubview:indicator];
        [self.view bringSubviewToFront:indicator];
        [indicator startAnimating];
         */
    }
    else
    {
        NSLog(@"Another Stuff!");
    }
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    if (connection == connec)
    {
        [dataforc appendData:data];
        
    }
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
         //NSLog(@"#### Categories response ####: %@",jsons);
         
         //NSLog(@"JSON Cat: %@", jsons);
         for (NSDictionary *obj in jsons) {
             NSString *name = [obj objectForKey:@"name_ru"];
             DLog(@"Name: %@", name);
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
         //NSLog(@"#### Sub categories response ####: %@",jsons);
         
         //NSLog(@"JSON SubCat: %@", jsons);
         for (NSDictionary *obj in jsons) {
             [self.subCategoriesList addObject:obj];
         }
         [TYSingleton getinstance].step2Body = self.subCategoriesList;
         //NSLog(@"LIST2: %@", self.subCategoriesList);
         
         NSMutableArray *arrWithCategories = [[NSMutableArray alloc] init];
         self.selectionsList = [[NSMutableArray alloc] init];
         NSMutableArray *allCatIDs = [[NSMutableArray alloc] init];
         NSMutableArray *allSubDict = [[NSMutableArray alloc] init];
         int num = 0;
         
         for (int i=0; i < [[[TYSingleton getinstance] step2Headers] count]; i++) {
             //NSLog(@"MCat: %@", [[[TYSingleton getinstance]step2Headers] objectAtIndex:i]);
             [allCatIDs addObject:[[[TYSingleton getinstance]step2Headers] objectAtIndex:i]];
             NSMutableArray *arr = [[NSMutableArray alloc] init]; //WithObjects:
             NSMutableArray *arrID = [[NSMutableArray alloc] init];
             //[[[[TYSingleton getinstance] step2Headers] objectAtIndex:i] objectForKey:@"name_ru"], nil];
             NSMutableArray *selArr = [[NSMutableArray alloc] init];
             
             for (int j=0; j < [self.subCategoriesList count]; j++) {
                 NSString *cat = [NSString stringWithFormat:@"%@",[[[[TYSingleton getinstance] step2Headers] objectAtIndex:i] objectForKey:@"id"]];
                 NSString *body_id = [NSString stringWithFormat:@"%@",[[[[TYSingleton getinstance] step2Body] objectAtIndex:j] objectForKey:@"cat_id"]];
                 if ([cat isEqualToString:body_id]) {
                     [arr addObject:[NSString stringWithFormat:@"%@",[[[[TYSingleton getinstance] step2Body] objectAtIndex:j] objectForKey:@"name_ru"]]];
                     [selArr addObject:@"NO"];
                     
                     [arrID addObject:[NSString stringWithFormat:@"%@",[[[[TYSingleton getinstance] step2Body] objectAtIndex:j] objectForKey:@"id"]]];
                     
                     //NSLog(@"Sub Cat: %@", body_id);
                     //NSLog(@"ID of sub: %@", [NSString stringWithFormat:@"%@",[[[[TYSingleton getinstance] step2Body] objectAtIndex:j] objectForKey:@"id"]]);
                 }
             }
             [selArr addObject:@"NO"];
             //[arr addObject:[[[[TYSingleton getinstance] step2Headers] objectAtIndex:i] objectForKey:@"name_ru"]];
             [arrWithCategories addObject:arr];
             [allSubDict addObject:arrID];
             //arrWithCategories = arr;
             [self.selectionsList addObject:selArr];
             num++;
         }
         //NSLog(@"### LIST OF CATS: %@", arrWithCategories);
         //NSLog(@"### LIST OF SELS: %i, %i", [[self.selectionsList objectAtIndex:0] count], [[arrWithCategories objectAtIndex:0] count]);
         [TYSingleton getinstance].step2Body = arrWithCategories;
         [TYSingleton getinstance].selectedRows = self.selectionsList;
         [TYSingleton getinstance].allCatID = allCatIDs;
         [TYSingleton getinstance].allSubID = allSubDict;
         [self allLoadedCkeck:1];
         DLog(@"### AllCatIDs : %@", allCatIDs);
         DLog(@"### AllSubDict : %@", allSubDict);
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
         //NSLog(@"#### Scope response ####: %@",jsons);
         
         //NSLog(@"JSON Cat: %@", jsons);
         for (NSDictionary *obj in jsons) {
             NSString *name = [obj objectForKey:@"name_ru"];
             NSString *p_id = [obj objectForKey:@"field_id"];
             //NSLog(@"Name: %@ : %@", p_id, name);
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
         
         //NSLog(@"SCOPES: %@, %@, %@, %@", self.scopeList, self.visibilityList, self.typeList, self.answerTypeList);
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
        [NSTimer scheduledTimerWithTimeInterval:0.2 target:self selector:@selector(canGotoMainMenu) userInfo:nil repeats:NO];
    }
}

-(void)getHistoryList {
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://saidazim.my.dev.gov.uz/"]];
    
        AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://my.gov.uz/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    DLog(@"#### History Call ####: oa: %@ %@", self.accesstoken,
          self.tokensecret);
    NSDictionary *parameters = @{@"token" : self.accesstoken,
                                 @"token_secret" : self.tokensecret,
                                 @"language":[TSLanguageManager selectedLanguage]};
    
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
//                                                            path:@"http://saidazim.my.dev.gov.uz/mobileapi/getUserAppeals"
//                                                      parameters:parameters];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"https://my.gov.uz/mobileapi/getRequestList"
                                                      parameters:parameters];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         //NSLog(@"Response History: %@",jsons);
         
         //NSLog(@"JSON Cat: %@", jsons);
         for (NSDictionary *obj in jsons) {
             NSLog(@"HS: %@", obj);
         }
     }
         failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         DLog(@"error: %@", [operation error]);
     }];
    
    [operation start];
}

-(void)canGotoMainMenu {
    MGMainMenuController *mc = [[MGMainMenuController alloc] init];
    [self.navigationController pushViewController:mc animated:YES];
}

@end
