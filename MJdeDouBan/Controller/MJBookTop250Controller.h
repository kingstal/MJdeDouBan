//
//  MJBookTop250.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/23.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJNetworkLoadingViewController.h"

@interface MJBookTop250Controller : UIViewController <UITableViewDataSource, UITableViewDelegate, MJNetworkLoadingViewDelegate>

@property (weak, nonatomic) IBOutlet UIView* networkLoadingContainerView;
@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end
