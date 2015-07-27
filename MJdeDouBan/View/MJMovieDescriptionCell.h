//
//  MJMovieDescriptionCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJMovie.h"

@interface MJMovieDescriptionCell : UITableViewCell

+ (void)registerNibWithTableView:(UITableView*)tableView;
+ (MJMovieDescriptionCell*)cellWithTableView:(UITableView*)tableView;

@property (strong, nonatomic) MJMovie* movie;

@end
