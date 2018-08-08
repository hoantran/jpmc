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

NSString *const kCellIdentifier = @"MissionLaunchCell";

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
    LaunchCell *cell = (LaunchCell *)[tableView dequeueReusableCellWithIdentifier:kCellIdentifier];
    if (cell == nil) {
        cell = [[LaunchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdentifier];
    }
    
    LaunchModel *launch = [self launchInfo:indexPath.row];
    if (launch != nil) {
        [cell setLaunchInfo:launch row:indexPath.row iconFileName:[self iconFileName:indexPath.row]];
    }

    return cell;
}

- (void)updateLaunches:(NSArray *)launches {
    if (launches != nil) {
        NSLog(@"updating launches");
        self.launches = launches;
    }
}

-(BOOL)isValidRowNumber:(NSInteger)row {
    return row >= 0 && row < self.launches.count;
}

- (NSString *)iconFileName:(NSInteger)row {
    if([self isValidRowNumber:row]) {
        return [NSString stringWithFormat:@"spacex.%lu.jpg",(row % 3)+1];
    }else{
        return @"rocket.placeholder.png";
    }
}

- (LaunchModel *)launchInfo:(NSInteger)row {
    if([self isValidRowNumber:row]){
        return [self.launches objectAtIndex:row];
    } else {
        return nil;
    }
}

@end
