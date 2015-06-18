//
//  MJComingSoonMovieListCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/17.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJComingSoonMovieListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* dateLabel;
@property (weak, nonatomic) IBOutlet UILabel* genreLabel;
@property (weak, nonatomic) IBOutlet UILabel* regionLabel;
@property (weak, nonatomic) IBOutlet UILabel* peopleWantSeeLabel;

@end
