//
//  MJHTTPFetcher.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/10.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "MJMovie.h"

@class MJHTTPFetcher;

typedef void (^MJHTTPFetcherErrorBlock)(MJHTTPFetcher* fetcher, NSError* error);
typedef void (^MJHTTPFetcherSuccessBlock)(MJHTTPFetcher* fetcher, id data);

@interface MJHTTPFetcher : NSObject

/**
 *  The network request operation
 */
@property (nonatomic, strong) NSOperation* requestOperation;

+ (MJHTTPFetcher*)sharedFetcher;

/**
 *  根据城市获得热门电影
 */
- (void)fetchHotMovieWithCity:(NSString*)city success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock;

/**
 *  根据movieId获得电影详情
 */
- (void)fetchMovieDetailWithMovie:(MJMovie*)movie success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock;

/**
 *  根据城市获得即将上映电影
 */
- (void)fetchComingSoonMovieWithCity:(NSString*)city success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock;

/**
 *  获取影评
 */
- (void)fetchMovieReviewWithMovie:(MJMovie*)movie start:(NSInteger)start limit:(NSInteger)limit success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock;

/**
 *  根据下标获取豆瓣图书 Top250
 */
- (void)fetchBookTop250WithStart:(NSInteger)start success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock;

/**
 *  根据虚构、非虚构分类获取豆瓣新书
 */
- (void)fetchBookNewWithFlag:(NSString*)flag success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock;

/**
 *  根据虚构、非虚构分类获取豆瓣热门图书
 */
- (void)fetchBookHotWithFlag:(NSString*)flag success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock;

/**
 *  根据movieId获得电影详情
 */
- (void)fetchBookDetailWithBookId:(NSString*)bookId success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock;

/**
 *  Invokes [self.requestOperation cancel] to cancel the network request
 */
- (void)cancel;
@end
