//
//  BookDetailSummaryCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/25.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJBookDetail.h"

@interface BookDetailSummaryCell : UITableViewCell
@property (nonatomic, strong) MJBookDetail* bookDetail;

+ (void)registerNibWithTableView:(UITableView*)tableView;
+ (BookDetailSummaryCell*)cellWithTableView:(UITableView*)tableView;

@end
