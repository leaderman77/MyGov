//
//  MGStepTwo.h
//  MyGov
//
//  Created by Alexander Makshov on 04.04.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSTableView.h"
#import "MGStepThird.h"
#import "MGStepOne.h"
#import "MGStepTwo.h"
#import "SSCheckBoxView.h"

@protocol PostDelegate2 <NSObject>
-(void)moveToStepOne;
-(void)moveToStepThree;
@end

@interface MGStepTwo : UIViewController <NSURLConnectionDataDelegate,NSURLConnectionDelegate, PostDelegate2, UITableViewDataSource, UITableViewDelegate> {
    NSURLConnection *connec;
    NSMutableData *dataforc;
    
}

@property (assign) id <PostDelegate2> mainDelegate;

@property (nonatomic, strong) MGStepThird *st3;
@property (nonatomic, strong) MGStepOne *st1;

@property (nonatomic, strong) NSMutableArray *arrData;
@property (nonatomic, strong) NSMutableArray *yourSeperatedData;

@property (nonatomic, strong) NSMutableArray *idBox;

-(void)showView;

-(void)hideView;

@end
