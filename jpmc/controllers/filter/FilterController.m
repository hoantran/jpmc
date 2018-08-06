//
//  FilterController.m
//  jpmc
//
//  Created by Hoan Tran on 8/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "FilterController.h"

@interface FilterController ()
@property (nonatomic, retain) UIPickerView *pickerView;
@property (nonatomic, retain) NSArray *pickerSource;
@end

@implementation FilterController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    [self setupNavigation];
    
    self.pickerSource = [[NSArray alloc] initWithObjects:@"One", @"Two", nil];
    [self setupPickerView];
}

- (void) setupPickerView {
    self.pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    self.pickerView.translatesAutoresizingMaskIntoConstraints = false;
    self.pickerView.delegate = self;
    self.pickerView.dataSource = self;

    [self.view addSubview:self.pickerView];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.pickerView.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
                                              [self.pickerView.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor],
                                              [self.pickerView.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
                                              [self.pickerView.heightAnchor constraintEqualToConstant:100],
                                              nil]];
}

-(void)setupNavigation {
    self.navigationItem.title = @"Filter";
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelTapped)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(searchTapped)];
}

-(void)cancelTapped {
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)searchTapped {
    NSLog(@"Search...");
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"Did select %lu", row);
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.pickerSource.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [self.pickerSource objectAtIndex:row];
}

@end
