//
//  TYConnectionClass.m
//  Yordam
//
//  Created by Tanzilya Yakshimbetova on 1/6/14.
//  Copyright (c) 2014 GS. All rights reserved.
//

#import "TYConnectionClass.h"

@implementation TYConnectionClass
-(id) initWithURl:(NSString*) url andDelegate:(id<TYConnectionProtocol>) delegate andParam:(NSString *)parametr andID:(NSString *)idNode
{
    if ([super init])
    {
        self.URL = url;
        self.delegate = delegate;
        self.dataConnect = [[NSMutableData alloc] initWithCapacity:0];
        self.param = parametr;
        self.idN = idNode;
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
        [connection start];
        return self;
    }
    return NULL;
}
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
//    NSLog(@"Нет подключения к интернету");
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.dataConnect appendData:data ];
    
}
-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSMutableArray *ListArray = [[NSMutableArray alloc] initWithCapacity:0];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization
                     JSONObjectWithData:self.dataConnect options:NSJSONReadingAllowFragments error:&error];
    if ([jsonObject isKindOfClass:[NSDictionary class]]){
        NSDictionary *deserializedDictionary = (NSDictionary *)jsonObject;
        NSMutableArray *arr = [deserializedDictionary objectForKey:self.param];
        for (int i=0; i<[arr count]; i++)
        {
            TYNodeList *node = [[TYNodeList alloc] initWithDictionary:[arr objectAtIndex:i]];
            [ListArray addObject:node];
        }
    }
    [self.delegate dataReady:ListArray withURL:self.URL andParam:self.param andID:self.idN] ;
}


@end
