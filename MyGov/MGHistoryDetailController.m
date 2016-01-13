//
//  MGHistoryDetailController.m
//  MyGov
//
//  Created by Alpha on 28.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGHistoryDetailController.h"

#define alertErrorNewTag 10
#define alertSuccessTag 20

@interface MGHistoryDetailController ()  {
    UILabel *leftLabel;
    UILabel *rightLabel;
    
    float offset_6;
    float offset_7;
    float offset_openBtn;
    
    int satisfactionValue;
    
    CustomIOS7AlertView *myAlertView;
    DYRateView *rateView;
    BOOL allowRate;
    float currentRate;
    
    UIImageView *imageContainer;
    
    UIScrollView *scroll;
    float tempY;
    float yOpen;
    
    UIButton *imagePreviewBox;
}

@end

@implementation MGHistoryDetailController

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
    
    allowRate = false;
    
    UIImageView *navBar = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0-[TYSingleton getinstance].insetY, 320, 66)];
    navBar.image = [UIImage imageNamed:@"navbar_.png"];
    
    [self.view addSubview:navBar];
    
    
    UILabel *navBarLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, titlesOffsetY, 280, 65)];
    navBarLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
    navBarLabel.lineBreakMode = NSLineBreakByWordWrapping;
    navBarLabel.numberOfLines = 2;
    navBarLabel.text = self.recTitle; //@"История обращений";
    navBarLabel.textAlignment = NSTextAlignmentCenter;
    navBarLabel.textColor = [UIColor whiteColor];
    navBarLabel.backgroundColor = [UIColor clearColor];
    
    [navBar addSubview:navBarLabel];
    
    
    UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.frame = CGRectMake(5, 28-[TYSingleton getinstance].insetY, 45, 30);
    
    [[backButton imageView] setContentMode: UIViewContentModeCenter];
    [backButton setImage:[UIImage imageNamed:@"arrow.png"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(back:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:backButton];
    
    UIButton *callButton = [UIButton buttonWithType:UIButtonTypeCustom];
    callButton.frame = CGRectMake(self.view.frame.size.width-50, 28-[TYSingleton getinstance].insetY, 45, 30);
    
    [[callButton imageView] setContentMode: UIViewContentModeCenter];
    [callButton setImage:[UIImage imageNamed:@"call_service.png"] forState:UIControlStateNormal];
    [callButton addTarget:self action:@selector(getCall:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:callButton];
    
    scroll = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 66, self.view.frame.size.width, self.view.frame.size.height-66+21)];
    
    [self.view addSubview:scroll];
    scroll.contentSize = CGSizeMake(scroll.frame.size.width, 500);
    // Left Labels
    float fromOffsetY = 5.0f; //64.0f;
    
    for (int i=0; i < 10; i++) {
        if (i == 0) {
            leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, fromOffsetY-[TYSingleton getinstance].insetY, 120, 35)];
        } else if (i > 1) {
            leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, leftLabel.frame.origin.y+30, 120, 35)];
        }
        if (i == 6) {
            offset_6 = leftLabel.frame.origin.y;
        }
        if (i == 7) {
            leftLabel.frame = CGRectMake(10, leftLabel.frame.origin.y+35, 120, 35);
            //offset_7 = leftLabel.frame.origin.y;
        }
        if (i == 8) {
            leftLabel.frame = CGRectMake(10, leftLabel.frame.origin.y+60, 150, 35);
        }
        if (i == 9) {
            leftLabel.frame = CGRectMake(10, leftLabel.frame.origin.y+20, 150, 35);
        }
        
        leftLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        leftLabel.textColor = RGB(86, 86, 86);
        leftLabel.textAlignment = NSTextAlignmentLeft;
        leftLabel.tag = i*10;
        leftLabel.backgroundColor = [UIColor clearColor];
        
        switch (i) {
            case 1:
                leftLabel.text = @"Имя:";
                break;
            case 2:
                leftLabel.text = @"Телефон:";
                break;
            case 3:
                leftLabel.text = @"Сфера:";
                break;
            case 4:
                leftLabel.text = @"Вид:";
                break;
            case 5:
                leftLabel.text = @"Статус:";
                break;
            case 6:
                leftLabel.text = @"Тема:";
                break;
            case 7:
                leftLabel.text = @"Текст:";
                break;
            case 8:
                leftLabel.text = @"Ответ Гос. Органа:";
                break;
            case 9:
                leftLabel.text = @"Оценить ответ:";
                break;
            default:
                break;
        }
        
        //[self.view addSubview:leftLabel];
        [scroll addSubview:leftLabel];
    }
    
    tempY = 0;
    
    // Right labels
    for (int i=0; i < 9; i++) {
        if (i == 0) {
            rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-280, fromOffsetY, 270, 35)];
        } else if (i > 1) {
            rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.view.frame.size.width-250,
                                                                   rightLabel.frame.origin.y+30, 240, 35)];
        }
        rightLabel.font = [UIFont fontWithName:@"HelveticaNeue" size:16];
        rightLabel.textColor = RGB(39, 179, 238);
        rightLabel.textAlignment = NSTextAlignmentRight;
        rightLabel.backgroundColor = [UIColor clearColor];
        rightLabel.tag = i*100;
        
        // extra positions
        if (i == 6) {
            rightLabel.frame = CGRectMake(25, offset_6+27, 285, 35);
            rightLabel.textAlignment = NSTextAlignmentLeft;
        } else if (i == 7) {
            rightLabel.frame = CGRectMake(25, offset_7+25, 285, 35);
            rightLabel.textAlignment = NSTextAlignmentLeft;
            offset_openBtn = rightLabel.frame.origin.y;
        } else if (i == 8) {
            rightLabel.frame = CGRectMake(25, rightLabel.frame.origin.y+10, 290, 35);
            rightLabel.textAlignment = NSTextAlignmentLeft;
        }
        
        UILabel *leftL = (UILabel *)[self.view viewWithTag:(i+1)*10];
        
        
        
        switch (i) {
            case 1:
                rightLabel.text = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"name"];
                break;
            case 2:
                rightLabel.text = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"phone"];
                break;
            case 3:
            {
                [[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"fields"] enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
                    if(idx==7)
                    {
                        rightLabel.text  = obj[@"value"];
                    }
                }];
                
                DLog( @" arr %@",[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"fields"]);
                //rightLabel.text = [NSString stringWithFormat:@"%@",[[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"fields"] objectForKey:@"171"]];
                break;
            }
                
            case 4:
            {
                [[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"fields"] enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
                    if(idx==8)
                    {
                        rightLabel.text  = obj[@"value"];
                    }
                }];
            }
                //rightLabel.text = [NSString stringWithFormat:@"%@",[[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"fields"] objectForKey:@"170"]];
                break;
            case 5:
                rightLabel.lineBreakMode = NSLineBreakByWordWrapping;
                rightLabel.numberOfLines = 0;
                rightLabel.text = [[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"status"];
                if ([[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"status"] isEqualToString:@"draft"]) {
                    rightLabel.text = @"Черновик";
                } else if ([[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"status"] isEqualToString:@"new"]) {
                    rightLabel.text = @"Новое";
                } else if ([[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"status"] isEqualToString:@"process"]) {
                    rightLabel.text = @"В обработке";
                } else if ([[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"status"] isEqualToString:@"processed"]) {
                    rightLabel.text = @"Обработано";
                } else if ([[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"status"] isEqualToString:@"notactive"]) {
                    rightLabel.text = @"Аннулировано";
                }
                
                break;
            case 6:
            {
                [[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"fields"] enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
                    if(idx==10)
                    {
                        rightLabel.text  = obj[@"value"];
                    }
                }];
            
               // rightLabel.text = [NSString stringWithFormat:@"%@",[[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"fields"] objectForKey:@"169"]];
                rightLabel.numberOfLines = 0;
                [rightLabel sizeToFit];
                offset_7 = rightLabel.frame.origin.y;
                leftL.frame = CGRectMake(leftL.frame.origin.x, rightLabel.frame.size.height+rightLabel.frame.origin.y, leftL.frame.size.width, leftL.frame.size.height);
            }
            break;
            case 7:
            {
                [[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"fields"] enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL *stop) {
                    if(idx==11)
                    {
                        rightLabel.text  = obj[@"value"];
                    }
                }];

                //rightLabel.text = [NSString stringWithFormat:@"%@",[[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"fields"] objectForKey:@"293"]];
                rightLabel.numberOfLines = 0;
                [rightLabel sizeToFit];
                leftL = (UILabel *)[self.view viewWithTag:i*10];
                rightLabel.frame = CGRectMake(rightLabel.frame.origin.x, leftL.frame.origin.y+leftL.frame.size.height-8, rightLabel.frame.size.width, rightLabel.frame.size.height);
                tempY = rightLabel.frame.origin.y + rightLabel.frame.size.height;
            }
                break;
            case 8:
                leftL = (UILabel *)[self.view viewWithTag:i*10];
                
                if ([[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"comment_gos"] != nil) {
                    rightLabel.text = [[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"comment_gos"];
                    //rightLabel.text = @"asdadslkfj hsfk jahsdfjlkashfj sdasd ad ahd jad as ahdkjashkshak hadkash a ja daskjh akjsa a";
                } else {
                    rightLabel.text = @"";
                }
                rightLabel.numberOfLines = 0;
                [rightLabel sizeToFit];
                
                leftL.frame = CGRectMake(leftL.frame.origin.x, tempY+5, leftL.frame.size.width, leftL.frame.size.height);
                rightLabel.frame = CGRectMake(rightLabel.frame.origin.x, leftL.frame.origin.y+leftL.frame.size.height-8, rightLabel.frame.size.width, rightLabel.frame.size.height);
                
                leftL = (UILabel *)[self.view viewWithTag:90];
                leftL.frame = CGRectMake(leftL.frame.origin.x, rightLabel.frame.size.height+rightLabel.frame.origin.y+40, leftL.frame.size.width, leftL.frame.size.height);
                
                tempY = leftL.frame.origin.y+leftL.frame.size.height;
                yOpen = rightLabel.frame.size.height+rightLabel.frame.origin.y+5;

                break;
            default:
                break;
        }
        
        //[self.view addSubview:rightLabel];
        [scroll addSubview:rightLabel];
    }
    
    // buttos to open //
    UIButton *openButton = [[UIButton alloc] initWithFrame:CGRectMake(7.5, yOpen+5, 305, 33)];
    [openButton setBackgroundImage:[UIImage imageNamed:@"btn_h.png"] forState:UIControlStateNormal];
    [openButton setBackgroundImage:[UIImage imageNamed:@"btn_click_h.png"] forState:UIControlStateHighlighted];
    [openButton setTitle:@"Открыть вложение" forState:UIControlStateNormal];
    [openButton setTitle:@"Открыть вложение" forState:UIControlStateHighlighted];
    [openButton addTarget:self action:@selector(openFileButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [scroll addSubview:openButton];
    
    // set up the Rater
    [self setUpEditableRateView];
}

-(void)back:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)getCall:(UIButton *)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:callNumber]];
}

