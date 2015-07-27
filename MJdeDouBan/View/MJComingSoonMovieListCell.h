//
//  MJComingSoonMovieListCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/17.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJMovie.h"

@class MJComingSoonMovieListCell;

@protocol MJComingSoonMovieListCellDelegate <NSObject>
@optional
- (void)comingSoonMovieListCellBtnPressed:(MJComingSoonMovieListCell*)cell;
@end

@interface MJComingSoonMovieListCell : UITableViewCell
@property (strong, nonatomic) MJMovie* movie;
@property (weak, nonatomic) id<MJComingSoonMovieListCellDelegate> deleaget;

+ (MJComingSoonMovieListCell*)cellWithTableView:(UITableView*)tableView;
@end
