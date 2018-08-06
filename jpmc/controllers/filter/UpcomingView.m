//
//  UpcomingView.m
//  jpmc
//
//  Created by Hoan Tran on 8/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "UpcomingView.h"
#import "UIColor+Hex.h"

@interface UpcomingView ()
@property (nonatomic, retain) UILabel *title;
@property (nonatomic, retain) UISwitch *upcoming;
@end

@implementation UpcomingView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    self.backgroundColor = [UIColor colorFromHexCode:@"EBEBEB"];
    [self setupTitle];
    [self setupUpcomingSwitch];
}

-(void)setupTitle{
    self.title = [[UILabel alloc]init];
    self.title.text = @"Upcoming launches";
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.font = [UIFont systemFontOfSize:16];
    self.title.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.title];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.title.leftAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leftAnchor constant:5],
                                              [self.title.centerYAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.centerYAnchor],
                                              [self.title.widthAnchor constraintEqualToConstant:200],
                                              [self.title.heightAnchor constraintEqualToConstant:40],
                                              nil]];
}

-(void)setupUpcomingSwitch{
    self.upcoming = [[UISwitch alloc]initWithFrame:CGRectZero];
    self.upcoming.translatesAutoresizingMaskIntoConstraints = NO;
    self.upcoming.onTintColor = [UIColor greenColor];
    [self.upcoming setOn:NO];
    self.upcoming.onTintColor = [UIColor greenColor];
    
    [self addSubview:self.upcoming];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.upcoming.rightAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.rightAnchor constant:40],
                                              [self.upcoming.centerYAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.centerYAnchor],
                                              [self.upcoming.widthAnchor constraintEqualToConstant:100],
                                              [self.upcoming.heightAnchor constraintEqualToConstant:40],
                                              nil]];
}

-(BOOL)isOn {
    return self.upcoming.isOn;
}
@end
