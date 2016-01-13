//
//  MGStepThird.m
//  MyGov
//
//  Created by Alexander Makshov on 07.04.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGStepThird.h"
#import "RTLabel.h"
#import "SearchDropDownView.h"
#import "MGDropDownChooser.h"
#import "TYSingleton.h"
#import "AFHTTPClient.h"

#define emptyField @"Заполните пустое поле пожалуйста!"
#define incorrectField @"Поле заполнено не верно!"
#define chooseField @"Выберите значение из таблицы!"
#define fileField @"Добавьте файл!"


@interface MGStepThird () {
    int counter;
    UIImageView *stepsBar;
    BOOL keyboardIsShown;
    
    UITextField *inputTextField;
    UITextField *activeTextField;
    UITextField *photoTextField;
    RTLabel *label;
    NSString *customText;
    NSString *placeHText;
    
    NSMutableArray *buttons;
    
    UITableView* dropTable;
    
    int temporyTag;
    int removeAlarmTag;
    
    UIImageView *customAlarm;
    UILabel *alarmLabel;
    UIImageView *triangle;
    UIImageView *triangleV;
    
    BOOL firstInit;
    
    NSMutableArray *mainSendBox;
    NSMutableDictionary *subBox;
    NSMutableArray *imageArray;
    CustomIOS7AlertView *alertView;
}

@end

static NSString *CellIdentifier = @"DropBoxIdentifier";

