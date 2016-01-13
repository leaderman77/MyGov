//
//  MGPostAppealController.h
//  MyGov
//
//  Created by Alpha on 28.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"
#import "MGStepOne.h"
#import "MGStepTwo.h"
#import "CustomIOS7AlertView.h"

@interface MGPostAppealController : UIViewController <UITextFieldDelegate, NSURLConnectionDataDelegate,NSURLConnectionDelegate, PostDelegate, PostDelegate2, PostDelegate3, CustomIOS7AlertViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    NSURLConnection *connec;
    NSMutableData *dataforc;
}

@property (retain, nonatomic) UIImageView *stepsBar;

@property (strong, nonatomic) NSMutableArray *categoriesList;

//-(void)moveToStepTwo;
-(void)moveToStepTwo;
-(void)moveToStepOne;
-(void)getBack;
-(void)addStepsBar:(int)number;

-(void)openPickerForImage;

@end
