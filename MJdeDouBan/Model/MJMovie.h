//
//  MJMovie.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/11.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJMovie : NSObject

@property (nonatomic, copy) NSString* movieId;
@property (nonatomic, copy) NSString* moviePosterUrl;
@property (nonatomic, copy) NSString* movieTitle;
@property (nonatomic, copy) NSString* movieScore;
@property (nonatomic, copy) NSString* movieVoteCount;
@property (nonatomic, copy) NSString* movieDirector;
@property (nonatomic, copy) NSString* movieCelebrity;
@property (nonatomic, copy) NSString* movieActor;
@property (nonatomic, copy) NSString* movieGenre;
@property (nonatomic, copy) NSString* movieRegion;
@property (nonatomic, copy) NSString* movieLanguage;
@property (nonatomic, copy) NSString* movieReleaseDate;
@property (nonatomic, copy) NSString* movieDuration;
@property (nonatomic, copy) NSString* movieSummary;

@property (nonatomic, copy) NSString* moviePeopleLike;
@property (nonatomic, copy) NSString* movieTrailerUrl;

@property (nonatomic, copy) NSMutableArray* movieSimilars;

@property (nonatomic, copy) NSString* movieType; //电影类型：热门 or 即将上映
@property (nonatomic, copy) NSString* reviewCount; //影评总数
@property (nonatomic, copy) NSMutableArray* reviews;

- (id)initWithDictionary:(NSDictionary*)dictionary;

@end
