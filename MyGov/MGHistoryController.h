//
//  MGHistoryController.h
//  MyGov
//
//  Created by Alpha on 27.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MGHistoryController : UIViewController <UITableViewDataSource, UITableViewDelegate, CustomIOS7AlertViewDelegate>

@property (strong, nonatomic) UITableView *historyTable;

@property (strong, nonatomic) NSMutableDictionary *appealData;

@end
