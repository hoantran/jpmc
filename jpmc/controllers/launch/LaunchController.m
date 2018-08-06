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
//            [self updateMainView:[LaunchModel filter:self.launches byDateRangeFrom:1007164800 to:1483228800]];
            [self updateMainView:self.launches];
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
    controller.filterResultDelegate = self;
    [self presentViewController:navController animated:YES completion:^{
        NSLog(@"complted");
    }];
}

-(NSDate *)getYear:(NSString *)year {
    return [self getFormattedDate:year format:@"yyyy"];
}

-(NSDate *)getDate:(NSString *)year {
    return [self getFormattedDate:year format:@"MM/dd/yyyy"];
}


-(NSDate *)getFormattedDate:(NSString *)date format:(NSString *)format {
    NSDateFormatter * formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    return [formatter dateFromString: date];
}

-(NSArray *)filteredByYear:(NSArray *)src from:(NSString *)reqFrom to:(NSString *)reqTo {
    NSDate *from, *to;
    double fromUnix, toUnix;
    from = [self getYear:reqFrom];
    to = [self getYear:reqTo];
    NSArray *filteredLaunches = nil;
    
    if (from == nil) {
        if (to != nil) {
            filteredLaunches = [LaunchModel filter:src byYear:reqTo];
        }
    } else {
        if (to == nil) {
            filteredLaunches = [LaunchModel filter:src byYear:reqFrom];
        } else {
            NSString *lastDayOfToYear = [NSString stringWithFormat:@"12/31/%@",reqTo];
            to = [self getDate:lastDayOfToYear];
            fromUnix = [from timeIntervalSince1970];
            toUnix = [to timeIntervalSince1970];
            if (fromUnix <= toUnix) {
                filteredLaunches = [LaunchModel filter:src byDateRangeFrom:fromUnix to:toUnix];
            }
        }
    }
    
    return filteredLaunches;
}

-(void)filterDidComplete:(FilterResult*)result {
    NSLog(@"from:%@", result->from);
    NSArray *filteredLaunches = self.launches;
    
    if( result->upcoming ){
        filteredLaunches = [LaunchModel filter:filteredLaunches byKind:LaunchFilterbyUpcoming];
    }
    
    NSArray *filtered = [self filteredByYear:filteredLaunches from:result->from to:result->to];
    
    if (filtered == nil) {
        // do something
    } else {
        filteredLaunches = filtered;
    }
    
    [self updateMainView:filteredLaunches];
}

@end

