//
//  MJNetworkLoadingViewController.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/10.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FeThreeDotGlow.h"

@protocol MJNetworkLoadingViewDelegate <NSObject>

- (void)retryRequest;

@end

@interface MJNetworkLoadingViewController : UIViewController

//@property (weak, nonatomic) IBOutlet UIView* loadingView;
@property (weak, nonatomic) IBOutlet UIView* errorView;
@property (weak, nonatomic) IBOutlet UIButton* refreshButton;
@property (weak, nonatomic) IBOutlet UIView* noContentView;


@property (weak, nonatomic) id<MJNetworkLoadingViewDelegate> delegate;

- (IBAction)retryRequest:(id)sender;

- (void)showLoadingView;
- (void)showNoContentView;
- (void)showErrorView;

@end
