//
//  MissionController.m
//  jpmc
//
//  Created by Hoan Tran on 8/8/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "MissionController.h"
#import "UIColor+Hex.h"

CGFloat const ICON_HEIGHT            = 200;
CGFloat const TOP_OFFSET            = 15;
CGFloat const VERT_OFFSET            = 15;


@interface MissionController ()
@property (strong, nonatomic) UIImageView *icon;
@property (strong, nonatomic) UILabel *success;
//@property (strong, nonatomic) UIView *separator;
@property (strong, nonatomic) UILabel *launchSite;
@property (strong, nonatomic) UILabel *missionDate;
@property (strong, nonatomic) UITextView *details;
@property (strong, nonatomic) NSArray *bkgColors;
@end



@implementation MissionController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorFromHexCode:@"D8FAFF"];
    
    self.bkgColors = [[NSArray alloc] initWithObjects:[UIColor clearColor],[UIColor colorFromHexCode:@"B1F5FF"], nil];

    [self setupView];
    [self refreshView];
}

-(void)setupView {
    int bkgIndex = 0;
    [self setupIcon:++bkgIndex];
    [self setupSuccess:++bkgIndex];
    [self setupLaunchSite:++bkgIndex];
    [self setupMissionDate:++bkgIndex];
    [self setupDetails:++bkgIndex];
}

-(void)setupIcon:(int)bkgIndex {
    double height = ICON_HEIGHT;
    self.icon = [[UIImageView alloc]initWithImage:NULL highlightedImage:NULL];
    [self.icon setImage: [UIImage imageNamed: @"rocket.placeholder.png"]];
    self.icon.contentMode = UIViewContentModeScaleAspectFill;
    self.icon.layer.cornerRadius = height / 2;
    self.icon.layer.masksToBounds = YES;
    self.icon.layer.borderWidth = 6.0f;
    self.icon.layer.borderColor = [UIColor whiteColor].CGColor;
    self.icon.translatesAutoresizingMaskIntoConstraints = NO;
    self.icon.backgroundColor = [self.bkgColors objectAtIndex:(bkgIndex % self.bkgColors.count)];
    [self.view addSubview:self.icon];
    
    
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.icon.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
                                              [self.icon.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:TOP_OFFSET],
                                              [self.icon.widthAnchor constraintEqualToConstant:height],
                                              [self.icon.heightAnchor constraintEqualToConstant:height],
                                              nil]];
}

-(void)setupSuccess:(int)bkgIndex {
    self.success = [[UILabel alloc] initWithFrame:CGRectZero];
    self.success.text = @"launch status unknown";
    self.success.textAlignment = NSTextAlignmentCenter;
    self.success.font = [UIFont boldSystemFontOfSize:18];
    self.success.textColor = [UIColor grayColor];
    self.success.translatesAutoresizingMaskIntoConstraints = NO;
    self.success.backgroundColor = [self.bkgColors objectAtIndex:(bkgIndex % self.bkgColors.count)];
    [self.view addSubview:self.success];
    
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.success.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
                                              [self.success.topAnchor constraintEqualToAnchor:self.icon.bottomAnchor constant:15],
                                              [self.success.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
                                              [self.success.heightAnchor constraintEqualToConstant:30],
                                              nil]];
}

-(void)setupLaunchSite:(int)bkgIndex {
    self.launchSite = [[UILabel alloc] initWithFrame:CGRectZero];
    self.launchSite.text = @"launch site unknown";
    self.launchSite.textAlignment = NSTextAlignmentCenter;
    self.launchSite.font = [UIFont systemFontOfSize:14];
    self.launchSite.textColor = [UIColor grayColor];
    self.launchSite.translatesAutoresizingMaskIntoConstraints = NO;
    self.launchSite.backgroundColor = [self.bkgColors objectAtIndex:(bkgIndex % self.bkgColors.count)];
    self.launchSite.numberOfLines = 0;
    [self.launchSite sizeToFit];
    [self.view addSubview:self.launchSite];
    
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.launchSite.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
                                              [self.launchSite.topAnchor constraintEqualToAnchor:self.success.bottomAnchor constant:10],
                                              [self.launchSite.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
                                              [self.launchSite.heightAnchor constraintEqualToConstant:40],
                                              nil]];
}

