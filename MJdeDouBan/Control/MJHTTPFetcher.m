//
//  MJHTTPFetcher.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/10.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJHTTPFetcher.h"
#import "AFNetworking.h"
#import "MJMovie.h"
#import "MJExtension.h"
#import "MJReview.h"

@implementation MJHTTPFetcher

+ (MJHTTPFetcher*)sharedFetcher
{
    static MJHTTPFetcher* _sharedFetcher = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedFetcher = [[self alloc] init];
    });
    return _sharedFetcher;
}

/**
 *  实例化一个AFHTTPRequestOperationManager，用于解析 json
 */
- (AFHTTPRequestOperationManager*)JSONRequestOperationManager
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    // fixed server text/html issue
    NSSet* acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/plain", @"text/html", nil];
    [manager.responseSerializer setAcceptableContentTypes:acceptableContentTypes];
    return manager;
}

/**
 *  实例化一个通用的AFHTTPRequestOperationManager
 */
- (AFHTTPRequestOperationManager*)HTTPRequestOperationManager
{
    AFHTTPRequestOperationManager* manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    return manager;
}

#pragma mark - API

- (void)fetchHotMovieWithCity:(NSString*)city success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock
{
    NSString* url = [NSString stringWithFormat:@"http://mjdedouban.sinaapp.com/hotMovie?city=%@", city];
    NSLog(@"fetch hot movies-------%@", url);

    self.requestOperation = [[self JSONRequestOperationManager] GET:url
        parameters:nil
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // 解析热门电影
            NSArray* array = (NSArray*)responseObject;
            NSMutableArray* movies = [NSMutableArray new];
            for (id movie in array) {
                [movies addObject:[MJMovie objectWithKeyValues:movie]];
            }
            successBlock(self, movies);
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            errorBlock(self, error);
            NSLog(@"error:%@", error);
        }];
}

- (void)fetchMovieDetailWithMovie:(MJMovie*)movie success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock
{
    NSString* url = [NSString stringWithFormat:@"http://mjdedouban.sinaapp.com/movieDetail?movieId=%@", movie.movieId];
    if ([movie.movieType isEqualToString:@"comingsoon"]) {
        url = [NSString stringWithFormat:@"%@&type=%@", url, movie.movieType];
    }
    NSLog(@"fetch movieDetail-------%@", url);

    self.requestOperation = [[self JSONRequestOperationManager] GET:url
        parameters:nil
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // 解析电影详情
            MJMovie* newMovie = [MJMovie objectWithKeyValues:responseObject];
            movie.movieDirector = newMovie.movieDirector;
            movie.movieCelebrity = newMovie.movieCelebrity;
            movie.movieActor = newMovie.movieActor;
            movie.movieGenre = newMovie.movieGenre;
            movie.movieRegion = newMovie.movieRegion;
            movie.movieLanguage = newMovie.movieLanguage;
            movie.movieReleaseDate = newMovie.movieReleaseDate;
            movie.movieDuration = newMovie.movieDuration;
            movie.movieSummary = newMovie.movieSummary;
            movie.reviewCount = newMovie.reviewCount;
            for (NSDictionary* dic in newMovie.similarMovies) {
                [movie.similarMovies addObject:[MJMovie objectWithKeyValues:dic]];
            }
            if ([movie.movieType isEqualToString:@"comingsoon"]) {
                movie.movieScore = newMovie.movieScore;
                movie.movieVoteCount = newMovie.movieVoteCount;
            }
            successBlock(self, movie);
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            errorBlock(self, error);
            NSLog(@"%@", error);
        }];
}

- (void)fetchComingSoonMovieWithCity:(NSString*)city success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock
{
    NSString* url = [NSString stringWithFormat:@"http://mjdedouban.sinaapp.com/comingMovie?city=%@", city];
    NSLog(@"etch comingsoon movies-------%@", url);

    self.requestOperation = [[self JSONRequestOperationManager] GET:url
        parameters:nil
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            // 解析即将上映电影
            NSArray* array = (NSArray*)responseObject;
            NSMutableArray* movies = [NSMutableArray new];
            for (id movie in array) {
                [movies addObject:[MJMovie objectWithKeyValues:movie]];
            }
            successBlock(self, movies);
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            errorBlock(self, error);
            NSLog(@"error:%@", error);
        }];
}

- (void)fetchMovieReviewWithMovie:(MJMovie*)movie start:(NSInteger)start limit:(NSInteger)limit success:(MJHTTPFetcherSuccessBlock)successBlock failure:(MJHTTPFetcherErrorBlock)errorBlock
{
    NSString* url = [NSString stringWithFormat:@"http://mjdedouban.sinaapp.com/review?movieId=%@&start=%ld&limit=%ld", movie.movieId, (long)start, (long)limit];
    NSLog(@"fetch reviews-------%@", url);

    self.requestOperation = [[self JSONRequestOperationManager] GET:url
        parameters:nil
        success:^(AFHTTPRequestOperation* operation, id responseObject) {
            NSArray* array = (NSArray*)responseObject;
            for (id review in array) {
                [movie.reviews addObject:[MJReview objectWithKeyValues:review]];
            }
            successBlock(self, movie);
        }
        failure:^(AFHTTPRequestOperation* operation, NSError* error) {
            errorBlock(self, error);
            NSLog(@"error:%@", error);
        }];
}

- (void)cancel
{
    [self.requestOperation cancel];
}
@end