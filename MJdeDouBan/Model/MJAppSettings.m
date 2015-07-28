//
//  MJAppSettings.m
//
//
//  Created by WangMinjun on 15/7/28.
//
//

#import "MJAppSettings.h"

NSString* const MJAppSettingsThemeChangedNotification = @"MJAppSettingsThemeChangedNotification";

static NSString* const kNightModeKey = @"nightModeFixed";

@interface MJAppSettings ()

@property (nonatomic, strong) NSUserDefaults* userDefaults;

@end

@implementation MJAppSettings

+ (instancetype)sharedSettings
{
    static MJAppSettings* _settings = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _settings = [[MJAppSettings alloc] init];
    });
    return _settings;
}

- (id)init
{
    self = [super init];
    if (self) {
        _userDefaults = [NSUserDefaults standardUserDefaults];

        [_userDefaults registerDefaults:@{
            kNightModeKey : @NO,
        }];

        _nightMode = [_userDefaults boolForKey:kNightModeKey];
    }
    return self;
}

- (void)setNightMode:(BOOL)nightMode
{
    _nightMode = nightMode;
    [self.userDefaults setBool:nightMode forKey:kNightModeKey];

    [[NSNotificationCenter defaultCenter] postNotificationName:MJAppSettingsThemeChangedNotification object:self];
}

@end
