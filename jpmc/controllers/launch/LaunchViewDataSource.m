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

NSString *const MISSION_LAUNCH_CELL_ID = @"MissionLaunchCell";

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
    LaunchCell *cell = (LaunchCell *)[tableView dequeueReusableCellWithIdentifier:MISSION_LAUNCH_CELL_ID];
    if (cell == nil) {
        cell = [[LaunchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MISSION_LAUNCH_CELL_ID];
    }
    
    LaunchModel *launch = [self launchInfoFor:indexPath.row];
    if (launch != nil) {
        [cell setLaunchInfo:launch row:indexPath.row iconFileName:[self iconFileNameFor:indexPath.row]];
    }

    return cell;
}

- (void)updateLaunches:(NSArray *)launches {
    if (launches != nil) {
        self.launches = launches;
    }
}

-(BOOL)isValidRowNumber:(NSInteger)row {
    return row >= 0 && row < self.launches.count;
}

- (NSString *)iconFileNameFor:(NSInteger)row {
    if([self isValidRowNumber:row]) {
        return [NSString stringWithFormat:@"spacex.%lu.jpg",(row % 3)+1];
    }else{
        return @"rocket.placeholder.png";
    }
}

- (LaunchModel *)launchInfoFor:(NSInteger)row {
    if([self isValidRowNumber:row]){
        return [self.launches objectAtIndex:row];
    } else {
        return nil;
    }
}


-(NSUInteger)rowCount {
    if (self.launches == nil) {
        return 0;
    } else {
        return self.launches.count;
    }
}

@end
