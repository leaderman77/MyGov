//
//  WLImageGetHelper.m
//  StoreIt
//
//  Created by Tanzilya Yakshimbetova on 9/23/13.
//  Copyright (c) 2013 Velor. All rights reserved.
//

#import "WLImageGetHelper.h"

@implementation WLImageGetHelper
-(id) initWithURl:(NSString*) url andDelegate:(id<WLImageGetHelperProtocol>) delegate 
{
    if ([super init])
    {
        self.URL = url;
        self.delegate = delegate;
        self.imgData = [[NSMutableData alloc] initWithCapacity:0];
      
        NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:url]];
        NSURLConnection *connection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
            [connection start];
        }
        return  self;
    return NULL;
}
-(void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{

    [self.delegate imageReady:[UIImage imageNamed:@"icon_camera.png"] withURL:self.URL];
}
-(void) connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [self.imgData appendData:data ];

}
-(void) connectionDidFinishLoading:(NSURLConnection *)connection
{
   [self.delegate imageReady:[UIImage imageWithData:self.imgData] withURL:self.URL ];
}
@end
