//
//  MJMovieDirectorCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/12.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJMovieDirectorCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* directorLabel;
@property (nonatomic, weak) IBOutlet UILabel* actorLabel;

+ (MJMovieDirectorCell*)movieDirectorCell;

@end
