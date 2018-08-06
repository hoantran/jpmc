//
//  LaunchController.m
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

// ..............................................................................................
// A few more features would enhance the user experience greatly:
// * Pull-to-refresh would pull down the latest data
// * An activity indcator tells user that it's busy
// * A detail view of a lanch window when user taps on a mission row is mostly probably expected
// * Pictures of a mission (even canned one flickr ) would be much more visually appealing.
// * Custom cells for each mission row would be a must to emphasize important info and UI enhancements
// * When a filter is applied, the title should reflect that. e.g. "All Launches", "2012 Launches", "03/05/2014 - 09/06/2017" etc.
// *
// * A "No Launches available" would be useful when none is in the table.
// ..............................................................................................



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
    self.navigationItem.title = @"Launches";
    
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
            } else {
                filteredLaunches = [[NSArray alloc]init];
            }
        }
    }
    
    return filteredLaunches;
}

-(NSArray *)filteredByDate:(NSArray *)src from:(NSString *)reqFrom to:(NSString *)reqTo {
    NSDate *from, *to;
    double fromUnix, toUnix;
    from = [self getDate:reqFrom];
    to = [self getDate:reqTo];
    NSArray *filteredLaunches = nil;
    
    if (from != nil && to != nil) {
        fromUnix = [from timeIntervalSince1970];
        toUnix = [to timeIntervalSince1970];
        if (fromUnix <= toUnix) {
            filteredLaunches = [LaunchModel filter:src byDateRangeFrom:fromUnix to:toUnix];
        }
    }
    
    return filteredLaunches;
}

-(void)filterDidComplete:(FilterResult*)result {
    NSArray *filteredLaunches = self.launches;
    
    if( result->upcoming ){
        filteredLaunches = [LaunchModel filter:filteredLaunches byKind:LaunchFilterbyUpcoming];
    }
    
    NSArray *filtered = [self filteredByYear:filteredLaunches from:result->from to:result->to];
    
    if (filtered == nil) {
        filtered = [self filteredByDate:filteredLaunches from:result->from to:result->to];
        if (filtered != nil) {
            filteredLaunches = filtered;
        }
    } else {
        filteredLaunches = filtered;
    }
    
    [self updateMainView:filteredLaunches];
}

@end

