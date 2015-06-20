//
//  MJMovieMasterViewController.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/10.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJNetworkLoadingViewController.h"

@interface MJHotMovieMasterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MJNetworkLoadingViewDelegate>

@property (weak, nonatomic) IBOutlet UIView* networkLoadingContainerView;
@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end
