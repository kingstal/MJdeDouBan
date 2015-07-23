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

@interface MJMovieDetailsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, MJDetailsPageDelegate>

@property (strong, nonatomic) MJMovie* movie;

@end