-(void)openFileButton:(UIButton *)sender {
    NSLog(@"Open File was clicked");
    
    [self loadImageData];
}


- (void)setUpEditableRateView {
    rateView = [[DYRateView alloc] initWithFrame:CGRectMake(0, leftLabel.frame.origin.y+30, self.view.bounds.size.width, 23) fullStar:[UIImage imageNamed:@"star_a.png"] emptyStar:[UIImage imageNamed:@"star_b.png"]];
    rateView.padding = 20;
    rateView.alignment = RateViewAlignmentCenter;
    rateView.editable = YES;
    rateView.delegate = self;
    
    if ([[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"satisfaction"] != nil) {
        
        if(![[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"satisfaction"] isKindOfClass:[NSNull class]]){
            rateView.rate = [[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"satisfaction"] floatValue];
            currentRate = [[[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"satisfaction"] floatValue];
        }
        else
            {
                rateView.rate = 0;
                currentRate = 0;
            }
    } else {
        rateView.rate = 0;
    }
    
    allowRate = YES;
    
    
    [scroll setContentSize:CGSizeMake(scroll.frame.size.width, rateView.frame.origin.y+rateView.frame.size.height+40)];
    [scroll addSubview:rateView];
}

#pragma mark - DYRateViewDelegate

- (void)rateView:(DYRateView *)rateView changedToNewRate:(NSNumber *)rate {
    NSLog(@"%@", [NSString stringWithFormat:@"Rate: %d", rate.intValue]);
    satisfactionValue = rate.intValue;
    if (rate.intValue > 0 && rate.intValue <= 5 && allowRate) {
        [self loadAllData];
    }
}

-(void)loadAllData {
    // Requests
    
    // get history
    [self evaluateAppeal];
    
    myAlertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [myAlertView setContainerView:[self createDemoView]];
    
    // Modify the parameters
    [myAlertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [myAlertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView tag]);
        [alertView close];
    }];
    
    [myAlertView setUseMotionEffects:true];
    
    // And launch the dialog
    [myAlertView show];
}


