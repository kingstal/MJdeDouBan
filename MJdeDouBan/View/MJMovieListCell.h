//
//  MJMovieListCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/10.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJMovieListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* durationLabel;
@property (weak, nonatomic) IBOutlet UILabel* scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel* votecountLabel;

@end
