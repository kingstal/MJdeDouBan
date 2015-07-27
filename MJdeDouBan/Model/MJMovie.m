//
//  MJMovie.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/11.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJMovie.h"

@implementation MJMovie

- (instancetype)initWithDictionary:(NSDictionary*)dictionary
{
    self = [super init];
    if (self) {
        self.movieId = @"10440138";
        self.moviePosterUrl = @"http://img3.douban.com/view/movie_poster_cover/mpst/public/p2246217874.jpg";
        self.movieTitle = @"侏罗纪世界";
        self.movieScore = @"8.1";
        self.movieVoteCount = @"24807";
        self.movieDirector = @"布拉德·佩顿";
        self.movieCelebrity = @"卡尔顿·库斯";
        self.movieActor = @"道恩·强森/亚历珊德拉·达达里奥/卡拉·古奇诺/雅奇·潘嘉比/科尔顿·海恩斯/艾恩·格拉法德";
        self.movieGenre = @"动作/冒险/灾难";
        self.movieRegion = @"美国/澳大利亚";
        self.movieLanguage = @"英语";
        self.movieReleaseDate = @"2015-06-02(中国大陆)/2015-05-29(美国)";
        self.movieDuration = @"114分钟";
        self.movieSummary = @"雷·盖恩斯（道恩·强森 Dwayne Johnson 饰）正驱车前往旧金山，随着一声巨响，周围的树木与电线杆变得七扭八歪，紧急刹车查看状况的盖恩斯被眼前的景象“惊呆了”:公路被一条深不见底的裂隙截断，甚至错位，加油站被裂成两半隔着“峡谷”遥遥相对。随着这场超级地震毫无预 兆的来袭，整个城市浓烟滚滚、火光冲天，高楼大厦相继倒塌，到处都是惊慌失措的市民。更要命的是，如此强烈的地震，“摧枯拉朽”般粉碎了坚实的大坝，洪水如猛兽一般涌向已经水深火热的城市，“天崩地陷”的景象犹如“末日”已然来临…";
    }
    return self;
}

+(instancetype)movieWithDictionary:(NSDictionary*)dictionary
{
    return  [[self alloc]initWithDictionary:dictionary];
}

- (NSMutableArray*)similarMovies
{
    if (!_similarMovies) {
        _similarMovies = [NSMutableArray new];
    }
    return _similarMovies;
}

- (NSMutableArray*)reviews
{
    if (!_reviews) {
        _reviews = [[NSMutableArray alloc] initWithCapacity:10];
    }
    return _reviews;
}
@end
