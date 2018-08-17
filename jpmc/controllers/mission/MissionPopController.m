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
#import "MissionCell.h"

CGFloat const TITLE_VIEW_HEIGHT = 46;


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
    [self item:(int)self.row];
}

-(void)handleTap {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
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
                                              [self.titleView.heightAnchor constraintEqualToConstant:TITLE_VIEW_HEIGHT],
                                              nil]];
}

-(void)setupCollectionView {
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    [self.collectionView setPagingEnabled:YES];
    
    self.collectionViewDelegate = [[MissionCollectionViewDelegate alloc]init];
    self.collectionViewDelegate.itemChangeListener = self;
    [self.collectionView setDelegate:self.collectionViewDelegate];
    
    self.collectionViewDataSource = [[MissionCollectionViewDataSource alloc]init];
    self.collectionViewDataSource.missionInfoProvider = self.missionInfoProvider;
    [self.collectionView setDataSource:self.collectionViewDataSource];
    
    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    self.collectionView.backgroundColor = [UIColor colorFromHexCode:@"D8FAFF"];
    
    [self.collectionView registerClass:MissionCell.self forCellWithReuseIdentifier:MISSION_CELL_ID];
    [self.collectionView setShowsHorizontalScrollIndicator:NO];
    
    [self.view addSubview:self.collectionView];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.collectionView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
                                              [self.collectionView.topAnchor constraintEqualToAnchor:self.titleView.bottomAnchor],
                                              [self.collectionView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
                                              [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              nil]];
}

-(void)item:(int)item {
    if (self.missionInfoProvider != nil && [self.missionInfoProvider respondsToSelector:@selector(launchInfoFor:)]) {
        LaunchModel *launch = [self.missionInfoProvider launchInfoFor:item];
        if (launch != nil && launch.mission_name != nil) {
            NSString *missionName = [launch.mission_name uppercaseString];
            int lengthLimit = 15;
            if (missionName.length > lengthLimit)
                missionName = [missionName substringToIndex:lengthLimit];
            [self.titleView setTitle:missionName];
        }
    }
}

-(void)dealloc {
    NSLog(@"Pop DEALLOC");
}

@end
