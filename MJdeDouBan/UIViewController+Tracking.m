//
//  UIViewController+Tracking.m
//
//
//  Created by WangMinjun on 15/7/24.
//
//

#import "UIViewController+Tracking.h"

#import <objc/runtime.h>

@implementation UIViewController (Tracking)

+ (void)load
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        // When swizzling a class method, use the following:
        // Class class = object_getClass((id)self);

        // the method might not exist in the class, but in its superclass
        //        SEL originalSelector = @selector(viewWillAppear:);
        SEL originalSelector = @selector(viewDidLoad);
        SEL swizzledSelector = @selector(xxx_viewDidLoad);

        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);

        // class_addMethod will fail if original method already exists
        BOOL didAddMethod = class_addMethod(class,
            originalSelector,
            method_getImplementation(swizzledMethod),
            method_getTypeEncoding(swizzledMethod));

        // the method doesn’t exist and we just added one
        if (didAddMethod) {
            class_replaceMethod(class,
                swizzledSelector,
                method_getImplementation(originalMethod),
                method_getTypeEncoding(originalMethod));
        }
        else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

#pragma mark - Method Swizzling

//- (void)xxx_viewWillAppear:(BOOL)animated
//{
//    [self xxx_viewWillAppear:animated];
//    NSLog(@"----viewWillAppear: %@----", self);
//}

- (void)xxx_viewDidLoad
{
    [self xxx_viewDidLoad];
    NSLog(@"----viewWillAppear: %@----", self);
}

@end