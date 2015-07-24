//
//  BookDetailSecondCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/26.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJBookDetail.h"

@interface BookDetailSecondCell : UITableViewCell

@property (nonatomic, strong) MJBookDetail* bookDetail;

+ (void)registerNibWithTableView:(UITableView*)tableView;
+ (BookDetailSecondCell*)cellWithTableView:(UITableView*)tableView;
@end
