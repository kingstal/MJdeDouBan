//
//  MJMovieDetailCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieDetailCell.h"
#import "MMPlaceHolder.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MJMovieDetailCell ()

@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;
@property (weak, nonatomic) IBOutlet ScoreStarsView* starRatingView;
@property (weak, nonatomic) IBOutlet UILabel* scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel* voteCountLabel;
@property (weak, nonatomic) IBOutlet UILabel* genresLabel;
@property (weak, nonatomic) IBOutlet UILabel* regionDurationLabel;
@property (weak, nonatomic) IBOutlet UILabel* releaseDateLabel;

@end

@implementation MJMovieDetailCell

+ (void)registerNibWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"MJMovieDetailCell";

    UINib* directorNib = [UINib nibWithNibName:ID bundle:nil];
    [tableView registerNib:directorNib forCellReuseIdentifier:ID];
}

+ (MJMovieDetailCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"MJMovieDetailCell";
    MJMovieDetailCell* detailsCell = [tableView dequeueReusableCellWithIdentifier:ID];
    return detailsCell;
}

- (void)awakeFromNib
{
    [self showPlaceHolderWithLineColor:[UIColor redColor]];
    // Initialization code
    self.posterImageView.layer.cornerRadius = self.posterImageView.frame.size.width / 2;
    self.posterImageView.layer.masksToBounds = YES;
}

- (void)setMovie:(MJMovie*)movie
{
    _movie = movie;

    [self.posterImageView sd_setImageWithURL:[NSURL URLWithString:movie.moviePosterUrl]];
    self.starRatingView.value = [movie.movieScore floatValue] / 10.0f;
    self.scoreLabel.text = movie.movieScore;
    self.voteCountLabel.text = [NSString stringWithFormat:@"%@人评价", movie.movieVoteCount];
    self.genresLabel.text = movie.movieGenre;
    self.regionDurationLabel.text = [NSString stringWithFormat:@"%@/%@", movie.movieRegion, movie.movieDuration];
    self.releaseDateLabel.text = movie.movieReleaseDate;
}

@end
