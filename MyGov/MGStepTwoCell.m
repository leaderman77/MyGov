//
//  MGStepTwoCell.m
//  MyGov
//
//  Created by Alexander Makshov on 10.04.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGStepTwoCell.h"
#import "SSCheckBoxView.h"

@implementation MGStepTwoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        // тут надо инитить и добавлять все что нужно
        
        //cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.backgroundView = [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"check_box_bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
        self.selectedBackgroundView =  [[UIImageView alloc] initWithImage:[ [UIImage imageNamed:@"check_box_bg.png"] stretchableImageWithLeftCapWidth:0.0 topCapHeight:5.0] ];
        
        self.cbv = nil;
        CGRect frame = CGRectMake(0, -2, 70, 30);
        
        SSCheckBoxViewStyle style = 1;
        self.cbv = [[SSCheckBoxView alloc] initWithFrame:frame
                                                   style:style
                                                 checked:NO];
        //[self.cbv setText:[NSString stringWithFormat:@""]];
        self.cbv.userInteractionEnabled = NO;
        [self.contentView addSubview:self.cbv];
        
        self.mgLabel = [[UILabel alloc] initWithFrame:CGRectMake(25, 0, 300, 31)];
        self.mgLabel.font = [UIFont fontWithName:@"Helvetica" size:13];
        self.mgLabel.textColor = [UIColor grayColor];
        self.mgLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.mgLabel];
        
        
        [self.cbv setText:@""];
        
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
    // тут не надо добавлять!
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
