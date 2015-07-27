//
//  MJMovieDetailCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreStarsView.h"
#import "MJMovie.h"

@interface MJMovieDetailCell : UITableViewCell

@property (strong, nonatomic) MJMovie* movie;

+ (void)registerNibWithTableView:(UITableView*)tableView;
+ (MJMovieDetailCell*)cellWithTableView:(UITableView*)tableView;

@end
