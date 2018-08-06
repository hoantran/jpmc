//
//  LaunchController.m
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "LaunchController.h"
#import "RestService.h"
#import "LaunchModel.h"
#import "LaunchSiteModel.h"
#import "LaunchView.h"
#import "LaunchViewDelegate.h"
#import "LaunchViewDataSource.h"
#import "FilterController.h"

@interface LaunchController ()
@property (strong, nonatomic) NSArray* launches;
@property (strong, nonatomic) LaunchView *mainView;
@property (strong, nonatomic) LaunchViewDelegate *mainViewDelegate;
@property (strong, nonatomic) LaunchViewDataSource *mainViewDatasource;
@end

@implementation LaunchController
RestService *svr;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"All Launches";
    
    [self setupFilterButton];
    [self setupMainView];
    [self pullDownAllLaunches];
}

- (void) setupFilterButton {
    UIImage *image = [UIImage imageNamed: @"filter.png"];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *_btnLeftBar = [[UIBarButtonItem alloc]initWithImage:image
                                                                   style:UIBarButtonItemStylePlain
                                                                  target:self
                                                                  action:@selector(handleFilterTapped)];
    float itemWidth = self.navigationItem.rightBarButtonItem.width;
    float leftOffset = image.size.width - itemWidth;
    _btnLeftBar.imageInsets = UIEdgeInsetsMake(0, leftOffset, 0, 0);
    
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spacer.width = 0;
    self.navigationItem.rightBarButtonItems = @[spacer,_btnLeftBar];
}

- (void) setupMainView {
    self.mainView = [[LaunchView alloc] initWithFrame:CGRectZero];
    self.mainView.translatesAutoresizingMaskIntoConstraints = false;
    self.mainViewDatasource = [[LaunchViewDataSource alloc] init];
    self.mainView.dataSource = self.mainViewDatasource;
    self.mainViewDelegate = [[LaunchViewDelegate alloc] init];
    self.mainView.delegate = self.mainViewDelegate;
    
    [self.view addSubview:self.mainView];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.mainView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
                                              [self.mainView.centerYAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerYAnchor],
                                              [self.mainView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
                                              [self.mainView.heightAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.heightAnchor],
                                              nil]];
}



-(void)pullDownAllLaunches {
    svr = [[RestService alloc] init];
    [svr get:@"https://api.spacexdata.com/v2/launches/all" success:^(NSData * _Nonnull data) {
        NSError* err = nil;
        self.launches = [LaunchModel arrayOfModelsFromData:data error:&err];
        if (self.launches != nil) {
//            [self updateMainView:[LaunchModel filter:self.launches byYear:@"2017"]];
//            [self updateMainView:[LaunchModel filter:self.launches byKind:LaunchFilterbyUpcoming]];
            [self updateMainView:[LaunchModel filter:self.launches byDateRangeFrom:1007164800 to:1483228800]];
        }
    }];
}

-(void)updateMainView:(NSArray* _Nonnull)launches {
    [self.mainViewDatasource updateLaunches:launches];
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.mainView reloadData];
    });
}

-(void)handleFilterTapped {
    FilterController *controller = [[FilterController alloc]init];
    UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:controller];
    [self presentViewController:navController animated:YES completion:^{
        NSLog(@"complted");
    }];
}

@end

