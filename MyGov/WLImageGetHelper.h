//
//  WLImageGetHelper.h
//  StoreIt
//
//  Created by Tanzilya Yakshimbetova on 9/23/13.
//  Copyright (c) 2013 Velor. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol WLImageGetHelperProtocol
@required
-(void) imageReady:(UIImage*) image withURL:(NSString*) url ;
@end
@interface WLImageGetHelper : NSObject <NSURLConnectionDataDelegate, NSURLConnectionDelegate>
@property (nonatomic, retain) id<WLImageGetHelperProtocol> delegate;
@property (nonatomic, retain) NSString *URL;
-(id) initWithURl:(NSString*) url andDelegate:(id<WLImageGetHelperProtocol>) delegate ;
@property (nonatomic, retain) NSMutableData *imgData;


@end