-(void)setupMissionDate:(int)bkgIndex {
    self.missionDate = [[UILabel alloc] initWithFrame:CGRectZero];
    self.missionDate.text = @"unknown launch date";
    self.missionDate.textAlignment = NSTextAlignmentCenter;
    self.missionDate.font = [UIFont systemFontOfSize:18];
    self.missionDate.textColor = [UIColor grayColor];
    self.missionDate.translatesAutoresizingMaskIntoConstraints = NO;
    self.missionDate.backgroundColor = [self.bkgColors objectAtIndex:(bkgIndex % self.bkgColors.count)];
    [self.view addSubview:self.missionDate];
    
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.missionDate.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
                                              [self.missionDate.topAnchor constraintEqualToAnchor:self.launchSite.bottomAnchor constant:10],
                                              [self.missionDate.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
                                              [self.missionDate.heightAnchor constraintEqualToConstant:20],
                                              nil]];
}

-(void)setupDetails:(int)bkgIndex {
    self.details = [[UITextView alloc] initWithFrame:CGRectZero];
    self.details.text = @"";
    self.details.textAlignment = NSTextAlignmentCenter;
    self.details.font = [UIFont systemFontOfSize:18];
    self.details.textColor = [UIColor blackColor];
    self.details.translatesAutoresizingMaskIntoConstraints = NO;
    self.details.backgroundColor = [self.bkgColors objectAtIndex:(bkgIndex % self.bkgColors.count)];
    self.details.userInteractionEnabled = YES;
    self.details.editable = NO;
    self.details.scrollsToTop = YES;
    [self.view addSubview:self.details];
    
    [self.details setHidden:YES];
    
    [NSLayoutConstraint activateConstraints: [NSArray arrayWithObjects:
                                              [self.details.centerXAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.centerXAnchor],
                                              [self.details.topAnchor constraintEqualToAnchor:self.missionDate.bottomAnchor constant:10],
                                              [self.details.widthAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.widthAnchor],
                                              [self.details.bottomAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.bottomAnchor constant:-15],
                                              nil]];
}

-(void)refreshView {
    if(self.missionInfoProvider != nil){
        LaunchModel *launch = [self.missionInfoProvider launchInfo:self.row];
        if (launch != nil) {
            
            // mission title
            if(launch.mission_name != nil) {
                NSString *missionName = [launch.mission_name uppercaseString];
                int lengthLimit = 15;
                if (missionName.length > lengthLimit)
                    missionName = [missionName substringToIndex:lengthLimit];
                self.navigationItem.title = missionName;
            }
            
            // succes
            if(launch.launch_success != nil) {
                BOOL successful = [launch.launch_success boolValue];
                if(successful) {
                    self.success.text = @"launch successful";
                    self.success.textColor = [UIColor colorFromHexCode:@"00B121"];
                }else{
                    self.success.text = @"launch failed";
                    self.success.textColor = [UIColor redColor];
                }
            }
            
            // launch site
            self.launchSite.text = launch.launch_site.site_name_long;
            
            // mission date
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:launch.launch_date_unix];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"MMM dd, yyyy"];
            self.missionDate.text = [[formatter stringFromDate:date] uppercaseString];
            
            // details
            NSString *details = launch.details;
            if(details != nil && details.length > 0){
                [self.details setHidden:NO];
                self.details.text = details;
            } else {
                [self.details setHidden:YES];
            }
            
        }
    }
    
    // icon
    NSString *iconFileName = [self.missionInfoProvider iconFileName:self.row];
    [self.icon setImage: [UIImage imageNamed: iconFileName]];
}

@end
