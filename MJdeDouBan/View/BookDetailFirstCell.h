//
//  BookDetailFirstCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/26.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScoreStarsView.h"

@interface BookDetailFirstCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UIImageView* posterImageView;
@property (nonatomic, weak) IBOutlet UILabel* titleLabel;
@property (nonatomic, weak) IBOutlet ScoreStarsView* scoreStarView;
@property (nonatomic, weak) IBOutlet UILabel* scoreLabel;
@property (nonatomic, weak) IBOutlet UILabel* voteCountLabel;
@property (nonatomic, weak) IBOutlet UILabel* authorLabel;
@property (nonatomic, weak) IBOutlet UILabel* publishLabel;
@end
