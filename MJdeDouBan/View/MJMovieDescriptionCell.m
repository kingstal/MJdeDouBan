//
//  MJMovieDescriptionCell.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovieDescriptionCell.h"
#import "MMPlaceHolder.h"

@interface MJMovieDescriptionCell ()

@property (weak, nonatomic) IBOutlet UILabel* movieSummaryLabel;

@end

@implementation MJMovieDescriptionCell

+ (void)registerNibWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"MJMovieDescriptionCell";

    UINib* directorNib = [UINib nibWithNibName:ID bundle:nil];
    [tableView registerNib:directorNib forCellReuseIdentifier:ID];
}

+ (MJMovieDescriptionCell*)cellWithTableView:(UITableView*)tableView
{
    static NSString* ID = @"MJMovieDescriptionCell";
    MJMovieDescriptionCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    return cell;
}

- (void)setMovie:(MJMovie*)movie
{
    _movie = movie;
    self.movieSummaryLabel.text = movie.movieSummary;
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
