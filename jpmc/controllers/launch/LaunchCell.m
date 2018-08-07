//
//  LaunchCell.m
//  jpmc
//
//  Created by Hoan Tran on 8/7/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "LaunchCell.h"
#import "UIColor+Hex.h"

CGFloat const LAUNCH_CELL_HEIGHT            = 60;
CGFloat const LAUNCH_CELL_SIDE_OFFSET       = 15;
CGFloat const LAUNCH_CELL_TOP_OFFSET        = 2;
CGFloat const LAUNCH_CELL_COL_1_WIDTH       = 50;
CGFloat const LAUNCH_CELL_COL_3_WIDTH       = 50;
CGFloat const LAUNCH_CELL_YEAR_HEIGHT       = 15;
CGFloat const LAUNCH_CELL_HORZ_GAP          = 5;
CGFloat const LAUNCH_CELL_VERT_GAP          = 1;
CGFloat const LAUNCH_CELL_MISSION_HEIGHT    = 20;
CGFloat const LAUNCH_CELL_SEPARATOR_HEIGHT  = 1;

@interface LaunchCell ()
@property (strong, nonatomic) UILabel *year;
@property (strong, nonatomic) UILabel *month;
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *mission;
@property (strong, nonatomic) UIView *separator;
@property (strong, nonatomic) UILabel *landing;
@end

@implementation LaunchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        UIView *bkgView = [[UIView alloc]init];
        bkgView.backgroundColor = [UIColor colorFromHexCode:@"FFFFE2"];
        self.selectedBackgroundView = bkgView;
        self.backgroundColor = [UIColor colorFromHexCode:@"F5F5F5"];
        [self setupDate];
        [self setupMonth];
        [self setupIcon];
        [self setupMissionColumn];
    }
    return self;
}

- (void)prepareForReuse {
    [super prepareForReuse];
    self.year.text = @"";
    self.month.text = @"";
    self.mission.text = @"";
    self.landing.text = @"";
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setupDate {
    self.year = [[UILabel alloc] initWithFrame:CGRectZero];
    self.year.text = @"2018";
    self.year.textAlignment = NSTextAlignmentCenter;
    self.year.font = [UIFont boldSystemFontOfSize:14];
    self.year.backgroundColor = [UIColor colorFromHexCode:@"DD2626"];
    self.year.textColor = [UIColor whiteColor];
    self.year.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.year];
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.year.leftAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.leftAnchor constant:LAUNCH_CELL_SIDE_OFFSET],
                                              [self.year.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:LAUNCH_CELL_TOP_OFFSET],
                                              [self.year.widthAnchor constraintEqualToConstant:LAUNCH_CELL_COL_1_WIDTH],
                                              [self.year.heightAnchor constraintEqualToConstant:LAUNCH_CELL_YEAR_HEIGHT],
                                              nil]];
}



-(void)setupMonth {
    self.month = [[UILabel alloc] initWithFrame:CGRectZero];
    self.month.text = @"NOV";
    self.month.textAlignment = NSTextAlignmentCenter;
    self.month.font = [UIFont boldSystemFontOfSize:16];
    self.month.textColor = [UIColor grayColor];
    self.month.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.month];
    
    CGFloat height = LAUNCH_CELL_HEIGHT - LAUNCH_CELL_TOP_OFFSET - LAUNCH_CELL_YEAR_HEIGHT;
    
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.month.centerXAnchor constraintEqualToAnchor:self.year.centerXAnchor],
                                              [self.month.topAnchor constraintEqualToAnchor:self.year.bottomAnchor constant:-2],
                                              [self.month.widthAnchor constraintEqualToAnchor:self.year.widthAnchor],
                                              [self.month.heightAnchor constraintEqualToConstant:height],
                                              nil]];
}

