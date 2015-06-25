//
//  MJBookNewController.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/24.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJNetworkLoadingViewController.h"

@interface MJBookNewController : UIViewController <UITableViewDataSource, UITableViewDelegate, MJNetworkLoadingViewDelegate>

@property (strong, nonatomic) NSString* flag; //用于区分虚构、非虚构的标识

@property (weak, nonatomic) IBOutlet UIView* networkLoadingContainerView;
@property (weak, nonatomic) IBOutlet UITableView* tableView;

@end
