//
//  MJMovieDirectorCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJMovie.h"

@interface MJMovieDirectorCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* directorLabel;
@property (nonatomic, weak) IBOutlet UILabel* actorLabel;

@property (strong, nonatomic) MJMovie* movie;

+ (void)registerNibWithTableView:(UITableView*)tableView;
+ (MJMovieDirectorCell*)cellWithTableView:(UITableView*)tableView;

@end
