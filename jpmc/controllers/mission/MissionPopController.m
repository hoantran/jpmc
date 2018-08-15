//
//  MissionPopController.m
//  jpmc
//
//  Created by Hoan Tran on 8/13/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "MissionPopController.h"
#import "TitleView.h"
#import "UIColor+Hex.h"
#import "MissionCollectionViewDelegate.h"
#import "MissionCollectionViewDataSource.h"


@interface MissionPopController ()
@property (nonatomic, strong) TitleView *titleView;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MissionCollectionViewDelegate *collectionViewDelegate;
@property (nonatomic, strong) MissionCollectionViewDataSource *collectionViewDataSource;
@end

@implementation MissionPopController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorFromHexCode:@"D8FAFF"];
    [self setupTitleView];
    [self setupCollectionView];
    NSLog(@"viewDidLoad size:%@", NSStringFromCGRect(self.view.frame));
}

-(void)handleTap {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
//    dispatch_async(dispatch_get_main_queue(), ^{
//        CGRect rect = self.collectionView.frame;
//        self.collectionView.frame = CGRectMake(rect.origin.x - 100, rect.origin.y, rect.size.width, rect.size.height);
//    });
}

-(void)setupTitleView {
    self.titleView = [[TitleView alloc]initWithFrame:CGRectZero];
    self.titleView.translatesAutoresizingMaskIntoConstraints = false;
    self.titleView.tapDelegate = self;
    
    [self.view addSubview:self.titleView];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.titleView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
                                              [self.titleView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                              [self.titleView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
                                              [self.titleView.heightAnchor constraintEqualToConstant:50],
                                              nil]];
}

-(void)setupCollectionView {
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    
    self.collectionViewDelegate = [[MissionCollectionViewDelegate alloc]init];
    self.collectionViewDataSource = [[MissionCollectionViewDataSource alloc]init];
    [self.collectionView setDelegate:self.collectionViewDelegate];
    [self.collectionView setDataSource:self.collectionViewDataSource];
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    self.collectionView.backgroundColor = [UIColor colorFromHexCode:@"D8FAFF"];
    
    [self.view addSubview:self.collectionView];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.collectionView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
                                              [self.collectionView.topAnchor constraintEqualToAnchor:self.titleView.bottomAnchor],
                                              [self.collectionView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
                                              [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              nil]];
}

@end