@implementation MGStepThird

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initAllObjects {
    self.delegate = self;
    
    [self setBackgroundColor:[UIColor whiteColor]];
    [self setOpaque:YES];
    firstInit = YES;
    
    self.tag = 7777;
    
    UIButton *removeKeyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeKeyboardBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    [removeKeyboardBtn addTarget:self action:@selector(getKeyboardOff:) forControlEvents:UIControlEventTouchUpInside];
    [removeKeyboardBtn endEditing:YES];
    
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:self.window];
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:self.window];
    keyboardIsShown = NO;
    
    [self addSubview:removeKeyboardBtn];
    
    for (int i=0; i < 8; i++) {
        if (i == 0) {
            label = [[RTLabel alloc] initWithFrame:CGRectMake(10, 0, 200, 25)];
        } else if (i > 1) {
            label = [[RTLabel alloc] initWithFrame:CGRectMake(10, label.frame.origin.y+60, 300, 25)];
        }
        label.tag = i;
        [self setTheTitle:i];
        label.backgroundColor = [UIColor clearColor];
        
        [label endEditing:YES];
        label.userInteractionEnabled = NO;
        
        [self addSubview:label];
        [label setText:customText];
    }
    
    // Input Fields
    for (int n=0; n < 8; n++) {
        if (n == 0) {
            inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 25, 300, 30)];
        } else if (n > 1) {
            inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, inputTextField.frame.origin.y+60, 300, 30)];
        }
        // set tag
        inputTextField.tag = n*100;
        
        inputTextField.returnKeyType = UIReturnKeyDone;
        [self setPlaceHolderText:n];
        inputTextField.placeholder = [self setPlaceHolderText:n]; //@"Введите Фамилию, Имя и Отчество";
        inputTextField.font = [UIFont fontWithName:@"Helvetica" size:14];
        
        [inputTextField setBackgroundColor:[UIColor whiteColor]];
        [inputTextField setBorderStyle:UITextBorderStyleLine];
        [inputTextField setTextAlignment:NSTextAlignmentLeft];
        inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        inputTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        inputTextField.opaque = YES;
        
        // left margin
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        inputTextField.leftView = paddingView;
        inputTextField.leftViewMode = UITextFieldViewModeAlways;
        
        // right margin
        UIView *paddingViewRight = [[UIView alloc] init];
        if (n == 1 || n == 2 || n == 3 || n == 6 || n == 7) {
            paddingViewRight.frame = CGRectMake(0, 0, 31, 31);
        } else {
            paddingViewRight.frame = CGRectMake(0, 0, 0, 30);
        }
        //paddingViewRight.backgroundColor = [UIColor greenColor];
        inputTextField.rightView = paddingViewRight;
        inputTextField.rightViewMode = UITextFieldViewModeAlways;
        
        inputTextField.delegate = self;
        inputTextField.clearButtonMode = UITextFieldViewModeNever;
        
        //inputTextField.rightView.backgroundColor = [UIColor redColor];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(0, -1, 31, 31); //285, 7, 13, 15);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        if (n == 6) {
            [button setImage:[UIImage imageNamed:@"folder.png"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"folder_hl.png"] forState:UIControlStateHighlighted];
        } else {
            [button setImage:[UIImage imageNamed:@"rightButtonQuad.png"] forState:UIControlStateNormal];
        }
        [[button imageView] setContentMode:UIViewContentModeCenter];
        [button addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
        if (n == 1 || n == 2 || n == 3 || n == 6 || n == 7) {
            button.tag = n*100;
            [paddingViewRight addSubview:button];
            //inputTextField
        }
        //inputTextField.rightViewMode = UITextFieldViewModeAlways;
        
        [self textFieldShouldBeginEditing:inputTextField];
        
        [self addSubview:inputTextField];
    }
    
    UIButton *sendStep = [[UIButton alloc] initWithFrame:CGRectMake(168, 430, 142, 35)];
    [sendStep setBackgroundImage:[UIImage imageNamed:@"next_step.png"] forState:UIControlStateNormal];
    [sendStep setBackgroundImage:[UIImage imageNamed:@"next_step_h.png"] forState:UIControlStateHighlighted];
    [sendStep setTitle:@"Отправить" forState:UIControlStateNormal];
    [sendStep setTitleColor:RGB(42, 182, 241) forState:UIControlStateNormal];
    [[sendStep titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [sendStep addTarget:self action:@selector(goToAndSend:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:sendStep];
    
    UIButton *prevStep = [[UIButton alloc] initWithFrame:CGRectMake(10, 430, 142, 35)];
    [prevStep setBackgroundImage:[UIImage imageNamed:@"next_step.png"] forState:UIControlStateNormal];
    [prevStep setBackgroundImage:[UIImage imageNamed:@"next_step_h.png"] forState:UIControlStateHighlighted];
    [prevStep setTitle:@"Предыдущий шаг" forState:UIControlStateNormal];
    [prevStep setTitleColor:RGB(42, 182, 241) forState:UIControlStateNormal];
    [[prevStep titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [prevStep addTarget:self action:@selector(goToThePrevStep:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:prevStep];
    
    customAlarm = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-260/2, 120, 260, 40)];
    [customAlarm setBackgroundColor:RGB(40, 40, 40)];
    //[customAlarm.layer setOpaque:YES];
    [customAlarm.layer setCornerRadius:8];
    
    customAlarm.layer.shadowColor = [UIColor blackColor].CGColor;
    customAlarm.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    customAlarm.layer.shadowRadius = 10.0;
    customAlarm.layer.shadowOpacity = 1.0;
    customAlarm.layer.masksToBounds = NO;
    customAlarm.alpha = 0.9;
    
    triangle = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"triangle_.png"]];
    triangle.frame = CGRectMake(customAlarm.frame.size.width/2-15/2, -8, 15, 8);
    [customAlarm addSubview:triangle];
    
    triangleV = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"triangle_.png"]];
    triangleV.frame = CGRectMake(customAlarm.frame.size.width/2-15/2, -8, 15, 8);
    triangleV.frame = CGRectMake(triangle.frame.origin.x, 40, triangle.frame.size.width, triangle.frame.size.height);
    triangleV.transform = CGAffineTransformMakeRotation( 180 * M_PI  / 180);
    [customAlarm addSubview:triangleV];
    triangleV.hidden = YES;
    
    alarmLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 240, 30)];
    alarmLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    alarmLabel.lineBreakMode = NSLineBreakByWordWrapping;
    alarmLabel.numberOfLines = 2;
    alarmLabel.textColor = [UIColor whiteColor];
    alarmLabel.textAlignment = NSTextAlignmentCenter;
    alarmLabel.text = @"Поле не заполнено, введите ваши данные пожалуйста!";
    alarmLabel.tag = 404;
    alarmLabel.backgroundColor = [UIColor clearColor];
    [customAlarm addSubview:alarmLabel];
    
    [self addSubview:customAlarm];
    [customAlarm setHidden:YES];
    
    
    [self endEditing:YES];
    
    //NSArray *arr = [[NSArray alloc] initWithObjects:@"aaa", @"bbb", @"ccc", @"ddd", @"eee", nil];
    self.scopesArray = [TYSingleton getinstance].step3Scopes;
    
    dropTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 300, 200)];
    [dropTable setBackgroundColor:[UIColor colorWithRed:39.0/255.0 green:187.0/255.0 blue:230.0/255.0 alpha:1.0f]];
    [dropTable setSeparatorColor:[UIColor colorWithRed:24.0/255.0 green:157.0/255.0 blue:196.0/255.0 alpha:1.0f]];
    dropTable.delegate = self;
    dropTable.dataSource = self;
    dropTable.tag = 9999;
    
    [self addSubview:dropTable];
    
    [dropTable setHidden:YES];
    
    [self endEditing:YES];
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    //[self addGestureRecognizer:tapScroll];
    firstInit = NO;
}

