//
//  MJComingSoonMovieListCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/17.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJComingSoonMovieListCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface MJComingSoonMovieListCell ()

@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* dateLabel;
@property (weak, nonatomic) IBOutlet UILabel* genreLabel;
@property (weak, nonatomic) IBOutlet UILabel* regionLabel;
@property (weak, nonatomic) IBOutlet UILabel* peopleWantSeeLabel;

- (IBAction)btnPressed:(id)sender;
@end

@implementation MJComingSoonMovieListCell

+ (MJComingSoonMovieListCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"MJComingSoonMovieListCell";
    MJComingSoonMovieListCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

- (void)setMovie:(MJMovie*)movie
{
    _movie = movie;
    [self.posterImageView sd_setImageWithURL:[movie valueForKey:@"moviePosterUrl"] placeholderImage:nil];
    [self.titleLabel setText:[movie valueForKey:@"movieTitle"]];
    [self.dateLabel setText:[movie valueForKey:@"movieReleaseDate"]];
    [self.genreLabel setText:[movie valueForKey:@"movieGenre"]];
    [self.regionLabel setText:[movie valueForKey:@"movieRegion"]];
    [self.peopleWantSeeLabel setText:[movie valueForKey:@"moviePeopleLike"]];
}

- (IBAction)btnPressed:(id)sender
{
    if ([self.deleaget respondsToSelector:@selector(comingSoonMovieListCellBtnPressed:)]) {
        [self.deleaget comingSoonMovieListCellBtnPressed:self];
    }
}
@end
