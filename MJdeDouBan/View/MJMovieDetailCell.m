//
//  MJMovieDetailCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieDetailCell.h"
#import "MMPlaceHolder.h"

@implementation MJMovieDetailCell

+ (MJMovieDetailCell*)movieDetailsCell
{
    MJMovieDetailCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"MJMovieDetailCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)awakeFromNib
{
    [self showPlaceHolderWithLineColor:[UIColor redColor]];
    // Initialization code
    self.posterImageView.layer.cornerRadius = self.posterImageView.frame.size.width / 2;
    self.posterImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