- (void)tapped
{
    [self endEditing:YES];
}

-(void)checkSelectedPhoto:(NSString *)string {
    NSLog(@"### Checked!!!   %@", string);
    //self.backgroundColor = [UIColor redColor];
    
    photoTextField.text = [NSString stringWithFormat:@"%@", string];
    photoTextField.layer.borderColor = [UIColor greenColor].CGColor;
}

-(void)goToAndSend:(UIButton *)sender {
    NSLog(@"Sended to Goverment!");
    
    NSLog(@"Ready to go next? ");
    BOOL shouldStop = NO;
    
    for (int i=0; i < 8; i++) {
        int num = i*100;
        UITextField *textField = (UITextField*)[self viewWithTag:num];
        
        if (num > 9) {
            //NSLog(@"Text field text  %@", textField.text);
        }
        switch (num) {
            case 100:
                if (![textField.text isEqualToString:@""]) {
                    NSLog(@"1 field is Ready!");
                } else {
                    NSLog(@"1 field isn't Good!");
                    shouldStop = YES;
                    [self setContentOffset:CGPointMake(0, 0) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:chooseField andFrame:textField.frame.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 200:
                if (![textField.text isEqualToString:@""]) {
                    NSLog(@"2 field is Ready");
                } else {
                    NSLog(@"2 field isn't Good!");
                    shouldStop = YES;
                    [self setContentOffset:CGPointMake(0, 0) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:chooseField andFrame:textField.frame.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 300:
                if (![textField.text isEqual:@""]) {
                    NSLog(@"3 field is Ready");
                } else {
                    NSLog(@"3 field isn't Good!");
                    shouldStop = YES;
                    //[self setContentOffset:CGPointMake(0, (textField.frame.origin.y)) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:chooseField andFrame:textField.frame.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 400:
                if (![textField.text isEqual:@""]) {
                    NSLog(@"4 field is Ready");
                } else {
                    NSLog(@"4 field isn't Good!");
                    shouldStop = YES;
                    //[self setContentOffset:CGPointMake(0, (textField.frame.origin.y)) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:emptyField andFrame:textField.frame.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 500:
                if (![textField.text isEqual: @""]) {
                    NSLog(@"5 field is Ready");
                } else { NSLog(@"5 field isn't Good!");   shouldStop = YES;
                    //[self setContentOffset:CGPointMake(0, (textField.frame.origin.y)) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:emptyField andFrame:textField.frame.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 600:
                if (![textField.text isEqual: @""]) {
                    NSLog(@"6 field is Ready");
                } else { NSLog(@"6 field isn't Good!");
//                    shouldStop = YES;
//                    //[self setContentOffset:CGPointMake(0, (textField.frame.origin.y)) animated:YES];
//                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
//                    [self showAlarmMessageWithText:fileField andFrame:textField.frame.origin.y];
//                    triangleV.hidden = YES;
//                    triangle.hidden = NO;
//                    removeAlarmTag = num;
                }
                break;
            case 700:
                if (![textField.text isEqual: @""]) {
                    NSLog(@"7 field is Ready");
                } else { NSLog(@"7 field isn't Good!");   shouldStop = YES;
                    //[self setContentOffset:CGPointMake(0, (textField.frame.origin.y)-40) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:chooseField andFrame:textField.frame.origin.y];
                    triangleV.hidden = NO;
                    triangle.hidden = YES;
                    removeAlarmTag = num;
                }
                break;
            default:
                break;
        }
        if (shouldStop) {
            break;
        }
    }
    
    UITextField *field1 = (UITextField *)[self viewWithTag:100];
    UITextField *field2 = (UITextField *)[self viewWithTag:200];
    UITextField *field3 = (UITextField *)[self viewWithTag:300];
    UITextField *field4 = (UITextField *)[self viewWithTag:400];
    UITextField *field5 = (UITextField *)[self viewWithTag:500];
    UITextField *field6 = (UITextField *)[self viewWithTag:600];
    UITextField *field7 = (UITextField *)[self viewWithTag:700];
    
    
    
    subBox = [[NSMutableDictionary alloc] init];
    [subBox setObject:[TYSingleton getinstance].oauth_token forKey:@"token"];
    [subBox setObject:[TYSingleton getinstance].oauth_token_secret forKey:@"token_secret"];
    
    //////// image array ///////
    
    imageArray = [[NSMutableArray alloc] init];
    
    
    NSMutableDictionary *imageDict = [[NSMutableDictionary alloc] init];
    [imageDict setObject:@{ @"name" : @{ @"292" : @"myImage.jpg"},
                            @"type" : @{ @"292" : @"image/jpeg"},
                            @"tmp_name" : @{ @"292": @"/tmp/phpjOMVLA"},
                            @"error" : @{ @"292": @"0"},
                            @"size" : @{ @"292": @"581967"},
                            } forKey:@"service_fields_value"];
    
    [imageArray addObject:imageDict];
    
    //////// image array ///////
    
    NSMutableArray *arr = [[NSMutableArray alloc] init];
    NSMutableDictionary *textFieldsBox = [[NSMutableDictionary alloc] init];
    [textFieldsBox setObject:field1.text forKey:@"171"];
    [textFieldsBox setObject:field2.text forKey:@"294"];
    [textFieldsBox setObject:field3.text forKey:@"293"];
    [textFieldsBox setObject:field4.text forKey:@"169"];
    [textFieldsBox setObject:field5.text forKey:@"170"];
    [textFieldsBox setObject:field7.text forKey:@"295"];
    
    [arr addObject:textFieldsBox];
    
    [subBox setObject:textFieldsBox forKey:@"service_fields_value"];
    
    [subBox setObject:[TYSingleton getinstance].allAuthorityId forKey:@"all_authority_id"];
    
    mainSendBox = [[NSMutableArray alloc] init];
    [mainSendBox addObject:subBox];
    
    
    [self sendAppeal];
    
    // if all is going ok!
    if (!shouldStop) {
        // Here we need to pass a full frame
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
}

- (UIView *)createDemoView
{
    UIView *demoView = [[UIView alloc] initWithFrame:CGRectMake(0, (self.frame.size.height+85)/2-(200/2)+30, 200, 100)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 200, 100)];
    [imageView setImage:[UIImage imageNamed:@"box_al.png"]];
    
    [demoView addSubview:imageView];
    
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 5, 200, 40)];
    tLabel.text = @"Отправка...";
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

-(void)sendAppeal {
//    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"http://saidazim.my.dev.gov.uz/"]];
    
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@"https://my.gov.uz/"]];
    
    [httpClient setParameterEncoding:AFFormURLParameterEncoding];
    
    //NSMutableDictionary *parameters = [[NSMutableDictionary alloc] init];
    //[parameters setObject:mainSendBox forKey:@"allData"];
    
    //NSLog(@"## Send Array ## : %@", [parameters objectForKey:@"allData"]);
    NSLog(@"## Send Image ## : %@", [TYSingleton getinstance].imageFromPhone);
    
    UIImage *img = [UIImage imageNamed:@"logo_about.png"];
    UIImage *imgSaved = [TYSingleton getinstance].imageFromPhone;
    
    NSData *imageToUpload = UIImageJPEGRepresentation(imgSaved, 1.0);  //(uploadedImgView.image);
    
    UITextField *field6 = (UITextField *)[self viewWithTag:600];
    
    NSMutableURLRequest *requestSingle;
    NSMutableURLRequest *request;
    AFHTTPRequestOperation *operation;
    
    if ([field6.text isEqual:@""]) {
//        requestSingle = [httpClient requestWithMethod:@"POST"
//                                                              path:@"http://saidazim.my.dev.gov.uz/mobileapi/createAppeal"
//                                                          parameters:subBox];
        //NSLog(@"SUBBOX >>>>> %@", subBox);
        requestSingle = [httpClient requestWithMethod:@"POST"
                                                 path:@"https://my.gov.uz/mobileapi/createAppeal"
                                           parameters:subBox];
        operation = [[AFHTTPRequestOperation alloc] initWithRequest:requestSingle];
        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    } else {
        NSString *fName = [TYSingleton getinstance].imageFromPhoneName;
        
//        request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"http://saidazim.my.dev.gov.uz/mobileapi/createAppeal" parameters:subBox constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
//            [formData appendPartWithFileData:imageToUpload name:@"file[292]" fileName:fName mimeType:@"image/jpeg"];
//        }];
        
        request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"https://my.gov.uz/mobileapi/createAppeal" parameters:subBox constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
            [formData appendPartWithFileData:imageToUpload name:@"file[292]" fileName:fName mimeType:@"image/jpeg"];
        }];
        operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
        [httpClient registerHTTPOperationClass:[AFHTTPRequestOperation class]];
    }
    //NSMutableURLRequest *request = [httpClient requestWithMethod:@"POST"
      //                                                      path:@"http://httpbin.org/post"
        //                                                  parameters:subBox];
    
    ///// second /////
    
    
    //////////// new ///////
    /*
    NSData *imageData = UIImageJPEGRepresentation([UIImage imageNamed:@"logo_about.png"], 0.5);
    
    NSMutableURLRequest *request = [httpClient multipartFormRequestWithMethod:@"POST" path:@"http://httpbin.org/post" parameters:subBox constructingBodyWithBlock: ^(id <AFMultipartFormData>formData) {
        [formData appendPartWithFileData:imageData name:@"[user_image]" fileName:@"user_image.jpg" mimeType:@"image/jpeg"];
    }];
    
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        NSLog(@"Sent %lld of %lld bytes", totalBytesWritten, totalBytesExpectedToWrite);
    }];
    [httpClient enqueueHTTPRequestOperation:operation];
    */
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject)
     {
         [alertView close];
         
         NSDictionary *jsons = [NSJSONSerialization JSONObjectWithData:responseObject options:kNilOptions error:nil];
         NSLog(@"Response Appeal: %@", jsons);
         if ([[jsons objectForKey:@"status"] isEqualToString:@"success"]) {
             UIAlertView *goodAlert = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:@"Ваше обращение отправлено успешно!" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
             
             goodAlert.tag = 7777;
             
             [goodAlert show];
         }
         
     }
            failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         NSLog(@"error: %@", [operation error]);
         if([operation.response statusCode] == 403)
         {
             NSLog(@"Upload Failed");
             return;
         }
         NSLog(@"error: %@", [operation error]);
     }];
    
    [operation start];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    if (alertView.tag == 7777) {
        if (buttonIndex == 0) {
            NSLog(@"OK pushed");
            [self.mainDelegate getBack];
            
        } else if (buttonIndex == 1) {
            NSLog(@"Cancel pushed");
        }
    }
}

