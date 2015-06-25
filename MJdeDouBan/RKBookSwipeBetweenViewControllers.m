//
//  RKSwipeBetweenViewControllers.m
//  RKSwipeBetweenViewControllers
//
//  Created by Richard Kim on 7/24/14.
//  Copyright (c) 2014 Richard Kim. All rights reserved.
//
//  @cwRichardKim for regular updates

#import "RKBookSwipeBetweenViewControllers.h"
#import "MJBookNewController.h"
#import "MJBookHotController.h"
//%%% customizeable button attributes
CGFloat X_BUFFER_book = 0.0; //%%% the number of pixels on either side of the segment
CGFloat Y_BUFFER_book = 14.0; //%%% number of pixels on top of the segment
CGFloat HEIGHT_book = 30.0; //%%% height of the segment

//%%% customizeable selector bar attributes (the black bar under the buttons)
CGFloat BOUNCE_BUFFER_book = 10.0; //%%% adds bounce to the selection bar when you scroll
CGFloat ANIMATION_SPEED_book = 0.2; //%%% the number of seconds it takes to complete the animation
CGFloat SELECTOR_Y_BUFFER_book = 40.0; //%%% the y-value of the bar that shows what page you are on (0 is the top)
CGFloat SELECTOR_HEIGHT_book = 4.0; //%%% thickness of the selector bar

CGFloat X_OFFSET_book = 8.0; //%%% for some reason there's a little bit of a glitchy offset.  I'm going to look for a better workaround in the future

@interface RKBookSwipeBetweenViewControllers ()

@property (nonatomic) UIScrollView* pageScrollView;
@property (nonatomic) NSInteger currentPageIndex;
@property (nonatomic) BOOL isPageScrollingFlag; //%%% prevents scrolling / segment tap crash
@property (nonatomic) BOOL hasAppearedFlag; //%%% prevents reloading (maintains state)

@end

@implementation RKBookSwipeBetweenViewControllers
@synthesize viewControllerArray;
@synthesize selectionBar;
@synthesize pageController;
@synthesize navigationView;
@synthesize buttonText;

- (id)initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationBar.barTintColor = [UIColor colorWithWhite:0.756 alpha:1.000]; //%%% bartint
    self.navigationBar.translucent = NO;
    viewControllerArray = [[NSMutableArray alloc] init];

    // arthur add
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController* bookTop250Controller = [storyboard instantiateViewControllerWithIdentifier:@"BookTop250"];
    [viewControllerArray addObject:bookTop250Controller];

    MJBookNewController* bookNewFController = [storyboard instantiateViewControllerWithIdentifier:@"BookNew"];
    bookNewFController.flag = @"F";
    [viewControllerArray addObject:bookNewFController];

    MJBookNewController* bookNewIController = [storyboard instantiateViewControllerWithIdentifier:@"BookNew"];
    bookNewIController.flag = @"I";
    [viewControllerArray addObject:bookNewIController];

    MJBookHotController* bookHotFController = [storyboard instantiateViewControllerWithIdentifier:@"BookHot"];
    bookHotFController.flag = @"F";
    [viewControllerArray addObject:bookHotFController];

    MJBookHotController* bookHotIController = [storyboard instantiateViewControllerWithIdentifier:@"BookHot"];
    bookHotIController.flag = @"I";
    [viewControllerArray addObject:bookHotIController];

    self.currentPageIndex = 0;
    self.isPageScrollingFlag = NO;
    self.hasAppearedFlag = NO;
}

#pragma mark Customizables

//%%% color of the status bar
- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
    //    return UIStatusBarStyleDefault;
}

