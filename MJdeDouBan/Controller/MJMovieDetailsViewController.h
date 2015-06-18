//
//  KMMovieDetailsViewController.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/11.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MJDetailsPageView.h"
#import "MJMovie.h"
#import "MJNetworkLoadingViewController.h"

@interface MJMovieDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, MJDetailsPageDelegate, MJNetworkLoadingViewDelegate>

//@property (weak, nonatomic) IBOutlet UIView* navigationBarView;
@property (weak, nonatomic) IBOutlet UIView* networkLoadingContainerView;
@property (weak, nonatomic) IBOutlet MJDetailsPageView* detailsPageView;
//@property (weak, nonatomic) IBOutlet UILabel* navBarTitleLabel;

@property (strong, nonatomic) MJMovie* movie;

@end