-(void)loadImageData {
    // Requests
    
    // get history
    [self downloadImageInBackground];
    
    myAlertView = [[CustomIOS7AlertView alloc] init];
    
    // Add some custom content to the alert view
    [myAlertView setContainerView:[self createImageDemoView]];
    
    // Modify the parameters
    [myAlertView setDelegate:self];
    
    // You may use a Block, rather than a delegate.
    [myAlertView setOnButtonTouchUpInside:^(CustomIOS7AlertView *alertView, int buttonIndex) {
        NSLog(@"Block: Button at position %d is clicked on alertView %d.", buttonIndex, [alertView tag]);
        //[alertView close];
    }];
    
    [myAlertView setUseMotionEffects:true];
    
    // And launch the dialog
    [myAlertView show];
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2-(200/2)+30, 200, 100)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [imageView setImage:[UIImage imageNamed:@"box_al.png"]];
    
    [demoView addSubview:imageView];
    
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 40)];
    tLabel.text = @"Обработка оценки...";
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

- (UIView *)createImageDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height/2-(200/2)+30, 200, 100)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [imageView setImage:[UIImage imageNamed:@"box_al.png"]];
    
    [demoView addSubview:imageView];
    
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 40)];
    tLabel.text = @"Загрузка файла...";
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

-(void)evaluateAppeal {
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://saidazim.my.dev.gov.uz/"]];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://my.gov.uz/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSLog(@"#### History Call ####: oa: %@ %@", [TYSingleton getinstance].oauth_token,
          [TYSingleton getinstance].oauth_token_secret);
    NSDictionary *parameters = @{@"token" : [TYSingleton getinstance].oauth_token,
                                 @"token_secret" : [TYSingleton getinstance].oauth_token_secret,
                                 @"request_id" : [[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"id"],
                                 @"satisfaction" : [NSString stringWithFormat:@"%i", satisfactionValue],
                                 @"comment" : @"That's pretty awesome app!"};
    
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
//                                                            path:@"http://saidazim.my.dev.gov.uz/mobileapi/setEvaluateAppeal"
//                                                      parameters:parameters];
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"https://my.gov.uz/mobileapi/setEvaluateAppeal"
                                                      parameters:parameters];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         NSLog(@"Evaluate Appeal: %@",jsons);
         
         if ([[jsons objectForKey:@"status"] isEqualToString:@"success"]) {
             
             UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:@"Ваша оценка принята успешно!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alertSuccess.tag = alertSuccessTag;
             currentRate = rateView.rate;
             [alertSuccess show];
         } else if ([[jsons objectForKey:@"status"] isEqualToString:@"error"] && [[jsons objectForKey:@"error_message"] isEqualToString:@"the status of the current appeal is not processed"]){
             
             UIAlertView *alertErrorNew = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:@"К сожалению нельзя оценить не обработанное обращение!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alertErrorNew.tag = alertErrorNewTag;
             
             [alertErrorNew show];
         } else if ([[jsons objectForKey:@"status"] isEqualToString:@"error"] && [[jsons objectForKey:@"error_message"] isEqualToString:@"this appeal appreciated"]){
             
             UIAlertView *alertErrorNew = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:@"Вы уже оценили это обращение!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alertErrorNew.tag = alertErrorNewTag;
             
             [alertErrorNew show];
         }
     }
            failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", [operation error]);
     }];
    
    [operation start];
}