-(void)goToThePrevStep:(UIButton *)sender {
    [self.mainDelegate moveToStepTwo];
}

-(void)getKeyboardOff:(UIButton *)sender {
    [dropTable setHidden:YES];
    [inputTextField resignFirstResponder];
    [customAlarm setHidden:YES];
    NSLog(@"Should dismiss");
}

-(void)showView {
    [self setHidden:NO];
}

-(void)hideView {
    [self setHidden:YES];
}

-(void)showAlarmMessageWithText:(NSString *)text andFrame:(float)theY {
    [customAlarm setHidden:NO];
    customAlarm.alpha = 0;
    customAlarm.frame = CGRectMake(customAlarm.frame.origin.x, theY+38, customAlarm.frame.size.width, customAlarm.frame.size.height);
    
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         //[imageView setImage:image];
                         customAlarm.alpha = 1;
                         //customAlarm.transform = CGAffineTransformMakeRotation( 180 * M_PI  / 180);
                     }
                     completion:^(BOOL finished){
                     }];
    
    alarmLabel.text = text;
}

-(void)hideAlarmMessage {
    [UIView animateWithDuration:0.5
                          delay:0.0
                        options:(UIViewAnimationCurveEaseInOut|UIViewAnimationOptionAllowUserInteraction)
                     animations:^{
                         //[imageView setImage:image];
                         customAlarm.alpha = 0;
                         //customAlarm.transform = CGAffineTransformMakeRotation( 180 * M_PI  / 180);
                     }
                     completion:^(BOOL finished){
                         [customAlarm setHidden:YES];
                     }];
}

