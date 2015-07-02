//
//  BookDetailSecondCell.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/26.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BookDetailSecondCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel* authorDetailLabel;
@property (nonatomic, weak) IBOutlet UILabel* publishDetailLabel;
@property (nonatomic, weak) IBOutlet UILabel* publishTimeLabel;
@property (nonatomic, weak) IBOutlet UILabel* pageCountLabel;
@property (nonatomic, weak) IBOutlet UILabel* priceLabel;
@property (nonatomic, weak) IBOutlet UILabel* ISBNLabel;
@end