//%%% sets up the tabs using a loop.  You can take apart the loop to customize individual buttons, but remember to tag the buttons.  (button.tag=0 and the second button.tag=1, etc)
- (void)setupSegmentButtons
{
    navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.navigationBar.frame.size.height)];

    NSInteger numControllers = [viewControllerArray count];

    if (!buttonText) {
        buttonText = [[NSArray alloc] initWithObjects:@"豆瓣250", @"新书(虚构)", @"新书(非虚构)", @"热门(虚构)", @"热门(非虚构)", @"etc", @"etc", @"etc", nil]; //%%%buttontitle
    }

    for (int i = 0; i < numControllers; i++) {
        UIButton* button = [[UIButton alloc] initWithFrame:CGRectMake(X_BUFFER_book + i * (self.view.frame.size.width - 2 * X_BUFFER_book) / numControllers - X_OFFSET_book, Y_BUFFER_book, (self.view.frame.size.width - 2 * X_BUFFER_book) / numControllers, HEIGHT_book)];
        [navigationView addSubview:button];
        
        button.tag = i; //%%% IMPORTANT: if you make your own custom buttons, you have to tag them appropriately
        button.backgroundColor = [UIColor colorWithWhite:0.756 alpha:1.000]; //%%% buttoncolors

        [button addTarget:self action:@selector(tapSegmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];

        [button setTitle:[buttonText objectAtIndex:i] forState:UIControlStateNormal]; //%%%buttontitle
        // add by Arthur
        button.titleLabel.font = [UIFont systemFontOfSize:12];
        button.titleLabel.minimumScaleFactor = 0.5;
    }

    pageController.navigationController.navigationBar.topItem.titleView = navigationView;

    //%%% example custom buttons example:
    /*
    NSInteger width = (self.view.frame.size.width-(2*X_BUFFER))/3;
    UIButton *leftButton = [[UIButton alloc]initWithFrame:CGRectMake(X_BUFFER, Y_BUFFER, width, HEIGHT)];
    UIButton *middleButton = [[UIButton alloc]initWithFrame:CGRectMake(X_BUFFER+width, Y_BUFFER, width, HEIGHT)];
    UIButton *rightButton = [[UIButton alloc]initWithFrame:CGRectMake(X_BUFFER+2*width, Y_BUFFER, width, HEIGHT)];

    [self.navigationBar addSubview:leftButton];
    [self.navigationBar addSubview:middleButton];
    [self.navigationBar addSubview:rightButton];

    leftButton.tag = 0;
    middleButton.tag = 1;
    rightButton.tag = 2;

    leftButton.backgroundColor = [UIColor colorWithRed:0.03 green:0.07 blue:0.08 alpha:1];
    middleButton.backgroundColor = [UIColor colorWithRed:0.03 green:0.07 blue:0.08 alpha:1];
    rightButton.backgroundColor = [UIColor colorWithRed:0.03 green:0.07 blue:0.08 alpha:1];

    [leftButton addTarget:self action:@selector(tapSegmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [middleButton addTarget:self action:@selector(tapSegmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton addTarget:self action:@selector(tapSegmentButtonAction:) forControlEvents:UIControlEventTouchUpInside];

    [leftButton setTitle:@"left" forState:UIControlStateNormal];
    [middleButton setTitle:@"middle" forState:UIControlStateNormal];
    [rightButton setTitle:@"right" forState:UIControlStateNormal];
     */

    [self setupSelector];
}

//%%% sets up the selection bar under the buttons on the navigation bar
- (void)setupSelector
{
    selectionBar = [[UIView alloc] initWithFrame:CGRectMake(X_BUFFER_book - X_OFFSET_book, SELECTOR_Y_BUFFER_book, (self.view.frame.size.width - 2 * X_BUFFER_book) / [viewControllerArray count], SELECTOR_HEIGHT_book)];
    selectionBar.backgroundColor = [UIColor colorWithWhite:0.6 alpha:1.000]; //%%% sbcolor
    selectionBar.alpha = 0.8; //%%% sbalpha
    [navigationView addSubview:selectionBar];
}

//generally, this shouldn't be changed unless you know what you're changing
#pragma mark Setup

- (void)viewWillAppear:(BOOL)animated
{
    if (!self.hasAppearedFlag) {
        [self setupPageViewController];
        [self setupSegmentButtons];
        self.hasAppearedFlag = YES;
    }
}

//%%% generic setup stuff for a pageview controller.  Sets up the scrolling style and delegate for the controller
- (void)setupPageViewController
{
    pageController = (UIPageViewController*)self.topViewController;
    pageController.delegate = self;
    pageController.dataSource = self;
    [pageController setViewControllers:@[ [viewControllerArray objectAtIndex:0] ] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    [self syncScrollView];
}

//%%% this allows us to get information back from the scrollview, namely the coordinate information that we can link to the selection bar.
- (void)syncScrollView
{
    for (UIView* view in pageController.view.subviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            self.pageScrollView = (UIScrollView*)view;
            self.pageScrollView.delegate = self;
        }
    }
}

//%%% methods called when you tap a button or scroll through the pages
// generally shouldn't touch this unless you know what you're doing or
// have a particular performance thing in mind