-(void)openReceivedFile {
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://saidazim.my.dev.gov.uz/"]];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://my.gov.uz/"]];
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSLog(@"File from ID: %@", [[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"id"]);
    
    NSDictionary *parameters = @{@"token" : [TYSingleton getinstance].oauth_token,
                                 @"token_secret" : [TYSingleton getinstance].oauth_token_secret,
                                 @"request_id" : [[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"id"]
                                 };
    
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
//                                                            path:@"http://saidazim.my.dev.gov.uz/mobileapi/getAnswerFile"
//                                                      parameters:parameters];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"https://my.gov.uz/mobileapi/getAnswerFile"
                                                      parameters:parameters];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         NSLog(@"Get File for Appeal: %@",jsons);
         
         if ([[jsons objectForKey:@"status"] isEqualToString:@"success"]) {
             
             UIAlertView *alertSuccess = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:@"Файл успешно принят!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alertSuccess.tag = alertSuccessTag;
             
             [alertSuccess show];
         } else if ([[jsons objectForKey:@"status"] isEqualToString:@"error"] && [[jsons objectForKey:@"error_message"] isEqualToString:@"the requested file does not exist"]){
             
             UIAlertView *alertErrorNew = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:@"Файл отсутствует!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alertErrorNew.tag = alertErrorNewTag;
             
             [alertErrorNew show];
         } else if ([[jsons objectForKey:@"status"] isEqualToString:@"error"] && [[jsons objectForKey:@"error_message"] isEqualToString:@"the request status not processed"]){
             
             UIAlertView *alertErrorNew = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:@"Обращение еще не обработано!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alertErrorNew.tag = alertErrorNewTag;
             
             [alertErrorNew show];
         } else if ([[jsons objectForKey:@"status"] isEqualToString:@"error"] && [[jsons objectForKey:@"error_message"] isEqualToString:@"the requested file does not exist"]){
             
             UIAlertView *alertErrorNew = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:@"Файл отсутствует!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             alertErrorNew.tag = alertErrorNewTag;
             
             [alertErrorNew show];
         }
     }
            failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", [operation error]);
     }];
    
    [operation start];
}