#pragma mark - Validating Effects

-(void)showGreenEffect:(UITextField *)tf {
    NSLog(@"Green Effect");
    //tf.layer.borderColor = [UIColor greenColor].CGColor;
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    // animate from red to blue border ...
    color.fromValue = (id)[UIColor greenColor].CGColor;
    color.toValue   = (id)[RGB(202, 202, 202) CGColor];
    // ... and change the model value
    tf.layer.backgroundColor = [RGB(202, 202, 202) CGColor];
    
    CAAnimationGroup *both = [CAAnimationGroup animation];
    // animate both as a group with the duration of 0.5 seconds
    both.duration   = 1.5;
    both.animations = @[color];
    // optionally add other configuration (that applies to both animations)
    both.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [tf.layer addAnimation:both forKey:@"color"];
}

-(void)showRedEffect:(UITextField *)tf {
    NSLog(@"Red Effect");
    //tf.layer.borderColor = [UIColor redColor].CGColor;
    
    CABasicAnimation *color = [CABasicAnimation animationWithKeyPath:@"borderColor"];
    // animate from red to blue border ...
    color.fromValue = (id)[UIColor redColor].CGColor;
    color.toValue   = (id)[RGB(202, 202, 202) CGColor];
    // ... and change the model value
    tf.layer.backgroundColor = [RGB(202, 202, 202) CGColor];
    
    CAAnimationGroup *both = [CAAnimationGroup animation];
    // animate both as a group with the duration of 0.5 seconds
    both.duration   = 1.5;
    both.animations = @[color];
    // optionally add other configuration (that applies to both animations)
    both.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    
    [tf.layer addAnimation:both forKey:@"color"];
    
}

