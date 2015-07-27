//
//  MJCachedURLResponse.h
//
//
//  Created by WangMinjun on 15/7/27.
//
//

#import <Foundation/Foundation.h>

@interface MJCachedURLResponse : NSObject <NSCoding>

@property (nonatomic, strong) NSURLResponse* response;
@property (nonatomic, strong) NSData* data;

@end
