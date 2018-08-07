//
//  LaunchViewDataSource.m
//  jpmc
//
//  Created by Hoan Tran on 8/5/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "LaunchViewDataSource.h"
#import "LaunchModel.h"
#import "LaunchCell.h"

NSString *const kCellIdentifier = @"CLICK";

@interface LaunchViewDataSource ()
@property (strong, nonatomic) NSArray* launches;
@end

@implementation LaunchViewDataSource

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.launches = [[NSArray alloc]init];
    }
    
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.launches == nil) {
        return 0;
    } else {
        return self.launches.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"HistoryCell";
    
    // Similar to UITableViewCell, but
    LaunchCell *cell = (LaunchCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[LaunchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    // Just want to test, so I hardcode the data
//    cell.descriptionLabel.text = @"Testing";
    
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
//    }
//    LaunchModel *launch = [self.launches objectAtIndex:indexPath.row];
//    if (launch == nil) {
//        cell.textLabel.text = @"Launch data not available";
//    } else {
//        cell.textLabel.text = launch.mission_name;
//
//        NSDate* date = [NSDate dateWithTimeIntervalSince1970:launch.launch_date_unix];
//
//        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//        [formatter setDateFormat:@"YYYY-MM-dd"];
//        cell.detailTextLabel.text = [formatter stringFromDate:date];
//    }
    return cell;
}

- (void)updateLaunches:(NSArray *)launches {
    if (launches != nil) {
        NSLog(@"updating launches");
        self.launches = launches;
    }
}

@end