#pragma mark - Switchers for Texts

-(NSString *)setTheTitle:(int)number {
    switch (number) {
        case 1:
            customText = @"<font face='Helvetica' size=16 color='#585858'>Сфера обращения</font>";
            break;
        case 2:
            customText = @"<font face='Helvetica' size=16 color='#585858'>Вид обращения</font>";
            break;
        case 3:
            customText = @"<font face='Helvetica' size=16 color='#585858'>Видимость заявки</font>";
            break;
        case 4:
            customText = @"<font face='Helvetica' size=16 color='#585858'>Тема обращения</font>";
            break;
        case 5:
            customText = @"<font face='Helvetica' size=16 color='#585858'>Текст обращения</font>";
            break;
        case 6:
            customText = @"<font face='Helvetica' size=16 color='#585858'>Выбрать файл</font>";
            break;
        case 7:
            customText = @"<font face='Helvetica' size=16 color='#585858'>Способ получения ответа</font>";
            break;
        case 8:
            customText = @"<font face='Helvetica' size=16 color='#585858'>7777</font>";
            break;
        case 9:
            customText = @"<font face='Helvetica' size=16 color='#585858'>Текст обращения</font>";
            break;
        case 10:
            customText = @"<font face='Helvetica' size=16 color='#585858'>Выбрать файл</font>";
            break;
        default:
            break;
    }
    
    return customText;
}

-(NSString *)setPlaceHolderText:(int)number {
    switch (number) {
        case 1:
            placeHText = @"Выберите сферу обращения";
            break;
        case 2:
            placeHText = @"Выберите вид обращения";
            break;
        case 3:
            placeHText = @"Выберите видимость заявки";
            break;
        case 4:
            placeHText = @"Тема обращения";
            break;
        case 5:
            placeHText = @"Текст обращения";
            break;
        case 6:
            placeHText = @"Выберите фото из галлереи";
            break;
        case 7:
            placeHText = @"Выберите способ получения ответа";
            break;
        case 8:
            placeHText = @"";
            break;
        case 9:
            placeHText = @"";
            break;
        case 10:
            placeHText = @"";
            break;
        default:
            break;
    }
    return placeHText;
}

