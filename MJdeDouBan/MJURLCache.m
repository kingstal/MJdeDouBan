//
//  MJURLCache.h
//
//
//  Created by WangMinjun on 15/7/27.
//
//

#import "MJURLCache.h"
#import "MJCachedURLResponse.h"
#import "CWObjectCache.h"

@implementation MJURLCache

/**
 *  根据 request 返回缓存的 response
 */
- (NSCachedURLResponse*)cachedResponseForRequest:(NSURLRequest*)request
{
    NSString* cacheKey = [request URL].absoluteString;
    MJCachedURLResponse* cachedResponse = [[CWObjectCache sharedCache] objectForKey:cacheKey];
    if (cachedResponse && cachedResponse.response && cachedResponse.data) {
        return [[NSCachedURLResponse alloc] initWithResponse:cachedResponse.response data:cachedResponse.data];
        ;
    }

    return [super cachedResponseForRequest:request];
}

@end
