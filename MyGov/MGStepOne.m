//
//  MGStepOne.m
//  MyGov
//
//  Created by Alpha on 01.04.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGAppDelegate.h"
#import "MGStepOne.h"
#import "RTLabel.h"
#import "RadioButton.h"
#import "FlatDatePicker.h"
#import "MGStepTwo.h"
#import <QuartzCore/QuartzCore.h>

#define emptyField @"Заполните пустое поле пожалуйста!"
#define incorrectField @"Поле заполнено не верно!"
#define genderField @"Выберите половую пренадлежность!"
#define dateField @"Выберите дату пожалуйста!"

#define datePickerTag 8888871

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]



@interface MGStepOne () {
    int counter;
    UIImageView *stepsBar;
    BOOL keyboardIsShown;
    
    UITextField *inputTextField;
    UITextField *activeTextField;
    UILabel *label;
    NSString *customText;
    NSString *placeHText;
    NSString *userDataHText;
    
    NSMutableArray *buttons;
    FlatDatePicker *datePicker;
    
    MGStepTwo *stepTwo;
    
    MGAppDelegate *delegate;
    
    UIImageView *customAlarm;
    UILabel *alarmLabel;
    UIImageView *triangle;
    UIImageView *triangleV;
    
    int temporyTag;
    int removeAlarmTag;
    
    CGRect btnRect;
    
    BOOL firstInit;
}

@end

@implementation MGStepOne

- (void)taskComplete:(BOOL)complete
{
    if(complete)
        NSLog(@"Yay!");
    else
        NSLog(@"Boo!");
    [self removeFromSuperview];
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setBackgroundColor:RGB(244, 244, 244)];
    }
    return self;
}

