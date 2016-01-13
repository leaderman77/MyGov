//
//  TYAppeal.m
//  Yordam
//
//  Created by Tanzilya Yakshimbetova on 12/16/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "TYAppeal.h"

@implementation TYAppeal
-(id) init
{
    if ([super init])
    {
        self.IdApp = @"";
        self.date = @"" ;
        self.from = @"";
        self.sph = @"";
        self.cat = @"";
        self.region = @"";
        self.ray = @"";
        self.mah = @"";
        self.str = @"";
        self.dom = @"";
        self.orient = @"";
        self.text = @"";
        self.cmnt = @"";
        self.state = @"";
        self.lat = @"";
        self.lng = @"";
        self.f1 = @"";
        self.f2 = @"";
        self.f3 = @"";
        self.f4 = @"";
        self.f5 = @"";
        self.url = @"";
        self.tel = @"";
        self.gosfile = @"";
        self.f1img = [UIImage imageNamed:@"yordam_obrashenie_foto_block_klik"];
        self.f2img = [UIImage imageNamed:@"yordam_obrashenie_foto_block_klik"];
        self.f3img = [UIImage imageNamed:@"yordam_obrashenie_foto_block_klik"];
        self.f4img = [UIImage imageNamed:@"yordam_obrashenie_foto_block_klik"];
        self.f5img = [UIImage imageNamed:@"yordam_obrashenie_foto_block_klik"];
        return self;
    }
    return NULL;
}
-(id) initWithDictionary:(NSDictionary *) dictionary
{
    if ([self init])
    {
        self.IdApp = [dictionary objectForKey:thisId];
        self.date = [dictionary objectForKey:thisDate];
        self.from = [dictionary objectForKey:thisFrom];
        self.sph = [dictionary objectForKey:thisSph];
        self.cat = [dictionary objectForKey:thisCat];
        self.region = [dictionary objectForKey:thisReg];
        self.ray = [dictionary objectForKey:thisRay];
        self.mah = [dictionary objectForKey:thisMah];
        self.str = [dictionary objectForKey:thisStr];
        self.dom = [dictionary objectForKey:thisDom];
        self.orient = [dictionary objectForKey:thisOrient];
        self.text = [dictionary objectForKey:thisText];
        self.cmnt = [dictionary objectForKey:thisComment];
        self.state = [dictionary objectForKey:thisState];
        self.lat = [dictionary objectForKey:thisLat];
        self.lng = [dictionary objectForKey:thisLong];
        self.f1 = [dictionary objectForKey:thisF1];
        self.f2 = [dictionary objectForKey:thisF2];
        self.f3 = [dictionary objectForKey:thisF3];
        self.f4 = [dictionary objectForKey:thisF4];
        self.f5 = [dictionary objectForKey:thisF5];
        self.url = [dictionary objectForKey:thisUrl];
        self.tel = [dictionary objectForKey:thisTel];
        self.gosfile = [dictionary objectForKey:thisGFile];

    return self;
    }
    return NULL;

}
@end
