//
//  TYSingleton.h
//  Yordam
//
//  Created by Tanzilya Yakshimbetova on 12/13/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#define AllSph @"allsph"
#define AllReg @"allreg"
#define SphWithID @"sphwithid"
#define RegWithID @"regwithid"
#import "TYNodeList.h"

@interface TYSingleton : NSObject
+(TYSingleton*) getinstance;
@property (retain, nonatomic) NSString *FacebookToken;
@property (retain, nonatomic) NSString *IDUZToken;
@property (retain, nonatomic) NSMutableArray *MyList;
@property (assign, nonatomic) CLLocationCoordinate2D location;
@property (nonatomic, retain) NSString *authtype;
@property (nonatomic, retain) NSString *token_secret;
@property (nonatomic, retain) NSMutableArray *dictAllSph;
@property (nonatomic, retain) NSMutableArray *dictAllReg;
@property (nonatomic, retain) NSMutableDictionary *dictIDSph;
@property (nonatomic, retain) NSMutableDictionary *dictIDReg;
@property (nonatomic, retain) NSString *currentAddress;
@property (nonatomic, retain) NSString *updateStat;
@property (nonatomic, retain) NSString *IDUZclick;
@property (nonatomic, retain) NSString *deleteStat;

// properties added by me
@property (strong, nonatomic) NSMutableArray *step2Headers;
@property (strong, nonatomic) NSMutableArray *step2Body;
@property (strong, nonatomic) NSMutableArray *step3Scopes;
@property (strong, nonatomic) NSMutableArray *step3AnswerType;
@property (strong, nonatomic) NSMutableArray *step3Type;
@property (strong, nonatomic) NSMutableArray *step3Visibility;


@property (strong, nonatomic) NSMutableArray *selectedRows;
@property (strong, nonatomic) NSMutableArray *allCatID;
@property (strong, nonatomic) NSMutableArray *allSubID;

@property (strong, nonatomic) NSMutableDictionary *allAuthorityId;

@property (strong, nonatomic) NSMutableDictionary *userPrivateData;
@property (strong, nonatomic) NSString *oauth_token;
@property (strong, nonatomic) NSString *oauth_token_secret;

@property (strong, nonatomic) UIImage *imageFromPhone;
@property (strong, nonatomic) NSString *imageFromPhoneName;

// iOS 6 or iOS 7 detector
@property (nonatomic, assign) int insetY;
@property (nonatomic, assign) int insetYOrigin;

-(void) saveToDictionary;
-(void) initWithDictionaries;

@property (nonatomic, assign) BOOL sendOrNot;
@end






