//
//  MGStepOne.h
//  MyGov
//
//  Created by Alpha on 01.04.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatDatePicker.h"
#import "MGStepOne.h"

@protocol PostDelegate <NSObject>
-(void)moveToStepTwo;   //method from ClassA
-(void)moveToStepOne;
@end

@interface MGStepOne : UIScrollView <UITextFieldDelegate, FlatDatePickerDelegate, UIScrollViewDelegate, UITextFieldDelegate> {
    //id<MGPostAppealDelegate> delegate;
    //MGPostAppealController *post;
}

@property (assign) id <PostDelegate> mainDelegate;

-(void)initAllObjects;
-(void)showView;
-(void)hideView;

@end
