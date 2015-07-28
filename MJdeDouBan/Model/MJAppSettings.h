//
//  MJAppSettings.h
//
//
//  Created by WangMinjun on 15/7/28.
//
//

#import <Foundation/Foundation.h>

extern NSString* const MJAppSettingsThemeChangedNotification;

@interface MJAppSettings : NSObject

+ (instancetype)sharedSettings;

@property (nonatomic, getter=isNightMode) BOOL nightMode;

@end
