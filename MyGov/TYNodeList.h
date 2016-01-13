//
//  TYNodeList.h
//  Yordam
//
//  Created by Tanzilya Yakshimbetova on 12/19/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import <Foundation/Foundation.h>
#define NodeId @"ID"
#define NodeValue @"value"
@interface TYNodeList : NSObject
@property (nonatomic, retain) NSString *IDNode;
@property (nonatomic, retain) NSString *ValueNode;
-(id) initWithDictionary:(NSDictionary *) dictionary;
-(NSMutableDictionary*) savetoDictionary;
@end
