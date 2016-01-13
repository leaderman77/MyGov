//
//  MGStepThird.h
//  MyGov
//
//  Created by Alexander Makshov on 07.04.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchDropDownView.h"
#import "CustomIOS7AlertView.h"
#import "AFHTTPRequestOperation.h"
#import "AFHTTPClient.h"

#define emptyField @"Заполните пустое поле пожалуйста!"
#define incorrectField @"Поле заполнено не верно!"
#define genderField @"Выберите половую пренадлежность!"
#define dateField @"Выберите дату пожалуйста!"

@protocol PostDelegate3 <NSObject>
-(void)moveToStepTwo;
-(void)openPickerForImage;
-(void)getBack;
@end

@interface MGStepThird : UIScrollView <UITextFieldDelegate, PostDelegate3, SearchDropDownDelegate, CustomIOS7AlertViewDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@property (assign) id <PostDelegate3> mainDelegate;

@property (strong, nonatomic) NSMutableArray *scopesArray;


-(void)initAllObjects;

-(void)showView;

-(void)hideView;

-(void)checkSelectedPhoto:(NSString *)string;

@end
