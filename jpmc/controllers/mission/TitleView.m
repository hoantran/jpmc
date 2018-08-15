//
//  TitleView.m
//  jpmc
//
//  Created by Hoan Tran on 8/14/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "TitleView.h"
#import "UIColor+Hex.h"

@interface TitleView()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TitleView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupButton];
        [self setupTitleLabel];
        self.backgroundColor = [UIColor colorFromHexCode:@"B5F6FF"];
    }
    return self;
}


-(void)setupButton {
    self.button = [UIButton buttonWithType:UIButtonTypeSystem];
    self.button.translatesAutoresizingMaskIntoConstraints = false;
    self.button.titleLabel.font = [UIFont boldSystemFontOfSize:40];
    [self.button setTitle:@"X" forState:UIControlStateNormal];
    self.button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [self.button setTitleColor:[UIColor colorFromHexCode:@"FF8081"] forState:UIControlStateNormal];
    self.button.layer.borderWidth = 1.0f;
    self.button.layer.borderColor = [UIColor colorFromHexCode:@"FF7776"].CGColor;
    self.button.layer.cornerRadius = 25;
    
    [self.button addTarget:self action:@selector(handleTap) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:self.button];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.button.centerYAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.centerYAnchor],
                                              [self.button.rightAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.rightAnchor constant:-20],
                                              [self.button.widthAnchor constraintEqualToConstant:50],
                                              [self.button.heightAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.heightAnchor],
                                              nil]];
}


-(void)setupTitleLabel {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    self.titleLabel.text = @"TITLE";
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
    self.titleLabel.textColor = [UIColor blackColor];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.titleLabel];
    
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.titleLabel.centerXAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.centerXAnchor],
                                              [self.titleLabel.centerYAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.centerYAnchor],
                                              [self.titleLabel.widthAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.widthAnchor],
                                              [self.titleLabel.heightAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.heightAnchor],
                                              nil]];
}


-(void)handleTap {
    if (self.tapDelegate != nil && [self.tapDelegate respondsToSelector:@selector(handleTap)]) {
        [self.tapDelegate handleTap];
    }
}

-(void)setTitle:(NSString *)newTitle {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.titleLabel.text = newTitle;
    });
}

@end
