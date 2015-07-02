//
//  MJBookDetailController.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/25.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreStarsView.h"
#import "MJNetworkLoadingViewController.h"

@interface MJBookDetailController : UIViewController <MJNetworkLoadingViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) NSString* bookId;
@property (weak, nonatomic) IBOutlet UIView* networkLoadingContainerView;

@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end
