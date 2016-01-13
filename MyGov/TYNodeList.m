//
//  TYNodeList.m
//  Yordam
//
//  Created by Tanzilya Yakshimbetova on 12/19/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "TYNodeList.h"

@implementation TYNodeList
-(id) init
{
    if ([super init])
    {
        self.IDNode = @"";
        self.ValueNode = @"";
    return self;
    }
    else
        return NULL;
}
-(id) initWithDictionary:(NSDictionary *) dictionary
{
    if ([self init])
    {
        self.IDNode = [dictionary objectForKey:NodeId];
        self.ValueNode = [dictionary objectForKey:NodeValue];
        
    return self;
    }
    return NULL;
}
-(NSMutableDictionary*) savetoDictionary
{
    NSMutableDictionary *dictionary = [[NSMutableDictionary alloc] initWithCapacity:0];
    [dictionary setObject:self.IDNode forKey:NodeId];
    [dictionary setObject:self.ValueNode forKey:NodeValue];
    return  dictionary;
}
@end
