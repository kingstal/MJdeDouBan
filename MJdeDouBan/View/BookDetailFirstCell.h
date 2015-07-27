//
//  BookDetailFirstCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/26.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreStarsView.h"
#import "MJBookDetail.h"

@interface BookDetailFirstCell : UITableViewCell
@property (nonatomic, strong) MJBookDetail* bookDetail;

+ (void)registerNibWithTableView:(UITableView*)tableView;
+ (BookDetailFirstCell*)cellWithTableView:(UITableView*)tableView;
@end
