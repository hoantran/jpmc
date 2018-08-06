//
//  ViewController.m
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "ViewController.h"
#import "RestService.h"
#import "LaunchModel.h"
#import "LaunchSiteModel.h"
#import "LaunchView.h"

#import "LaunchViewDelegate.h"
#import "LaunchViewDataSource.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray* launches;
@property (strong, nonatomic) LaunchView *mainView;
@property (strong, nonatomic) LaunchViewDelegate *mainViewDelegate;
@property (strong, nonatomic) LaunchViewDataSource *mainViewDatasource;

//@property (strong, nonatomic) NSArray* next;
@end

@implementation ViewController
RestService *svr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    UINavigationBar* navbar = [[UINavigationBar alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 50)];
//
//    UINavigationItem* navItem = [[UINavigationItem alloc] initWithTitle:@"karthik"];
//    // [navbar setBarTintColor:[UIColor lightGrayColor]];
//    UIBarButtonItem* cancelBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(onTapCancel:)];
//    navItem.leftBarButtonItem = cancelBtn;
//
//    UIBarButtonItem* doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(onTapDone:)];
//    navItem.rightBarButtonItem = doneBtn;
//
//    [navbar setItems:@[navItem]];
//    [self.view addSubview:navbar];
    
    
    self.navigationItem.title = @"All Launches";
    
//    UIButton *imageButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 35, 35)];
//    [imageButton setBackgroundImage:[UIImage imageNamed:@"filter.png"] forState:UIControlStateNormal];
//    [imageButton addTarget:self action:@selector(messageButtonTapped) forControlEvents:UIControlEventAllEvents];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:imageButton];
//    self.navigationItem.rightBarButtonItem = item;
    
//    var imageLogo = UIImage(named: "LogoWithTextSmaller.png")
//    imageLogo = imageLogo?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
//    btnLogo.setImage(imageLogo, for: .normal)
    
    
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
//    v.backgroundColor = UIColor.black
//    v.isHidden = true
    
    // Main view
    self.mainView = [[LaunchView alloc] initWithFrame:CGRectZero];
    self.mainView.translatesAutoresizingMaskIntoConstraints = false;
//    [self.mainView registerClass:[UITableViewCell class]  forCellReuseIdentifier:kCellIdentifier];
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
    NSLog(@"Filter tapped");
}

@end

