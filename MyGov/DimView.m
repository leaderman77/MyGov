//
//  DimView.m
//  MyGov
//
//  Created by Станислав on 18.11.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "DimView.h"

@implementation DimView

-(id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor blackColor];
        self.alpha = 0.5f;
        self.tag = 1111;
        [self setUserInteractionEnabled:NO];
        
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
