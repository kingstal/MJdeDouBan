//
//  MJBookDetailController.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/25.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreStarsView.h"
#import "MJBook.h"

@interface MJBookDetailController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MJBook* book;

@end
