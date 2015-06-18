//
//  Review.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/18.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 *  影评
 */
@interface MJReview : NSObject

@property (nonatomic, copy) NSString* avatarUrl;
@property (nonatomic, copy) NSString* title;
@property (nonatomic, copy) NSString* username;
@property (nonatomic, copy) NSString* commnetTime;
@property (nonatomic, copy) NSString* score;
@property (nonatomic, copy) NSString* content;
@property (nonatomic, copy) NSString* percentUse; //5/5有用
@end
