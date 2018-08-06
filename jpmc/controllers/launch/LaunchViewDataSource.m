//
//  LaunchViewDataSource.m
//  jpmc
//
//  Created by Hoan Tran on 8/5/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "LaunchViewDataSource.h"
#import "LaunchModel.h"

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
        NSLog(@"number of rows: %lu", (unsigned long)self.launches.count);
        return self.launches.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:kCellIdentifier];
    }
    NSLog(@"Getting row: %lu", indexPath.row);
//    cell.textLabel.text = @"Hello there";
    LaunchModel *launch = [self.launches objectAtIndex:indexPath.row];
    if (launch == nil) {
        cell.textLabel.text = @"Launch data not available";
    } else {
        cell.textLabel.text = launch.mission_name;
//        cell.detailTextLabel.text = launch.launch_year;

        NSDate* date = [NSDate dateWithTimeIntervalSince1970:launch.launch_date_unix];
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"YYYY-MM-dd"];
        NSLog(@"Local date is %@",[formatter stringFromDate:date]);
        cell.detailTextLabel.text = [formatter stringFromDate:date];
    }
    return cell;
}

- (void)updateLaunches:(NSArray *)launches {
    if (launches != nil) {
        NSLog(@"updating launches");
        self.launches = launches;
    }
}

@end
