//
//  MJMovieDirectorCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieDirectorCell.h"

@implementation MJMovieDirectorCell

+ (MJMovieDirectorCell*)movieDirectorCell
{
    MJMovieDirectorCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"MJMovieDirectorCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
