//
//  MJSettingViewController.m
//
//
//  Created by WangMinjun on 15/7/28.
//
//

#import "MJSettingViewController.h"
#import "MJAppSettings.h"
#import "CWObjectCache.h"
#import <MessageUI/MessageUI.h>
#import "MJBrowserViewController.h"

@interface MJSettingViewController () <MFMailComposeViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView* cacheIndicator;
@property (weak, nonatomic) IBOutlet UILabel* cacheSizeLabel;
@property (weak, nonatomic) IBOutlet UILabel* versionLabel;

@end

@implementation MJSettingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    //    MJAppSettings* settings = [MJAppSettings sharedSettings];
    [self.versionLabel setText:[[NSBundle mainBundle] infoDictionary][@"CFBundleShortVersionString"]];
}

/**
  *  显示缓存大小
  */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.cacheSizeLabel setText:@""];
    [self.cacheIndicator startAnimating];
    [[CWObjectCache sharedCache] calculateCacheSize:^(unsigned long long size) {
        NSString* cacheSize = [NSString stringWithFormat:@"%.2fMB", size / 1024.0 / 1024.0];
        [self.cacheSizeLabel setText:cacheSize];
        [self.cacheIndicator stopAnimating];
    }];

    //    // 显示 TabBar
    //    self.tabBarController.tabBar.hidden = NO;
    //    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - UITableView delegate

- (void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath*)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([[cell reuseIdentifier] isEqualToString:@"ClearCache"]) {
        [self clearCache];
        return;
    }

    if ([[cell reuseIdentifier] isEqualToString:@"ContactMe"]) {
        [self contactMe];
        return;
    }

    if ([[cell reuseIdentifier] isEqualToString:@"About"]) {
        [self about];
        return;
    }
}

#pragma mark - private

/**
 *  清除缓存
 */
- (void)clearCache
{
    [self.cacheSizeLabel setText:@""];
    [self.cacheIndicator startAnimating];

    [[CWObjectCache sharedCache] clearMemory];

    [[CWObjectCache sharedCache] clearDiskOnCompletion:^{
        [self.cacheSizeLabel setText:@"0.00MB"];
        [self.cacheIndicator stopAnimating];
        //        [[PRDatabase sharedDatabase] clearExpiredArticles:^{
        //            [self.cacheSizeLabel setText:@"0.00MB"];
        //            [self.cacheIndicator stopAnimating];
        //        }];
    }];
}

/**
 *  联系作者
 */
- (void)contactMe
{
    if (![MFMailComposeViewController canSendMail]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"你的手机还没有配置邮箱" message:@"请配置好邮箱后重试，你也可以通过其他渠道发送邮件到wangminjun0704@icloud.com来联系我" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    MFMailComposeViewController* vc = [[MFMailComposeViewController alloc] init];
    [vc setMailComposeDelegate:self];
    [vc setSubject:@"来自MJdeDouBan"];
    [vc setToRecipients:@[ @"wangminjun0704@icloud.com" ]];
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

/**
 *  关于
 */
- (void)about
{
    MJBrowserViewController* browserVC = [MJBrowserViewController new];
    browserVC.url = @"http://mjdedouban.sinaapp.com/static/about.html";
    [self.navigationController pushViewController:browserVC animated:YES];
}

#pragma mark - Mail callback
/**
 *  邮箱组件控制器 delegate
 */
- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    [controller dismissViewControllerAnimated:YES completion:nil];
}

@end
