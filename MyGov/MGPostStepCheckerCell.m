//
//  MGPostStepCheckerCell.m
//  MyGov
//
//  Created by Alexander Makshov on 04.04.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGPostStepCheckerCell.h"

@implementation MGPostStepCheckerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    NSLog(@"Selected!");
}

@end
