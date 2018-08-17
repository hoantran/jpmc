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
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TitleView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupTitleLabel];
        self.backgroundColor = [UIColor colorFromHexCode:@"B5F6FF"];
    }
    return self;
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

-(void)setTitle:(NSString *)newTitle {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.titleLabel.text = newTitle;
    });
}

@end
