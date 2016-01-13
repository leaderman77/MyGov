//
//  MGHistoryCell.h
//  MyGov
//
//  Created by Alpha on 28.03.14.
//  Copyright (c) 2014 Global Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>


static NSString * const kCellIDTitle = @"CellWithTitle";

@interface MGHistoryCell : UITableViewCell
{
    NSString *reuseID;
}

@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UIImageView *dateBG;
@property (strong, nonatomic) UIImageView *arrow;
@property (strong, nonatomic) UIImageView *line;



-(void)setColorToDateBG:(NSString *)colorType;

@end
