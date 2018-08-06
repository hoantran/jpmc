//
//  FilterController.m
//  jpmc
//
//  Created by Hoan Tran on 8/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

// ..............................................................................................
// The UI of this controller can be so much more user friendly!
// Different choice of controls for From/To fields would guide the inputs to be in the right type.
// For example a From/To can an UIPicker object that has all of the possible (2006-2018) years,
// so that the string result would be correct without a need for validation.
// The last choice for the UIPicker is a placeholder (e.g. Use mm/dd/yyyy) for signaling that the user wants to input using mm/dd/yyyy instead.
// In that case, then either a UIDatePicker or some other widget that pops up a calendar can be used to pick the date.

// All of the possible years, earliest possible date or latest possible date
// should be in injected into this controller
// for guiding the user to input the meaning choices
//
// Recalling showing the current filter when entering this controller would be a good UI practice
// ..............................................................................................



#import "FilterController.h"
#import "UpcomingView.h"
#import "DateView.h"


@interface FilterController ()
@property (nonatomic, retain) NSArray *years;
@property (nonatomic, strong) UpcomingView *upcoming;
@property (nonatomic, strong) DateView *from;
@property (nonatomic, strong) DateView *to;
@end

@implementation FilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigation];
    [self setupUpcoming];
    [self setupFrom];
    [self setupTo];
    
    self.years = [[NSArray alloc] initWithObjects:@"Anytime", @"2017", @"2018", nil];
}



-(void)setupNavigation {
    self.navigationItem.title = @"Filter";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTapped)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchTapped)];
}

-(void)setupUpcoming {
    self.upcoming = [[UpcomingView alloc]initWithFrame:CGRectZero];
    self.upcoming.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.upcoming];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.upcoming.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:0],
                                              [self.upcoming.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:10],
                                              [self.upcoming.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor constant:0],
                                              [self.upcoming.heightAnchor constraintEqualToConstant:50],
                                              nil]];
}

-(void)setupFrom {
    self.from = [[DateView alloc]initWithFrame:CGRectZero];
    [self.from setTitle:@"From"];
    self.from.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.from];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.from.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:0],
                                              [self.from.topAnchor constraintEqualToAnchor:self.upcoming.bottomAnchor constant:5],
                                              [self.from.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor constant:0],
                                              [self.from.heightAnchor constraintEqualToConstant:50],
                                              nil]];
}

-(void)setupTo {
    self.to = [[DateView alloc]initWithFrame:CGRectZero];
    [self.to setTitle:@"To"];
    self.to.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.to];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.to.leftAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.leftAnchor constant:0],
                                              [self.to.topAnchor constraintEqualToAnchor:self.from.bottomAnchor constant:5],
                                              [self.to.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor constant:0],
                                              [self.to.heightAnchor constraintEqualToConstant:50],
                                              nil]];
}

-(void)cancelTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)searchTapped {
    if (self.filterResultDelegate != nil && [self.filterResultDelegate respondsToSelector:@selector(filterDidComplete:)]) {
        FilterResult result;
        result.from = [self.from getDate];
        result.to = [self.to getDate];
        result.upcoming = [self.upcoming isOn];
        [self.filterResultDelegate filterDidComplete:&result];
    }

    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
