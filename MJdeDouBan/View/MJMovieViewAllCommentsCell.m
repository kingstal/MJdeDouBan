//
//  MJMovieViewAllCommentsCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieViewAllCommentsCell.h"

@implementation MJMovieViewAllCommentsCell

+ (MJMovieViewAllCommentsCell*)movieViewAllCommentsCell
{
    MJMovieViewAllCommentsCell* cell = [[[NSBundle mainBundle] loadNibNamed:@"MJMovieViewAllCommentsCell" owner:self options:nil] objectAtIndex:0];
    cell.selectionStyle = UITextAutocapitalizationTypeNone;
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
