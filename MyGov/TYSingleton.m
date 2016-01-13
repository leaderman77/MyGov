//
//  TYSingleton.m
//  Yordam
//
//  Created by Tanzilya Yakshimbetova on 12/13/13.
//  Copyright (c) 2013 GS. All rights reserved.
//

#import "TYSingleton.h"

@implementation TYSingleton
static TYSingleton *_instance;
+(TYSingleton*) getinstance;
{
    if(_instance==NULL)
    {
        _instance=[[TYSingleton alloc]init];
        [_instance initWithDictionaries];
        
    }
    return _instance;
}

-(id)init
{
    if ([super init]) {
        self.FacebookToken = @"";
        self.IDUZToken = @"";
        self.MyList = [[NSMutableArray  alloc] initWithCapacity:0];
        self.authtype = @"";
        self.token_secret = @"";
        self.currentAddress = @"";
        self.dictAllSph = [[NSMutableArray alloc] initWithCapacity:0];
        self.dictAllReg = [[NSMutableArray alloc] initWithCapacity:0];
        self.dictIDSph = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.dictIDReg = [[NSMutableDictionary alloc] initWithCapacity:0];
        self.updateStat = @"false";
        self.deleteStat = @"0";
        self.currentAddress = @"Выбрать местоположение";
        self.IDUZclick = @"";
        self.userPrivateData = [[NSMutableDictionary alloc] init];
        self.allCatID = [[NSMutableArray alloc] init];
        self.allSubID = [[NSMutableArray alloc] init];
        self.allAuthorityId = [[NSMutableDictionary alloc] init];
        self.imageFromPhone = [[UIImage alloc] init];
        self.imageFromPhoneName = @"";
        
        self.oauth_token = @"";
        self.oauth_token_secret = @"";
        
        if (!IS_OS_7_OR_LATER) {
            self.insetY = (int) (sb_height/2);
            self.insetYOrigin = (int) (sb_height);
        } else {
            self.insetY = 0;
        }
        
        return self;
    }
    return NULL;
}
-(void) initWithDictionaries
{
    NSMutableArray *ar1 = [[NSUserDefaults standardUserDefaults] objectForKey:AllSph];
    if (ar1 !=NULL) {
        self.dictAllSph = [self arrayToNodeList:ar1];
    }

    NSMutableArray *ar2 = [[NSUserDefaults standardUserDefaults] objectForKey:AllReg];
    if (ar2 != NULL) {
        self.dictAllReg = [self arrayToNodeList:ar2];
    }
    
    NSMutableDictionary *dict1 = [[NSUserDefaults standardUserDefaults] objectForKey:SphWithID];
    if (dict1!=NULL)
    {
        for (int i =0; i<[dict1 count]; i++)
        {

            [self.dictIDSph setObject:[self arrayToNodeList:[dict1 objectForKey:[[dict1 allKeys] objectAtIndex:i]] ] forKey:[[dict1 allKeys] objectAtIndex:i]];
        }
    }
    NSMutableDictionary *dict2 = [[NSUserDefaults standardUserDefaults] objectForKey:RegWithID];
    if (dict2 != NULL) {
        for (int i =0; i<[dict2 count]; i++)
        {
            [self.dictIDReg setObject:[self arrayToNodeList:[dict2 objectForKey:[[dict2 allKeys] objectAtIndex:i]] ] forKey:[[dict2 allKeys] objectAtIndex:i]];
 
        }

    }
}
-(void) saveToDictionary
{
    NSMutableArray *array = [[NSMutableArray alloc] initWithCapacity:0];
    array = [self arrayToArray:self.dictAllSph];
    [[NSUserDefaults standardUserDefaults] setObject:array forKey:AllSph];
    NSMutableArray *array2 = [[NSMutableArray alloc] initWithCapacity:0];
    array2 = [self arrayToArray:self.dictAllReg];
    [[NSUserDefaults standardUserDefaults] setObject:array2 forKey:AllReg];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (int i=0; i< [self.dictIDSph count]; i++)
    {
        [dict setObject:[self arrayToArray:[self.dictIDSph objectForKey:[[self.dictIDSph allKeys] objectAtIndex:i]]] forKey:[[self.dictIDSph allKeys] objectAtIndex:i]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:SphWithID];
    NSMutableDictionary *dict2 = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (int i=0; i< [self.dictIDReg count]; i++)
    {
        [dict2 setObject:[self arrayToArray:[self.dictIDReg objectForKey:[[self.dictIDReg allKeys] objectAtIndex:i]]] forKey:[[self.dictIDReg allKeys] objectAtIndex:i]];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dict2 forKey:RegWithID];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}
-(NSMutableArray*) arrayToArray: (NSMutableArray*) arr
{
    NSMutableArray *changed = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i< [arr count]; i++) {
        [changed addObject:[[arr objectAtIndex:i] savetoDictionary]];
    }
    return changed;
}
-(NSMutableArray*) arrayToNodeList: (NSMutableArray*) arr
{
    NSMutableArray *changed = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i=0; i< [arr count]; i++) {
        TYNodeList *node = [[TYNodeList alloc] initWithDictionary:[arr objectAtIndex:i]];
        [changed addObject: node];
    }
    return changed;
}

@end
