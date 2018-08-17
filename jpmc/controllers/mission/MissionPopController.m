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

CGFloat const BUTTON_HEIGHT = 40;
CGFloat const X_FONT_SIZE   = 34;

@interface MissionPopController ()
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) MissionCollectionViewDelegate *collectionViewDelegate;
@property (nonatomic, strong) MissionCollectionViewDataSource *collectionViewDataSource;
@end

@implementation MissionPopController

-(void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorFromHexCode:@"D8FAFF"];
    [self setupCollectionView];
    [self setupCloseButton];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:self.row inSection:0];
    [self.collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}

-(void)handleTap {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

-(void)setupCloseButton {
    self.closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.closeButton.translatesAutoresizingMaskIntoConstraints = false;
    self.closeButton.titleLabel.font = [UIFont boldSystemFontOfSize:X_FONT_SIZE];
    [self.closeButton setTitle:@"X" forState:UIControlStateNormal];
    self.closeButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.closeButton setTitleColor:[UIColor colorFromHexCode:@"FF8081"] forState:UIControlStateNormal];
    self.closeButton.layer.borderWidth = 1.0f;
    self.closeButton.layer.borderColor = [UIColor colorFromHexCode:@"FF7776"].CGColor;
    self.closeButton.layer.cornerRadius = BUTTON_HEIGHT/2;
    
    [self.closeButton addTarget:self action:@selector(handleTap) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.closeButton];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.closeButton.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:3],
                                              [self.closeButton.rightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.rightAnchor constant:-20],
                                              [self.closeButton.widthAnchor constraintEqualToConstant:BUTTON_HEIGHT],
                                              [self.closeButton.heightAnchor constraintEqualToConstant:BUTTON_HEIGHT],
                                              nil]];
}

-(void)setupCollectionView {
    UICollectionViewFlowLayout *layout=[[UICollectionViewFlowLayout alloc] init];
    [layout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
    self.collectionView.translatesAutoresizingMaskIntoConstraints = false;
    [self.collectionView setPagingEnabled:YES];
    
    self.collectionViewDelegate = [[MissionCollectionViewDelegate alloc]init];
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
                                              [self.collectionView.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor],
                                              [self.collectionView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
                                              [self.collectionView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              nil]];
}

@end
