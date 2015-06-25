//
//  BookHotListCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/24.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreStarsView.h"

@interface BookHotListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UILabel* rankingTimeLabel;
@property (weak, nonatomic) IBOutlet UILabel* subTitleLabel;
@property (weak, nonatomic) IBOutlet UILabel* scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel* votecountLabel;
@property (weak, nonatomic) IBOutlet ScoreStarsView* scoreStarsView;
@end
