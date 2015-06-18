//
//  MJMovieDescriptionCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJMovieDescriptionCell : UITableViewCell
+ (MJMovieDescriptionCell*)movieDescriptionCell;

@property (weak, nonatomic) IBOutlet UILabel* movieSummaryLabel;

@end
