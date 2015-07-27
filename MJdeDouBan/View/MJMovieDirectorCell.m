//
//  MJMovieDirectorCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieDirectorCell.h"

@implementation MJMovieDirectorCell

+ (void)registerNibWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"MJMovieDirectorCell";
    UINib* directorNib = [UINib nibWithNibName:ID bundle:nil];
    [tableView registerNib:directorNib forCellReuseIdentifier:ID];
}

+ (MJMovieDirectorCell*)cellWithTableView:(UITableView*)tableView
{

    static NSString* ID = @"MJMovieDirectorCell";
    MJMovieDirectorCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

- (void)setMovie:(MJMovie*)movie
{
    _movie = movie;
    self.directorLabel.text = self.movie.movieDirector;
    self.actorLabel.text = self.movie.movieActor;
}

- (void)awakeFromNib
{
    // Initialization code
}

@end
