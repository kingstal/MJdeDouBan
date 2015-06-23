//
//  MJBookDetail.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/22.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJBookDetail : NSObject

@property (nonatomic, copy) NSString* bookId;
@property (nonatomic, copy) NSString* bookTitle;
@property (nonatomic, copy) NSString* bookPosterUrl;
@property (nonatomic, copy) NSString* bookAuthor;
@property (nonatomic, copy) NSString* bookPress;
@property (nonatomic, copy) NSString* bookSubTitle;
@property (nonatomic, copy) NSString* bookOriginalTitle;
@property (nonatomic, copy) NSString* bookPublishTime;
@property (nonatomic, copy) NSString* bookPageCount;
@property (nonatomic, copy) NSString* bookPrice;
@property (nonatomic, copy) NSString* bookBinding; //装帧
@property (nonatomic, copy) NSString* bookISBN;
@property (nonatomic, copy) NSString* bookScore;
@property (nonatomic, copy) NSString* bookVoteCount;
@property (nonatomic, copy) NSString* bookSummary; //内容简介
@property (nonatomic, copy) NSString* bookAuthorSummary; //作者简介

@property (nonatomic, copy) NSArray* tags; //豆瓣成员常用标签

@end
