//
//  MJLoadingView.m
//
//
//  Created by WangMinjun on 15/7/25.
//
//

#import "MJLoadingView.h"
#import "FeThreeDotGlow.h"

@interface MJLoadingView ()

@property (nonatomic, weak) FeThreeDotGlow* threeDotGlow;

@end

@implementation MJLoadingView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor grayColor];
        //        self.opaque = YES;
        //        self.alpha = 0.0;
        [self showLoadingView];
    }
    return self;
}

- (void)showLoadingView
{
    FeThreeDotGlow* threeDotGlow = [[FeThreeDotGlow alloc] initWithView:self blur:YES];

    CGRect frame = threeDotGlow.frame;
    CGPoint origin = CGPointMake(frame.origin.x, frame.origin.y - 64);
    threeDotGlow.frame = CGRectMake(origin.x, origin.y, frame.size.width, frame.size.height);

    [self addSubview:threeDotGlow];
    [threeDotGlow show];

    self.threeDotGlow = threeDotGlow;
}

- (void)hideLoadingView
{
    [UIView transitionWithView:self.superview
                      duration:0.3f
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^(void) {
                        [self removeFromSuperview];
                    }
                    completion:nil];
}

- (void)dealloc
{
    NSLog(@"loadingView dealloc-------");
}

@end
