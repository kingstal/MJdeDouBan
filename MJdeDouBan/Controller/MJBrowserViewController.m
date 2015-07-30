//
//  MJBrowserViewController.m
//
//
//  Created by WangMinjun on 15/7/28.
//
//

#import "MJBrowserViewController.h"
//#import "MJdeDouBan-Swift.h"
#import "MJdeDouBan-Swift.h"

@interface MJBrowserViewController ()

@property (nonatomic, strong) UIWebView* webView;

@end

@implementation MJBrowserViewController

- (void)viewDidLoad
{
    // 隐藏 TabBar
    self.tabBarController.tabBar.hidden = YES;
    self.hidesBottomBarWhenPushed = YES;
}

- (UIWebView*)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:self.webView];
    }
    return _webView;
}

- (void)setUrl:(NSString*)url
{
    _url = url;
    NSURLRequest* request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [self.webView loadRequest:request];
}

@end
