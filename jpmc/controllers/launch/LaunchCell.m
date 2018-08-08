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
CGFloat const LAUNCH_CELL_COL_3_HEIGHT      = LAUNCH_CELL_COL_3_WIDTH - (2*LAUNCH_CELL_TOP_OFFSET);
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
@property (strong, nonatomic) UILabel *launchSite;
@property (strong, nonatomic) NSArray *cellBkgs;
@property (strong, nonatomic) NSArray *yearBkgs;
@end

@implementation LaunchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self){
        self.cellBkgs = [[NSArray alloc] initWithObjects:[UIColor whiteColor],[UIColor colorFromHexCode:@"F5F5F5"], nil];
        self.yearBkgs = [[NSArray alloc] initWithObjects:[UIColor colorFromHexCode:@"DD2626"],[UIColor colorFromHexCode:@"A000A2"], nil];
        
        UIView *bkgView = [[UIView alloc]init];
        bkgView.backgroundColor = [UIColor colorFromHexCode:@"FFFFE2"];
        self.selectedBackgroundView = bkgView;
        [self setupYear];
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
    self.launchSite.text = @"";
    self.icon.image = nil;
}

-(void)updateBackgroundColor:(NSInteger)row {
    NSInteger bkgIndex = row % self.cellBkgs.count;
    self.backgroundColor = [self.cellBkgs objectAtIndex:bkgIndex];
}

-(void)updateYear:(NSString *)launchYear {
    int year = [launchYear intValue];
    NSInteger bkgIndex = year % self.yearBkgs.count;
    self.year.backgroundColor = [self.yearBkgs objectAtIndex:bkgIndex];
    self.year.text = launchYear;
}

-(void)updateMonth:(double)unixLaunchDate {
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:unixLaunchDate];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM"];
    self.month.text = [[formatter stringFromDate:date] uppercaseString];
}

-(void)updateMission:(NSString*)mission {
    NSString *missionName = [mission uppercaseString];
    int lengthLimit = 20;
    if (missionName.length > lengthLimit)
        missionName = [missionName substringToIndex:lengthLimit];
    self.mission.text = missionName;
}

-(void)updateLaunchSite:(NSString*)siteName {
    NSString *launchSite = [siteName lowercaseString];
    int lengthLimit = 35;
    if (launchSite.length > lengthLimit)
        launchSite = [launchSite substringToIndex:lengthLimit];
    self.launchSite.text = launchSite;
}

-(void)updateIcon:(NSString *)iconFileName {
    // ..............................................................................................
    // These are 3 stock images. Yet, correct images should be either preloaded or downloaded on the fly
    // ..............................................................................................
    [self.icon setImage: [UIImage imageNamed: iconFileName]];
    self.icon.contentMode = UIViewContentModeScaleAspectFill;
    self.icon.layer.cornerRadius = LAUNCH_CELL_COL_3_HEIGHT / 2;

}

-(void)setLaunchInfo:(LaunchModel *)launch row:(NSInteger)row iconFileName:(NSString *)iconFileName {
    [self updateBackgroundColor:row];
    [self updateYear:launch.launch_year];
    [self updateMonth:launch.launch_date_unix];
    [self updateMission:launch.mission_name];
    [self updateLaunchSite:launch.launch_site.site_name];
    [self updateIcon:iconFileName];
}

-(void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

-(void)setupYear {
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
                                              [self.month.topAnchor constraintEqualToAnchor:self.year.bottomAnchor constant:-12],
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
    
    
    // launch site
    self.launchSite = [[UILabel alloc] initWithFrame:CGRectZero];
    self.launchSite.text = @"launch site";
    self.launchSite.textAlignment = NSTextAlignmentCenter;
    self.launchSite.font = [UIFont systemFontOfSize:14];
    self.launchSite.textColor = [UIColor colorFromHexCode:@"676767"];
    self.launchSite.translatesAutoresizingMaskIntoConstraints = NO;
    [self addSubview:self.launchSite];

    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.launchSite.centerXAnchor constraintEqualToAnchor:self.mission.centerXAnchor],
                                              [self.launchSite.topAnchor constraintEqualToAnchor:self.separator.bottomAnchor constant:LAUNCH_CELL_VERT_GAP],
                                              [self.launchSite.widthAnchor constraintEqualToConstant:width],
                                              [self.launchSite.heightAnchor constraintEqualToConstant:LAUNCH_CELL_HEIGHT-(2*LAUNCH_CELL_VERT_GAP)-missionTopOffset-LAUNCH_CELL_MISSION_HEIGHT-10],
                                              nil]];
    
    
    
}


@end
