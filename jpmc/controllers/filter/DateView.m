//
//  DateView.m
//  jpmc
//
//  Created by Hoan Tran on 8/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "DateView.h"
#import "UIColor+Hex.h"

@interface DateView ()
@property (nonatomic, retain) UILabel *titleField;
@property (nonatomic, retain) UITextField *input;
@end

@implementation DateView

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupView];
    }
    return self;
}

-(void)setupView{
    self.backgroundColor = [UIColor colorFromHexCode:@"EBEBEB"];
    [self setupTitleField];
    [self setupInput];
}


-(void)setupTitleField{
    self.titleField = [[UILabel alloc]init];
    self.titleField.text = @"";
    self.titleField.textAlignment = NSTextAlignmentLeft;
    self.titleField.font = [UIFont systemFontOfSize:16];
    self.titleField.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addSubview:self.titleField];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.titleField.leftAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leftAnchor constant:5],
                                              [self.titleField.centerYAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.centerYAnchor],
                                              [self.titleField.widthAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.widthAnchor constant:-100],
                                              [self.titleField.heightAnchor constraintEqualToConstant:40],
                                              nil]];
}
-(void)setupInput{
    self.input = [[UITextField alloc]init];
    self.input.placeholder = @"year, or MM/DD/YYYY";
    self.input.textAlignment = NSTextAlignmentRight;
    self.input.autocorrectionType = UITextAutocorrectionTypeNo;
    self.input.delegate = self;
    self.input.font = [UIFont systemFontOfSize:16];
    self.input.translatesAutoresizingMaskIntoConstraints = NO;
    [self.input addTarget:self action:@selector(dateChanged) forControlEvents:UIControlEventEditingChanged];
    
    [self addSubview:self.input];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.input.rightAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.rightAnchor constant:-5],
                                              [self.input.centerYAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.centerYAnchor],
                                              [self.input.widthAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.widthAnchor constant:-100],
                                              [self.input.heightAnchor constraintEqualToConstant:40],
                                              nil]];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"Return");
    return YES;
}

-(void)dateChanged {
    NSLog(@"date changed");
}

-(void)setTitle:(NSString *)title{
    self.titleField.text = title;
}

-(NSString*)getDate {
    return self.input.text;
}


@end


