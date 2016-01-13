//
//  TYAppeal.h
//  Yordam
//
//  Created by Tanzilya Yakshimbetova on 12/16/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <Foundation/Foundation.h>
#define thisId @"ID"
#define thisDate @"date"
#define thisFrom @"from"
#define thisSph @"sph"
#define thisCat @"cat"
#define thisReg @"region"
#define thisRay @"ray"
#define thisMah @"man"
#define thisStr @"str"
#define thisDom @"dom"
#define thisOrient @"orient"
#define thisText @"text"
#define thisComment @"cmnt"
#define thisState @"state"
#define thisLat @"lat"
#define thisLong @"long"
#define thisF1 @"f1"
#define thisF2 @"f2"
#define thisF3 @"f3"
#define thisF4 @"f4"
#define thisF5 @"f5"
#define thisUrl @"url"
#define thisTel @"tel"
#define thisGFile @"gosfile"

@interface TYAppeal : NSObject 
@property (nonatomic, retain) NSString *IdApp;
@property (nonatomic, retain) NSString *date;
@property (nonatomic, retain) NSString *from;
@property (nonatomic, retain) NSString *sph;
@property (nonatomic, retain) NSString *cat;
@property (nonatomic, retain) NSString *region;
@property (nonatomic, retain) NSString *ray;
@property (nonatomic, retain) NSString *mah;
@property (nonatomic, retain) NSString *str;
@property (nonatomic, retain) NSString *dom;
@property (nonatomic, retain) NSString *orient;
@property (nonatomic, retain) NSString *text;
@property (nonatomic, retain) NSString *cmnt;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *lat;
@property (nonatomic, retain) NSString *lng;
@property (nonatomic, retain) NSString *f1;
@property (nonatomic, retain) NSString *f2;
@property (nonatomic, retain) NSString *f3;
@property (nonatomic, retain) NSString *f4;
@property (nonatomic, retain) NSString *f5;
@property (nonatomic, retain) UIImage *f1img;
@property (nonatomic, retain) UIImage *f2img;
@property (nonatomic, retain) UIImage *f3img;
@property (nonatomic, retain) UIImage *f4img;
@property (nonatomic, retain) UIImage *f5img;

@property (nonatomic, retain) NSString *url;
@property (nonatomic, retain) NSString *tel;
@property (nonatomic, retain) NSString *gosfile;
-(id) initWithDictionary:(NSDictionary *) dictionary;
@end
