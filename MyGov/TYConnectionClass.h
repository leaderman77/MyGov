//
//  TYConnectionClass.h
//  Yordam
//
//  Created by Tanzilya Yakshimbetova on 1/6/14.
//  Copyright (c) 2014 GS. All rights reserved.
//

#import <Foundation/Foundation.h>
#define BaseURLSPH @"http://ek.uz/ws/yordam/oauth/example/yordam.php?sph=all"
#define BaseURLSphID @"http://ek.uz/ws/yordam/oauth/example/yordam.php?sph="
#define BaseURLReg @"http://ek.uz/ws/yordam/oauth/example/yordam.php?reg=all"
#define BaseURLRegID @"http://ek.uz/ws/yordam/oauth/example/yordam.php?reg="
#define SphAll @"allsph"
#define RegAll @"allreg"
#define SphID @"cat"
#define RegID @"ray"
#import "TYNodeList.h"
@protocol TYConnectionProtocol
@required
-(void) dataReady:(NSMutableArray*)array withURL:(NSString*) url andParam:(NSString*)reqParam andID:(NSString*)idNode;
@end

@interface TYConnectionClass : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
@property (nonatomic, retain) id<TYConnectionProtocol> delegate;
-(id) initWithURl:(NSString*) url andDelegate:(id<TYConnectionProtocol>) delegate andParam:(NSString*)parametr andID:(NSString*)idNode;
@property (nonatomic, retain) NSString *URL;
@property (nonatomic, retain) NSMutableData *dataConnect;
@property (nonatomic, retain) NSString *param;
@property (nonatomic, retain) NSString *idN;
@end