#pragma mark - UITextField Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"Text clicked %i", textField.tag);
    //textField.layer.cornerRadius=8.0f;
    textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [RGB(202, 202, 202) CGColor];
    textField.layer.borderWidth = 1.0f;
    
    if (textField.tag == 100 || textField.tag == 200 || textField.tag == 300 || textField.tag == 700) {
        if (textField.tag == 100) {
            dropTable.frame = CGRectMake(10, 55, 300, 200);
        } else {
            dropTable.frame = CGRectMake(10, textField.frame.origin.y+textField.frame.size.height, 300, 200);
        }
        if ([dropTable isHidden] || dropTable.tag != textField.tag) {
            [dropTable setHidden:NO];
        }
        else if ([dropTable isHidden]) {
            [dropTable setHidden:NO];
        } else {
            [dropTable setHidden:YES];
        }
        
        if (textField.tag == 100) {
            self.scopesArray = [TYSingleton getinstance].step3Scopes;
        } else if (textField.tag == 200) {
            self.scopesArray = [TYSingleton getinstance].step3Type;
            dropTable.frame = CGRectMake(10, textField.frame.origin.y+textField.frame.size.height, 300, 90);
        } else if (textField.tag == 300) {
            self.scopesArray = [TYSingleton getinstance].step3Visibility;
            dropTable.frame = CGRectMake(10, textField.frame.origin.y+textField.frame.size.height, 300, 60);

        } else if (textField.tag == 700) {
            self.scopesArray = [TYSingleton getinstance].step3AnswerType;
            dropTable.frame = CGRectMake(10, textField.frame.origin.y+textField.frame.size.height, 300, 60);
        }
        
        dropTable.tag = textField.tag;
        [dropTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        [dropTable reloadData];
    }
    
    if (!firstInit && textField.tag == 600) {
        // select image from gallery
        [self.mainDelegate openPickerForImage];
        photoTextField = (UITextField *)[self viewWithTag:600];
        
    }
    
    if (textField.tag == 400 || textField.tag == 500) {
        return YES;
    } else {
        return NO;
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    NSLog(@"Become to Edit!!!");
    NSLog(@"Tag is: %i", textField.tag);
    if (removeAlarmTag == textField.tag) {
        [self hideAlarmMessage];
    }
    
    //[[inputTextField viewWithTag:textField.tag] becomeFirstResponder];
    inputTextField = textField;
    //[inputTextField becomeFirstResponder];
    [self scrollRectToVisible:textField.frame animated:YES];
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"TextField ended Editing!!");
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return NO;
}

#pragma mark - UITableView DropBownBox

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.scopesArray count];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] init];
    }
    if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [tableView setSeparatorInset:UIEdgeInsetsZero];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@", [self.scopesArray objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
    cell.contentView.backgroundColor = RGB(39, 179, 238);
    
    return  cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [dropTable cellForRowAtIndexPath:indexPath];
    
    switch (dropTable.tag) {
        case 100:
            [dropTable setHidden:YES];
            activeTextField = (UITextField*)[self viewWithTag:100];
            activeTextField.text = cell.textLabel.text;
            break;
        case 200:
            [dropTable setHidden:YES];
            activeTextField = (UITextField*)[self viewWithTag:200];
            activeTextField.text = cell.textLabel.text;
            break;
        case 300:
            [dropTable setHidden:YES];
            activeTextField = (UITextField*)[self viewWithTag:300];
            activeTextField.text = cell.textLabel.text;
            break;
        case 700:
            [dropTable setHidden:YES];
            activeTextField = (UITextField*)[self viewWithTag:700];
            activeTextField.text = cell.textLabel.text;
            break;
        default:
            break;
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSLog(@"Selected %i %i", dropTable.tag, indexPath.row);
}


#pragma mark - Keyboard Manager implementation

// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
    
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.contentInset = contentInsets;
    self.scrollIndicatorInsets = contentInsets;
    
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your app might not need or want this behavior.
    CGRect aRect = self.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, inputTextField.frame.origin) ) {
        [self scrollRectToVisible:inputTextField.frame animated:YES];
    }
}

// Called when the UIKeyboardWillHideNotification is sent
- (void)keyboardWillBeHidden:(NSNotification*)aNotification
{
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.contentInset = contentInsets;
    self.scrollIndicatorInsets = contentInsets;
}

- (void)keyboardWillHide:(NSNotification *)n
{
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    
    // resize the scrollview
    CGRect viewFrame = self.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height += (keyboardSize.height + 3);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self setFrame:viewFrame];
    [UIView commitAnimations];
    
    keyboardIsShown = NO;
}

