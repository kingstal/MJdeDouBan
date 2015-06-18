//
//  MJMovieDescriptionCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieDescriptionCell.h"
#import "MMPlaceHolder.h"

@implementation MJMovieDescriptionCell

+ (MJMovieDescriptionCell*)movieDescriptionCell
{
    MJMovieDescriptionCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"MJMovieDescriptionCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)awakeFromNib
{
    // Initialization code
    [self showPlaceHolderWithLineColor:[UIColor redColor]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
