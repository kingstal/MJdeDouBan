//
//  NSString+CWAdditions.h
//
//
//  Created by WangMinjun on 15/7/27.
//
//

#import <Foundation/Foundation.h>

@interface NSString (CWAdditions)

- (NSString*)cw_trimSpace;

- (NSString*)cw_md5;

- (NSString*)cw_URLEncodedString;

- (NSString*)cw_URLDecodedString;

@end