-(void)setupIcon {
    CGFloat height = LAUNCH_CELL_COL_3_WIDTH - (2*LAUNCH_CELL_TOP_OFFSET);
    self.icon = [[UIImageView alloc]initWithImage:NULL highlightedImage:NULL];
    [self.icon setImage: [UIImage imageNamed: @"spacex.3.jpg"]];
    self.icon.contentMode = UIViewContentModeScaleAspectFill;
    self.icon.layer.cornerRadius = height / 2;
    self.icon.layer.masksToBounds = YES;
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.icon];
    
    
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.icon.rightAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.rightAnchor constant:-LAUNCH_CELL_SIDE_OFFSET],
                                              [self.icon.centerYAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.centerYAnchor constant:0],
                                              [self.icon.widthAnchor constraintEqualToConstant:height],
                                              [self.icon.heightAnchor constraintEqualToConstant:height],
                                              nil]];
    
}

-(void)setupMissionColumn {
    // mission
    CGFloat width = self.frame.size.width - (2*LAUNCH_CELL_SIDE_OFFSET) - (2*LAUNCH_CELL_HORZ_GAP);
    CGFloat missionTopOffset = LAUNCH_CELL_TOP_OFFSET + 10;
    self.mission = [[UILabel alloc] initWithFrame:CGRectZero];
    NSString *missionName = @"MISSION";
    missionName = [missionName uppercaseString];
    int newLength = 20;
    if (missionName.length > newLength)
        missionName = [missionName substringToIndex:newLength];
    self.mission.text = missionName;
    self.mission.textAlignment = NSTextAlignmentCenter;
    self.mission.font = [UIFont boldSystemFontOfSize:20];
    self.mission.textColor = [UIColor blackColor];
    self.mission.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.mission];
    
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.mission.centerXAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.centerXAnchor],
                                              [self.mission.topAnchor constraintEqualToAnchor:self.safeAreaLayoutGuide.topAnchor constant:missionTopOffset],
                                              [self.mission.widthAnchor constraintEqualToConstant:width],
                                              [self.mission.heightAnchor constraintEqualToConstant:LAUNCH_CELL_MISSION_HEIGHT],
                                              nil]];
    
    // separator
//    let separatorLineView = UIView()
//    separatorLineView.backgroundColor = UIColor(r: 220, g: 220, b: 220)
//    separatorLineView.translatesAutoresizingMaskIntoConstraints = false
//    addSubview(separatorLineView)
//    //x,y,w,h
//    separatorLineView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
//    separatorLineView.topAnchor.constraint(equalTo: topAnchor).isActive = true
//    separatorLineView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
//    separatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    CGFloat separatorHeight = 1;
    self.separator = [[UIView alloc]init];
    self.separator.backgroundColor = [UIColor colorFromHexCode:@"D8D8D8"];
    self.separator.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.separator];

    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.separator.centerXAnchor constraintEqualToAnchor:self.mission.centerXAnchor],
                                              [self.separator.topAnchor constraintEqualToAnchor:self.mission.bottomAnchor constant:LAUNCH_CELL_VERT_GAP],
                                              [self.separator.widthAnchor constraintEqualToConstant:width - 50],
                                              [self.separator.heightAnchor constraintEqualToConstant:separatorHeight],
                                              nil]];
    
    
    // landing
    self.landing = [[UILabel alloc] initWithFrame:CGRectZero];
    self.landing.text = @"landing";
    self.landing.textAlignment = NSTextAlignmentCenter;
    self.landing.font = [UIFont systemFontOfSize:14];
    self.landing.textColor = [UIColor colorFromHexCode:@"676767"];
    self.landing.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.landing];

    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.landing.centerXAnchor constraintEqualToAnchor:self.mission.centerXAnchor],
                                              [self.landing.topAnchor constraintEqualToAnchor:self.separator.bottomAnchor constant:LAUNCH_CELL_VERT_GAP],
                                              [self.landing.widthAnchor constraintEqualToConstant:width],
                                              [self.landing.heightAnchor constraintEqualToConstant:LAUNCH_CELL_HEIGHT-(2*LAUNCH_CELL_VERT_GAP)-missionTopOffset-LAUNCH_CELL_MISSION_HEIGHT-10],
                                              nil]];
    
    
    
}


@end