#pragma mark Movement

//%%% when you tap one of the buttons, it shows that page,
//but it also has to animate the other pages to make it feel like you're crossing a 2d expansion,
//so there's a loop that shows every view controller in the array up to the one you selected
//eg: if you're on page 1 and you click tab 3, then it shows you page 2 and then page 3
- (void)tapSegmentButtonAction:(UIButton*)button
{

    if (!self.isPageScrollingFlag) {

        NSInteger tempIndex = self.currentPageIndex;

        __weak typeof(self) weakSelf = self;

        //%%% check to see if you're going left -> right or right -> left
        if (button.tag > tempIndex) {

            //%%% scroll through all the objects between the two points
            for (int i = (int)tempIndex + 1; i <= button.tag; i++) {
                [pageController setViewControllers:@[ [viewControllerArray objectAtIndex:i] ]
                                         direction:UIPageViewControllerNavigationDirectionForward
                                          animated:YES
                                        completion:^(BOOL complete) {

                                            //%%% if the action finishes scrolling (i.e. the user doesn't stop it in the middle),
                                            //then it updates the page that it's currently on
                                            if (complete) {
                                                [weakSelf updateCurrentPageIndex:i];
                                            }
                                        }];
            }
        }

        //%%% this is the same thing but for going right -> left
        else if (button.tag < tempIndex) {
            for (int i = (int)tempIndex - 1; i >= button.tag; i--) {
                [pageController setViewControllers:@[ [viewControllerArray objectAtIndex:i] ]
                                         direction:UIPageViewControllerNavigationDirectionReverse
                                          animated:YES
                                        completion:^(BOOL complete) {
                                            if (complete) {
                                                [weakSelf updateCurrentPageIndex:i];
                                            }
                                        }];
            }
        }
    }
}

//%%% makes sure the nav bar is always aware of what page you're on
//in reference to the array of view controllers you gave
- (void)updateCurrentPageIndex:(int)newIndex
{
    self.currentPageIndex = newIndex;
}

//%%% method is called when any of the pages moves.
//It extracts the xcoordinate from the center point and instructs the selection bar to move accordingly
- (void)scrollViewDidScroll:(UIScrollView*)scrollView
{
    CGFloat xFromCenter = self.view.frame.size.width - scrollView.contentOffset.x; //%%% positive for right swipe, negative for left

    //%%% checks to see what page you are on and adjusts the xCoor accordingly.
    //i.e. if you're on the second page, it makes sure that the bar starts from the frame.origin.x of the
    //second tab instead of the beginning
    NSInteger xCoor = X_BUFFER_book + selectionBar.frame.size.width * self.currentPageIndex - X_OFFSET_book;

    selectionBar.frame = CGRectMake(xCoor - xFromCenter / [viewControllerArray count], selectionBar.frame.origin.y, selectionBar.frame.size.width, selectionBar.frame.size.height);
}

//%%% the delegate functions for UIPageViewController.
//Pretty standard, but generally, don't touch this.
#pragma mark UIPageViewController Delegate Functions

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Page View Controller Data Source

- (UIViewController*)pageViewController:(UIPageViewController*)pageViewController viewControllerBeforeViewController:(UIViewController*)viewController
{
    NSInteger index = [viewControllerArray indexOfObject:viewController];

    if ((index == NSNotFound) || (index == 0)) {
        return nil;
    }

    index--;
    return [viewControllerArray objectAtIndex:index];
}

- (UIViewController*)pageViewController:(UIPageViewController*)pageViewController viewControllerAfterViewController:(UIViewController*)viewController
{
    NSInteger index = [viewControllerArray indexOfObject:viewController];

    if (index == NSNotFound) {
        return nil;
    }
    index++;

    if (index == [viewControllerArray count]) {
        return nil;
    }
    return [viewControllerArray objectAtIndex:index];
}

- (void)pageViewController:(UIPageViewController*)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray*)previousViewControllers transitionCompleted:(BOOL)completed
{
    if (completed) {
        self.currentPageIndex = [viewControllerArray indexOfObject:[pageViewController.viewControllers lastObject]];
    }
}

#pragma mark - Scroll View Delegate

- (void)scrollViewWillBeginDragging:(UIScrollView*)scrollView
{
    self.isPageScrollingFlag = YES;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView*)scrollView
{
    self.isPageScrollingFlag = NO;
}

@end