- (void)downloadImageInBackground {
    
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://saidazim.my.dev.gov.uz/"]];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://my.gov.uz/"]];
    
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    NSLog(@"File from ID: %@", [[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"id"]);
    
    NSDictionary *parameters = @{@"token" : [TYSingleton getinstance].oauth_token,
                                 @"token_secret" : [TYSingleton getinstance].oauth_token_secret,
                                 @"request_id" : [[[self.fields objectForKey:@"data"] objectForKey:@"results"] objectForKey:@"id"]
                                 };
    
//    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
//                                                            path:@"http://saidazim.my.dev.gov.uz/mobileapi/getAnswerFile"
//                                                      parameters:parameters];
    
    NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
                                                            path:@"https://my.gov.uz/mobileapi/getAnswerFile"
                                                      parameters:parameters];
    
    AFImageRequestOperation *operation = [AFImageRequestOperation imageRequestOperationWithRequest:request imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image){
        
        NSLog(@"Image Here %@", image);
        [myAlertView close];
        
        imagePreviewBox = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        //[imageView setFrame:CGRectMake(10, 105, 300, 300)];
        [imagePreviewBox setContentMode:UIViewContentModeScaleAspectFit];
        [imagePreviewBox setBackgroundColor:[UIColor colorWithRed:10/255.0 green:0/255.0 blue:0/255.0 alpha:0.8]];
        [imagePreviewBox setImage:image forState:UIControlStateNormal];
        [imagePreviewBox addTarget:self action:@selector(removeImage) forControlEvents:UIControlEventTouchUpInside];
        
        [self.view addSubview:imagePreviewBox];
        
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error){
        [myAlertView close];
        UIAlertView *alertErrorNew = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:@"Файл отсутствует или не активен!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        alertErrorNew.tag = alertErrorNewTag;
        
        [alertErrorNew show];
        NSLog(@"Image Failure %@", error);
    }];
    
    [operation start];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (buttonIndex == 0 && alertView.tag == alertErrorNewTag) {
        //
        [myAlertView close];
        allowRate = NO;
        rateView.rate = currentRate;
        allowRate = YES;
    }
    if (buttonIndex == 0 && alertView.tag == alertSuccessTag) {
        //
        [myAlertView close];
    }
    NSLog(@"Alert Clicked!");
}

-(void)removeImage {
    [imagePreviewBox removeFromSuperview];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