-(void)initAllObjects {
    self.delegate = self;
    //[self setUserInteractionEnabled:NO];
    

    [self setOpaque:YES];
    firstInit = YES;
    
    [inputTextField setUserInteractionEnabled:NO];
 

    
    // Very important. If we don't let myClass know who the delegate
    // is we'll never get the protocol methods called to us.
    //[post doSomeTask];
    //NSLog(@"Tag post: %i", post.view.tag);
    
    UIButton *removeKeyboardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    removeKeyboardBtn.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    
    [removeKeyboardBtn addTarget:self action:@selector(getOffKeyboard:) forControlEvents:UIControlEventTouchUpInside];
    [removeKeyboardBtn endEditing:YES];
    
    [self addSubview:removeKeyboardBtn];
    
    datePicker = [[FlatDatePicker alloc] initWithParentView:self];
    datePicker.delegate = self;
    datePicker.title = @"Выберите дату";
    datePicker.tag = datePickerTag;
    [datePicker setUserInteractionEnabled:NO];
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
    
    // Left Labels with '*' at the end
    for (int i=0; i < 11; i++) {
        if (i == 0) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 200, 25)];
        } else if (i > 1) {
            label = [[UILabel alloc] initWithFrame:CGRectMake(10, label.frame.origin.y+60, 200, 25)];
        }
        //label.tag = i;
        [self setTheTitle:i];
        label.font = [UIFont fontWithName:@"Helvetica" size:16];
        label.backgroundColor = [UIColor clearColor];
        label.textColor = UIColorFromRGB(0x585858);
        label.userInteractionEnabled = NO;
        
        [self addSubview:label];
        [label setText:customText];
    }
    
    // Input Fields
    for (int n=0; n < 11; n++) {
        if (n == 0) {
            inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 25, 300, 30)];
        } else if (n > 1) {
            inputTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, inputTextField.frame.origin.y+60, 300, 30)];
        }
        // set tag
        inputTextField.tag = n*10;
        
        inputTextField.returnKeyType = UIReturnKeyDone;
        [self setPlaceHolderText:n];
        inputTextField.placeholder = [self setPlaceHolderText:n]; //@"Введите Фамилию, Имя и Отчество";
        inputTextField.text = [self setUserDataText:n]; //@"Введите Фамилию, Имя и Отчество";
        
        inputTextField.font = [UIFont fontWithName:@"Helvetica" size:14];
        
        [inputTextField setBackgroundColor:[UIColor whiteColor]];
        [inputTextField setBorderStyle:UITextBorderStyleLine];
        [inputTextField setTextAlignment:NSTextAlignmentLeft];
        inputTextField.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
        inputTextField.autocorrectionType = UITextAutocorrectionTypeNo;
        inputTextField.autocapitalizationType = UITextAutocapitalizationTypeNone;
        inputTextField.opaque = YES;
        
        if (n == 1) {
            inputTextField.autocapitalizationType = UITextAutocapitalizationTypeWords;
        } else if (n==6) {
            inputTextField.autocapitalizationType = UITextAutocapitalizationTypeAllCharacters;
        }
        // left margin
        UIView *paddingView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 5, 20)];
        inputTextField.leftView = paddingView;
        inputTextField.leftViewMode = UITextFieldViewModeAlways;
        
        // right margin
        UIView *paddingViewRight = [[UIView alloc] init];
        if (n == 5 || n == 9 || n == 10) {
            paddingViewRight.frame = CGRectMake(0, 0, 35, 30);
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
        button.frame = CGRectMake(0, -1, 35, 30); //285, 7, 13, 15);
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
        [button setImage:[UIImage imageNamed:@"calendar_st.png"] forState:UIControlStateNormal];
        [[button imageView] setContentMode:UIViewContentModeCenter];
        [button addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchUpInside];
        if (n == 5 || n == 9 || n == 10) {
            button.tag = n*10;
            [paddingViewRight addSubview:button];
            //inputTextField
        }
        //inputTextField.rightViewMode = UITextFieldViewModeAlways;
        
        if ((n*10) == 30) {
            UIToolbar* numberToolbar = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            numberToolbar.barStyle = UIBarStyleDefault;
            numberToolbar.items = [NSArray arrayWithObjects:
                               [[UIBarButtonItem alloc]initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelNumberPad)],
                               [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                               [[UIBarButtonItem alloc]initWithTitle:@"Apply" style:UIBarButtonItemStyleDone target:self action:@selector(doneWithNumberPad)],
                               nil];
            [numberToolbar sizeToFit];
            inputTextField.inputAccessoryView = numberToolbar;
        }
        
        [self textFieldShouldBeginEditing:inputTextField];
        
        if (n == 4) {
            
        } else {
            [self addSubview:inputTextField];
        }
    }
    
    buttons = [NSMutableArray arrayWithCapacity:2];
    
	btnRect = CGRectMake(50, 205, 100, 30);
	for (NSString* optionTitle in @[@"Мужской", @"Женский"]) {
		RadioButton* btn = [[RadioButton alloc] initWithFrame:btnRect];
		btnRect.origin.x += 120;
		[btn setTitle:optionTitle forState:UIControlStateNormal];
		[btn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
		btn.titleLabel.font = [UIFont fontWithName:@"Helvetica" size:16];
		[btn setImage:[UIImage imageNamed:@"radial_button_.png"] forState:UIControlStateNormal];
		[btn setImage:[UIImage imageNamed:@"radial_button_aktiv_.png"] forState:UIControlStateSelected];
        [btn setImage:[UIImage imageNamed:@"radial_button_aktiv_.png"] forState:UIControlStateHighlighted];
		btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
		btn.titleEdgeInsets = UIEdgeInsetsMake(0, 6, 0, 0);
        [btn addTarget:self action:@selector(checkSelection:) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:btn];
        [btn setUserInteractionEnabled:NO];
		[buttons addObject:btn];
	}
    
	[buttons[0] setGroupButtons:buttons]; // Setting buttons into the group
    
	//[buttons[0] setSelected:YES]; // Making the first button initially selected
    
    if ([[[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"gender"] isEqualToString:@"m"]) {
        [buttons[0] setSelected:YES];
        NSLog(@"GENDER M");
    } else {
        [buttons[1] setSelected:YES];
        NSLog(@"GENDER W");
    }
    
    //[self setContentSize:(CGSizeMake(320, 600))];
    [self endEditing:YES];
    
    customAlarm = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width/2-260/2, 120, 260, 40)];
    [customAlarm setBackgroundColor:RGB(40, 40, 40)];
    //[customAlarm.layer setOpaque:YES];
    [customAlarm.layer setCornerRadius:8];
    
    customAlarm.layer.shadowColor = [UIColor blackColor].CGColor;
    customAlarm.layer.shadowOffset = CGSizeMake(0.0, 0.0);
    customAlarm.layer.shadowRadius = 8.0;
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
    
    UITapGestureRecognizer *tapScroll = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapped)];
    tapScroll.cancelsTouchesInView = NO;
    [self addGestureRecognizer:tapScroll];
    
    UIButton *nextStep = [[UIButton alloc] initWithFrame:CGRectMake(168, 615, 142, 35)];
    [nextStep setBackgroundImage:[UIImage imageNamed:@"next_step.png"] forState:UIControlStateNormal];
    [nextStep setBackgroundImage:[UIImage imageNamed:@"next_step_h.png"] forState:UIControlStateHighlighted];
    [nextStep setTitle:@"Следующий шаг" forState:UIControlStateNormal];
    [nextStep setTitleColor:RGB(42, 182, 241) forState:UIControlStateNormal];
    [[nextStep titleLabel] setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    [nextStep addTarget:self action:@selector(goToTheNextStep:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [self addSubview:nextStep];
    
    for (UIView *v in self.subviews)
    {
        if (![v isKindOfClass:[UIButton class]])
        {
            [v setUserInteractionEnabled:NO];
        }
    }
    

    
    firstInit = NO;
}







-(void)goToTheNextStep:(UIButton *)sender {
    NSLog(@"Ready to go next? ");
    
    [stepTwo showView];
    [self.mainDelegate moveToStepTwo];
    
    BOOL shouldStop = NO;
    
    for (int i=0; i < 11; i++) {
        int num = i*10;
        UITextField *textField = (UITextField*)[self viewWithTag:num];
        
        if (num > 9) {
            //NSLog(@"Text field text  %@", textField.text);
        }
        switch (num) {
            case 10:
                if (![textField.text isEqualToString:@""]) {
                    NSLog(@"1 field is Ready!");
                } else {
                    NSLog(@"1 field isn't Good!");
                    shouldStop = YES;
                    [self setContentOffset:CGPointMake(0, 0) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:emptyField andFrame:textField.frame.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 20:
                if ([self validateEmail:textField.text]) {
                    NSLog(@"2 field is Ready");
                } else {
                    NSLog(@"2 field isn't Good!");
                    shouldStop = YES;
                    [self setContentOffset:CGPointMake(0, 0) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    if ([textField.text isEqualToString:@""]) {
                        [self showAlarmMessageWithText:emptyField andFrame:textField.frame.origin.y];
                    } else{
                        [self showAlarmMessageWithText:incorrectField andFrame:textField.frame.origin.y];
                    }
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 30:
                if ([self validatePhoneNumber:textField.text] || ![textField.text isEqual: @""]) {
                    NSLog(@"3 field is Ready");
                } else {
                    NSLog(@"3 field isn't Good!");
                    shouldStop = YES;
                    [self setContentOffset:CGPointMake(0, (textField.frame.origin.y)-40) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    if ([textField.text isEqualToString:@""]) {
                        [self showAlarmMessageWithText:emptyField andFrame:textField.frame.origin.y];
                    } else{
                        [self showAlarmMessageWithText:incorrectField andFrame:textField.frame.origin.y];
                    }
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 40:
                NSLog(@"40 is WORKING!");
                if ([buttons[0] isSelected] == 0 && [buttons[1] isSelected] == 0) {
                    NSLog(@"Choose your Gender");  shouldStop = YES;
                    [self setContentOffset:CGPointMake(0, btnRect.origin.y-40) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:genderField andFrame:btnRect.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 50:
                if (![textField.text isEqual: @""]) {
                    NSLog(@"5 field is Ready");
                } else { NSLog(@"5 field isn't Good!");   shouldStop = YES;
                    [self setContentOffset:CGPointMake(0, (textField.frame.origin.y)-40) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:dateField andFrame:textField.frame.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 60:
                if (![textField.text isEqual: @""]) {
                    NSLog(@"6 field is Ready");
                } else { NSLog(@"6 field isn't Good!");   shouldStop = YES;
                    [self setContentOffset:CGPointMake(0, (textField.frame.origin.y)-40) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:emptyField andFrame:textField.frame.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 70:
                if (![textField.text isEqual: @""]) {
                    NSLog(@"7 field is Ready");
                } else { NSLog(@"7 field isn't Good!");   shouldStop = YES;
                    //[self setContentOffset:CGPointMake(0, (textField.frame.origin.y)-40) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:emptyField andFrame:textField.frame.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 80:
                if (![textField.text isEqual: @""]) {
                    NSLog(@"8 field is Ready");
                } else { NSLog(@"8 field isn't Good!");   shouldStop = YES;
                    //[self setContentOffset:CGPointMake(0, (textField.frame.origin.y)-40) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:emptyField andFrame:textField.frame.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 90:
                if (![textField.text isEqual: @""]) {
                    NSLog(@"9 field is Ready");
                    shouldStop = NO;
                } else { NSLog(@"9 field isn't Good!");   shouldStop = YES;
                    //[self setContentOffset:CGPointMake(0, (textField.frame.origin.y)-40) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:dateField andFrame:textField.frame.origin.y];
                    triangleV.hidden = YES;
                    triangle.hidden = NO;
                    removeAlarmTag = num;
                }
                break;
            case 100:
                if (![textField.text isEqual: @""]) {
                    NSLog(@"9 field is Ready");
                    shouldStop = NO;
                } else { NSLog(@"10 field isn't Good!");   shouldStop = YES;
                    //[self setContentOffset:CGPointMake(0, (textField.frame.origin.y)-40) animated:YES];
                    [self performSelector:@selector(showRedEffect:) withObject:textField afterDelay:0.5];
                    [self showAlarmMessageWithText:dateField andFrame:(textField.frame.origin.y-(48+40))];
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
    
    // if all is going ok!
    if (!shouldStop) {
        [stepTwo showView];
        [self.mainDelegate moveToStepTwo];
    }
}

- (void)tapped
{
    [self endEditing:YES];
}

-(void)checkSelection:(RadioButton *)sender {
    NSLog(@"SEL Male: %hhd", [buttons[0] isSelected]);
    NSLog(@"SEL Female: %hhd", [buttons[1] isSelected]);
    [self hideAlarmMessage];
}

-(void)cancelNumberPad {
    [inputTextField resignFirstResponder];
    inputTextField.text = @"";
}

-(void)doneWithNumberPad {
    
    if ([self validatePhoneNumber:inputTextField.text] && ![inputTextField.text isEqual: @""]) {
        [self showGreenEffect:inputTextField];
        [inputTextField resignFirstResponder];
    } else {
        [self showRedEffect:inputTextField];
    }
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

-(void)getOffKeyboard:(UIButton *)sender {
    NSLog(@"Keyboard here!");
    [inputTextField resignFirstResponder];
    [datePicker dismiss];
    //[[inputTextField viewWithTag:1] resignFirstResponder];
}

-(void)rightButton:(UIButton *)sender {
    NSLog(@"Right Cal: %i Clicked", sender.tag);
    temporyTag = sender.tag;
    [inputTextField resignFirstResponder];
    CGPoint aRect = self.contentOffset;
    
    [datePicker show:aRect];
    [self bringSubviewToFront:datePicker];
    
    datePicker.frame = CGRectMake(0, self.contentOffset.y+135, datePicker.frame.size.width, datePicker.frame.size.height);
    
    inputTextField = (UITextField*)[self viewWithTag:sender.tag];
    
    //NSLog(@"Frame: %f", aRect.size.height);
    //aRect.size.height -= 100;
    //[self scrollRectToVisible:inputTextField.frame animated:YES];
}

#pragma mark - UITextField Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    //textField.layer.cornerRadius=8.0f;
    //textField.layer.masksToBounds = YES;
    textField.layer.borderColor = [RGB(202, 202, 202) CGColor];
    textField.layer.borderWidth = 1.0f;
//    if (textField.tag == 50 || textField.tag == 90 || textField.tag == 100) {
//        if (!firstInit) {
//            temporyTag = textField.tag;
//            [inputTextField resignFirstResponder];
//            CGPoint aRect = self.contentOffset;
//            
//            [datePicker show:aRect];
//            [self bringSubviewToFront:datePicker];
//            
//            datePicker.frame = CGRectMake(0, self.contentOffset.y+116, datePicker.frame.size.width, datePicker.frame.size.height);
//            
//            inputTextField = (UITextField*)[self viewWithTag:textField.tag];
//        }
//        NSLog(@"Text Editing is NO!!!");
//        return NO;
//    } else {
//        if (textField.tag == 10) {
//            textField.keyboardType = UIKeyboardTypeNamePhonePad;
//        } else if (textField.tag == 20) {
//            textField.keyboardType = UIKeyboardTypeEmailAddress;
//        } else if (textField.tag == 30) {
//            textField.keyboardType = UIKeyboardTypePhonePad;
//        } else {
//            textField.keyboardType = UIKeyboardTypeAlphabet;
//        }
//        return YES;
//    }
    return NO;
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
    //[textField resignFirstResponder];
    NSLog(@"REUTRN %i", textField.tag);
    
    if (textField.tag == 10) {  // name, surname...
        if (![textField.text isEqualToString:@""]) {
            [self showGreenEffect:textField];
            [textField resignFirstResponder];
            return YES;
        } else {
            [self showRedEffect:textField];
        }
    } else if (textField.tag == 20) {  // email
        if ([self validateEmail:textField.text]) {
            [self showGreenEffect:textField];
            [textField resignFirstResponder];
            return YES;
        } else {
            [self showRedEffect:textField];
        }
    } else if (textField.tag == 30) { // phone number
        if ([self validatePhoneNumber:textField.text] || ![textField.text isEqual: @""]) {
            [self showGreenEffect:textField];
            [textField resignFirstResponder];
            return YES;
        } else {
            [self showRedEffect:textField];
        }
    } else if (textField.tag == 60 || textField.tag == 70 || textField.tag == 80) { // other fields
        if (![textField.text isEqual: @""]) {
            [self showGreenEffect:textField];
            [textField resignFirstResponder];
            return YES;
        } else {
            [self showRedEffect:textField];
        }
    }
    
    return NO;
}



#pragma mark - Validation Methods

- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (BOOL)validateEmail:(NSString *)inputText {
    NSString *emailRegex = @"[A-Z0-9a-z][A-Z0-9a-z._%+-]*@[A-Za-z0-9][A-Za-z0-9.-]*\\.[A-Za-z]{2,6}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    NSRange aRange;
    if([emailTest evaluateWithObject:inputText]) {
        aRange = [inputText rangeOfString:@"." options:NSBackwardsSearch range:NSMakeRange(0, [inputText length])];
        int indexOfDot = aRange.location;
        //NSLog(@"aRange.location:%d - %d",aRange.location, indexOfDot);
        if(aRange.location != NSNotFound) {
            NSString *topLevelDomain = [inputText substringFromIndex:indexOfDot];
            topLevelDomain = [topLevelDomain lowercaseString];
            //NSLog(@"topleveldomains:%@",topLevelDomain);
            NSSet *TLD;
            TLD = [NSSet setWithObjects:@".aero", @".asia", @".biz", @".cat", @".com", @".coop", @".edu", @".gov", @".info", @".int", @".jobs", @".mil", @".mobi", @".museum", @".name", @".net", @".org", @".pro", @".tel", @".travel", @".ac", @".ad", @".ae", @".af", @".ag", @".ai", @".al", @".am", @".an", @".ao", @".aq", @".ar", @".as", @".at", @".au", @".aw", @".ax", @".az", @".ba", @".bb", @".bd", @".be", @".bf", @".bg", @".bh", @".bi", @".bj", @".bm", @".bn", @".bo", @".br", @".bs", @".bt", @".bv", @".bw", @".by", @".bz", @".ca", @".cc", @".cd", @".cf", @".cg", @".ch", @".ci", @".ck", @".cl", @".cm", @".cn", @".co", @".cr", @".cu", @".cv", @".cx", @".cy", @".cz", @".de", @".dj", @".dk", @".dm", @".do", @".dz", @".ec", @".ee", @".eg", @".er", @".es", @".et", @".eu", @".fi", @".fj", @".fk", @".fm", @".fo", @".fr", @".ga", @".gb", @".gd", @".ge", @".gf", @".gg", @".gh", @".gi", @".gl", @".gm", @".gn", @".gp", @".gq", @".gr", @".gs", @".gt", @".gu", @".gw", @".gy", @".hk", @".hm", @".hn", @".hr", @".ht", @".hu", @".id", @".ie", @" No", @".il", @".im", @".in", @".io", @".iq", @".ir", @".is", @".it", @".je", @".jm", @".jo", @".jp", @".ke", @".kg", @".kh", @".ki", @".km", @".kn", @".kp", @".kr", @".kw", @".ky", @".kz", @".la", @".lb", @".lc", @".li", @".lk", @".lr", @".ls", @".lt", @".lu", @".lv", @".ly", @".ma", @".mc", @".md", @".me", @".mg", @".mh", @".mk", @".ml", @".mm", @".mn", @".mo", @".mp", @".mq", @".mr", @".ms", @".mt", @".mu", @".mv", @".mw", @".mx", @".my", @".mz", @".na", @".nc", @".ne", @".nf", @".ng", @".ni", @".nl", @".no", @".np", @".nr", @".nu", @".nz", @".om", @".pa", @".pe", @".pf", @".pg", @".ph", @".pk", @".pl", @".pm", @".pn", @".pr", @".ps", @".pt", @".pw", @".py", @".qa", @".re", @".ro", @".rs", @".ru", @".rw", @".sa", @".sb", @".sc", @".sd", @".se", @".sg", @".sh", @".si", @".sj", @".sk", @".sl", @".sm", @".sn", @".so", @".sr", @".st", @".su", @".sv", @".sy", @".sz", @".tc", @".td", @".tf", @".tg", @".th", @".tj", @".tk", @".tl", @".tm", @".tn", @".to", @".tp", @".tr", @".tt", @".tv", @".tw", @".tz", @".ua", @".ug", @".uk", @".us", @".uy", @".uz", @".va", @".vc", @".ve", @".vg", @".vi", @".vn", @".vu", @".wf", @".ws", @".ye", @".yt", @".za", @".zm", @".zw", nil];
            if(topLevelDomain != nil && ([TLD containsObject:topLevelDomain])) {
                //NSLog(@"TLD contains topLevelDomain:%@",topLevelDomain);
                return TRUE;
            }
            /*else {
             NSLog(@"TLD DOEST NOT contains topLevelDomain:%@",topLevelDomain);
             }*/
            
        }
    }
    return FALSE;
}

-(BOOL)validatePhoneNumber:(NSString *)phone {
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return ([phoneTest evaluateWithObject:phone]);
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
            customText = @"Ф.И.О";
            break;
        case 2:
            customText = @"E-mail";
            break;
        case 3:
            customText = @"Номер телефона";
            break;
        case 4:
            customText = @"Пол";
            break;
        case 5:
            customText = @"Дата рождения";
            break;
        case 6:
            customText = @"Серия/номер паспорта";
            break;
        case 7:
            customText = @"Кем выдан";
            break;
        case 8:
            customText = @"Место жительства";
            break;
        case 9:
            customText = @"Дата выдачи паспорта";
            break;
        case 10:
            customText = @"Действительно до";
            break;
        default:
            break;
    }
    
    return customText;
}

-(NSString *)setPlaceHolderText:(int)number {
    switch (number) {
        case 1:
            placeHText = @"Введите фамилию, имя и отчество";
            break;
        case 2:
            placeHText = @"Введите E-mail";
            break;
        case 3:
            placeHText = @"+998...";
            break;
        case 4:
            placeHText = @"";
            break;
        case 5:
            placeHText = @"Введите дату рождения";
            break;
        case 6:
            placeHText = @"Введите серию и номер";
            break;
        case 7:
            placeHText = @"";
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

-(NSString *)setUserDataText:(int)number {
    
    if ([[TYSingleton getinstance].userPrivateData objectForKey:@"result"] == nil) {
        userDataHText = @"";
        return userDataHText;
    }
    
    switch (number) {
        case 1:
            userDataHText = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"name"];
            break;
        case 2:
            userDataHText = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"email"];
            break;
        case 3:
            userDataHText = [NSString stringWithFormat:@"+%@", [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"phone"]];
            break;
        case 4:
            userDataHText = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"gender"];
            NSLog(@"GENDER HERE");
            break;
        case 5:
            userDataHText = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"dob"];
            break;
        case 6:
            userDataHText = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"passport_sn"];
            break;
        case 7:
            userDataHText = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"passport_issued"];
            break;
        case 8:
            userDataHText = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"passport_address"];
            break;
        case 9:
            userDataHText = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"passport_issued_date"];
            break;
        case 10:
            userDataHText = [[[TYSingleton getinstance].userPrivateData objectForKey:@"result"] objectForKey:@"passport_exp"];
            break;
        default:
            break;
    }
    return userDataHText;
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
    [datePicker dismiss];
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

#pragma mark - FlatPicker Action Methods

- (IBAction)actionOpen:(id)sender {
    //[datePicker show];
}

- (IBAction)actionClose:(id)sender {
    [datePicker dismiss];
}

- (IBAction)actionSetDate:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSDate *date = [dateFormatter dateFromString:@"07-12-1985"];
    
    [datePicker setDate:date animated:NO];
}

#pragma mark - FlatDatePicker Delegate

- (void)flatDatePicker:(FlatDatePicker*)datePicker dateDidChange:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *value = [dateFormatter stringFromDate:date];
    
    inputTextField.text = value;
    
    [self hideAlarmMessage];
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didCancel:(UIButton*)sender {
    
    //UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:@"Did cancelled !" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    //[alertView show];
}

- (void)flatDatePicker:(FlatDatePicker*)datePicker didValid:(UIButton*)sender date:(NSDate*)date {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[NSLocale currentLocale]];
    [dateFormatter setDateFormat:@"dd-MM-yyyy"];
    NSString *value = [dateFormatter stringFromDate:date];
    
    NSLog(@"Sender tag: %i", sender.tag);
    inputTextField = (UITextField*)[self viewWithTag:temporyTag];
    //[inputTextField viewWithTag:5];
    inputTextField.text = [NSString stringWithFormat:@"%@", value];
    
    NSString *message = [NSString stringWithFormat:@"Выбрана дата : %@", value];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Оповещение" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alertView show];
    [self hideAlarmMessage];
    
}

#pragma mark - UIScrollView Delegate

-(void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView {
    //if (scrollView.tag == self.tag) {
        [datePicker dismiss];
    //}
    [inputTextField resignFirstResponder];
    NSLog(@"SCrollinggg is happening!!!");
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    NSLog(@"Scrolling ended!");
}

/*-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    [datePicker dismiss];
    NSLog(@"Scroll will begin drag");
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [datePicker dismiss];
    NSLog(@"SCroll view did scroll");
}

-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset {
    [datePicker dismiss];
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
