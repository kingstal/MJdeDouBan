//
//  MJCachedURLResponse.m
//
//
//  Created by WangMinjun on 15/7/27.
//
//
#import "MJCachedURLResponse.h"

static NSString* const kDataKey = @"data";
static NSString* const kResponseKey = @"response";

@implementation MJCachedURLResponse

- (id)initWithCoder:(NSCoder*)aDecoder
{
    self = [super init];
    if (self) {
        _data = [aDecoder decodeObjectForKey:kDataKey];
        _response = [aDecoder decodeObjectForKey:kResponseKey];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder*)aCoder
{
    [aCoder encodeObject:self.data forKey:kDataKey];
    [aCoder encodeObject:self.response forKey:kResponseKey];
}

@end