- (void)keyboardWillShow:(NSNotification *)n
{
    // This is an ivar I'm using to ensure that we do not do the frame size adjustment on the `UIScrollView` if the keyboard is already shown.  This can happen if the user, after fixing editing a `UITextField`, scrolls the resized `UIScrollView` to another `UITextField` and attempts to edit the next `UITextField`.  If we were to resize the `UIScrollView` again, it would be disastrous.  NOTE: The keyboard notification will fire even when the keyboard is already shown.
    if (keyboardIsShown) {
        return;
    }
    
    NSDictionary* userInfo = [n userInfo];
    
    // get the size of the keyboard
    CGSize keyboardSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    // resize the noteView
    CGRect viewFrame = self.frame;
    // I'm also subtracting a constant kTabBarHeight because my UIScrollView was offset by the UITabBar so really only the portion of the keyboard that is leftover pass the UITabBar is obscuring my UIScrollView.
    viewFrame.size.height -= (keyboardSize.height + 3);
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [self setFrame:viewFrame];
    [UIView commitAnimations];
    keyboardIsShown = YES;
}

-(void)rightButton:(UIButton *)sender {
    NSLog(@"Right Cal: %li Clicked", (long)sender.tag);
    if (removeAlarmTag == sender.tag) {
        [self hideAlarmMessage];
    }
    temporyTag = sender.tag;
    [inputTextField resignFirstResponder];
    //CGPoint aRect = self.contentOffset;
    
    inputTextField = (UITextField*)[self viewWithTag:sender.tag];
    
    [inputTextField resignFirstResponder];
    
    //NSLog(@"Frame: %f", aRect.size.height);
    //aRect.size.height -= 100;
    //[self scrollRectToVisible:inputTextField.frame animated:YES];
    if (sender.tag == 100 || sender.tag == 200 || sender.tag == 300 || sender.tag == 700) {
        if (sender.tag == 100) {
            dropTable.frame = CGRectMake(10, 55, 300, 200);
        } else {
            dropTable.frame = CGRectMake(10, inputTextField.frame.origin.y+inputTextField.frame.size.height, 300, 200);
        }
        if ([dropTable isHidden] || dropTable.tag != sender.tag) {
            [dropTable setHidden:NO];
        }
        else if ([dropTable isHidden]) {
            [dropTable setHidden:NO];
        } else {
            [dropTable setHidden:YES];
        }
        
        if (sender.tag == 100) {
            self.scopesArray = [TYSingleton getinstance].step3Scopes;
        } else if (sender.tag == 200) {
            self.scopesArray = [TYSingleton getinstance].step3Type;
            dropTable.frame = CGRectMake(10, inputTextField.frame.origin.y+inputTextField.frame.size.height, 300, 90);
        } else if (sender.tag == 300) {
            self.scopesArray = [TYSingleton getinstance].step3Visibility;
            dropTable.frame = CGRectMake(10, inputTextField.frame.origin.y+inputTextField.frame.size.height, 300, 60);
        } else if (sender.tag == 700) {
            self.scopesArray = [TYSingleton getinstance].step3AnswerType;
            dropTable.frame = CGRectMake(10, inputTextField.frame.origin.y+inputTextField.frame.size.height, 300, 60);
        }
        
        dropTable.tag = sender.tag;
        [dropTable scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
        [dropTable reloadData];
    }
    
    if (sender.tag == 600) {
        // select image from gallery
        [self.mainDelegate openPickerForImage];
        
        photoTextField = (UITextField *)[self viewWithTag:600];

    }

}

- (void)selectPhotos
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    //[self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo
{
    //imageView.image = image;
    [TYSingleton getinstance].imageFromPhone = image;
    NSLog(@"#IMAGE# : %@", [image description]);
    [picker dismissModalViewControllerAnimated:YES];
}



#pragma mark - UIScrollView Delegate

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    NSLog(@"TAGGGG: %i", scrollView.tag);
    if (scrollView.tag == 111) {
        [dropTable setHidden:YES];
        [inputTextField resignFirstResponder];
        NSLog(@"Scrolllsss! 1");
    } else {
        //[dropTable setHidden:YES];
        [inputTextField resignFirstResponder];
        NSLog(@"Scrolllsss! 2");
    }
}

/*
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    //if (scrollView.tag == 7777) {
        [dropTable setHidden:YES];
        [inputTextField resignFirstResponder];
        NSLog(@"Scrolllsss 3!");
    //}
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    //if (scrollView.tag == 7777) {
        [dropTable setHidden:YES];
        [inputTextField resignFirstResponder];
        NSLog(@"Scrolllsss 2!");
    //}
}
*/

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
