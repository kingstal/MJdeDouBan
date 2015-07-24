//
//  BookHotListCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/24.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJBook.h"

@interface BookHotListCell : UITableViewCell

@property (nonatomic, strong) MJBook* book;
+ (BookHotListCell*)cellWithTableView:(UITableView*)tableView;

@end
