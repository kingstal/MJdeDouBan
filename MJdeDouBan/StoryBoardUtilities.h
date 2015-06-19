
#import <UIKit/UIKit.h>
#import <objc/runtime.h>

@interface StoryBoardUtilities : NSObject

+ (UIViewController*)viewControllerForStoryboardName:(NSString*)storyboardName class:(id) class;

@end
