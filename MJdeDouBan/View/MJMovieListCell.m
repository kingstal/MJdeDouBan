//
//  MJMovieListCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/10.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation MJMovieListCell

- (void)awakeFromNib
{
    // Initialization code
}

+ (MJMovieListCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"MJMovieListCell";
    MJMovieListCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

- (void)setMovie:(MJMovie*)movie
{
    _movie = movie;

    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:movie.moviePosterUrl] placeholderImage:nil];
    [self.titleLabel setText:movie.movieTitle];
    [self.votecountLabel setText:[NSString stringWithFormat:@"%@人评价", movie.movieVoteCount]];
    [self.scoreLabel setText:[NSString stringWithFormat:@"%@分", movie.movieScore]];
    [self.durationLabel setText:movie.movieDuration];
}

@end
