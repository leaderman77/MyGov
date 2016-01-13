//
//  MGHistoryCell.m
//  MyGov
//
//  Created by Alpha on 28.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import "MGHistoryCell.h"
#import "Constant.h"

@implementation MGHistoryCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        reuseID = reuseIdentifier;
        
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, 195, 30)];
        [self.nameLabel setTextColor:[UIColor grayColor]];
        [self.nameLabel setTextColor:RGB(86, 86, 86)];
        [self.nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue" size:13.0f]];
        [self.nameLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
        self.nameLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.nameLabel];
        
        self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width-98, 0, 90, 30)];
        [self.dateLabel setTextColor:[UIColor whiteColor]];
        [self.dateLabel setFont:[UIFont fontWithName:@"Helvetica" size:13.0f]];
        self.dateLabel.backgroundColor = [UIColor clearColor];
        
        [self.contentView addSubview:self.dateLabel];
        
        self.dateBG = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-110, 6, 90, 18)];
        [self.dateBG setBackgroundColor:RGB(190, 195, 199)];
        self.dateBG.layer.cornerRadius = 4;
        self.dateBG.clipsToBounds = YES;
        self.dateBG.backgroundColor = [UIColor clearColor];
        
        [self.contentView insertSubview:self.dateBG belowSubview:self.dateLabel];
        
        self.arrow = [[UIImageView alloc] initWithFrame:CGRectMake(self.frame.size.width-10, 10, 5, 9)];
        [self.arrow setImage:[UIImage imageNamed:@"arrow_h.png"]];
        self.arrow.contentMode = UIViewContentModeCenter;
        
        [self.contentView addSubview:self.arrow];
        
        self.line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 29.5, self.contentView.frame.size.width, 0.5f)];
        [self.line setBackgroundColor:RGB(210, 210, 210)];
        
        [self.contentView addSubview:self.line];
        
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setColorToDateBG:(NSString *)colorType {
    if ([colorType isEqualToString:@"redColor"])
    {
        [self.dateBG setBackgroundColor:RGB(247, 99, 84)];
    }
    else if ([colorType isEqualToString:@"grayColor"])
    {
        [self.dateBG setBackgroundColor:RGB(190, 195, 199)];
    }
    else if ([colorType isEqualToString:@"blueColor"])
    {
        [self.dateBG setBackgroundColor:RGB(118, 195, 247)];
    }
    else if ([colorType isEqualToString:@"yellowColor"])
    {
        [self.dateBG setBackgroundColor:RGB(245, 247, 118)];
    }
    else if ([colorType isEqualToString:@"violetColor"])
    {
        [self.dateBG setBackgroundColor:RGB(167, 118, 247)];
    }
    else if ([colorType isEqualToString:@"greenColor"])
    {
        [self.dateBG setBackgroundColor:RGB(173, 247, 118)];
    }
}




@end
