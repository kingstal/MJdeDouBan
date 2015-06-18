//
//  MJMovieCommentCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieCommentCell.h"
#import "MMPlaceHolder.h"

@implementation MJMovieCommentCell

+ (MJMovieCommentCell*)movieCommentCell
{
    MJMovieCommentCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"MJMovieCommentCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}
- (void)awakeFromNib
{
    [self showPlaceHolderWithLineColor:[UIColor redColor]];
    // Initialization code
    self.cellImageView.layer.cornerRadius = self.cellImageView.frame.size.width / 2;
    self.cellImageView.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
