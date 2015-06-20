//
//  MJSimilarMoviesViewController.h
//  MJdeDouBan
//
//  Created by WangMinjun on 15/6/19.
//  Copyright (c) 2015年 WangMinjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MJSimilarMoviesViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

@property (weak, nonatomic) IBOutlet UICollectionView* collectionView;

@property (strong, nonatomic) NSArray* similarMovies;

@end
