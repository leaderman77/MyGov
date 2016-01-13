//
//  MGHistoryDetailController.h
//  MyGov
//
//  Created by Alpha on 28.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DYRateView.h"
#import "AFImageRequestOperation.h"

@interface MGHistoryDetailController : UIViewController <DYRateViewDelegate, CustomIOS7AlertViewDelegate>

@property (strong, nonatomic) NSString *recTitle;
@property (assign, readwrite) int appealID;
@property (strong, nonatomic) NSString *added_date;
@property (strong, nonatomic) NSString *ID;
@property (strong, nonatomic) NSString *recipientType;
@property (strong, nonatomic) NSString *serviceID;
@property (strong, nonatomic) NSString *status;
@property (strong, nonatomic) NSMutableDictionary *fields;

@end
