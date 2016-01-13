//
//  MGMainMenuController.h
//  MyGov
//
//  Created by Alpha on 27.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MGMainMenuController.h"
#import "CustomIOS7AlertView.h"
#import "MGPostAppealController.h"

@interface MGMainMenuController : UIViewController <mainMenuRequestsDelegate, CustomIOS7AlertViewDelegate>

@property (strong, nonatomic) NSMutableArray *categoriesList;
@property (strong, nonatomic) NSMutableArray *subCategoriesList;
@property (strong, nonatomic) NSMutableArray *selectionsList;

@property (strong, nonatomic) NSMutableArray *scopeList;
@property (strong, nonatomic) NSMutableArray *visibilityList;
@property (strong, nonatomic) NSMutableArray *typeList;
@property (strong, nonatomic) NSMutableArray *answerTypeList;

@property (strong, nonatomic) MGPostAppealController *postAppeal;

-(void)allLoadedCkeck:(int)number;

-(void)loadAllData;

@end
