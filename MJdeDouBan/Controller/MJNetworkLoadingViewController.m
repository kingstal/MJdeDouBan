//
//  MJNetworkLoadingViewController.m
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/10.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import "MJNetworkLoadingViewController.h"

@interface MJNetworkLoadingViewController ()

@property (strong, nonatomic) FeThreeDotGlow* threeDot;

@end

@implementation MJNetworkLoadingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"MJNetworkLoadingViewController load!");
    [self showLoadingView];
    // Do any additional setup after loading the view.
}

- (void)showLoadingView
{
    self.errorView.hidden = YES;
    self.noContentView.hidden = YES;

    _threeDot = [[FeThreeDotGlow alloc] initWithView:self.view blur:NO];
    [self.view addSubview:_threeDot];
    [_threeDot show];
    NSLog(@"show loading view!");
}

- (void)showErrorView
{
    _threeDot.hidden = YES;
    self.noContentView.hidden = YES;
    self.errorView.hidden = NO;
    NSLog(@"show error view!");
}

- (void)showNoContentView;
{
    _threeDot.hidden = YES;
    self.noContentView.hidden = NO;
    self.errorView.hidden = YES;
    NSLog(@"show noContent view!");
}

#pragma mark Action Methods

- (IBAction)retryRequest:(id)sender
{
    if ([self.delegate respondsToSelector:@selector(retryRequest)])
        [self.delegate retryRequest];
    [self showLoadingView];
}
@end
