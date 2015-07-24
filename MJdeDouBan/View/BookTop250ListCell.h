//
//  BookTop250ListCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/23.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJBook.h"

@interface BookTop250ListCell : UITableViewCell

@property (nonatomic, strong) MJBook* book;

+ (BookTop250ListCell*)cellWithTableView:(UITableView*)tableView;
@end
