//
//  MJBook.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/22.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJBook : NSObject

@property (nonatomic, copy) NSString* bookId;
@property (nonatomic, copy) NSString* bookPosterUrl;
@property (nonatomic, copy) NSString* bookTitle;
@property (nonatomic, copy) NSString* bookTitleEng;
@property (nonatomic, copy) NSString* bookSubTitle;
@property (nonatomic, copy) NSString* bookScore;
@property (nonatomic, copy) NSString* bookVoteCount;
@property (nonatomic, copy) NSString* bookSummary;
@property (nonatomic, copy) NSString* bookRankingTime;
@property (nonatomic, copy) NSString* bookPrice;
@end
