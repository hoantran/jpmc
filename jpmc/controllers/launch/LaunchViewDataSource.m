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
    
    [cell setLaunchInfo:[self.launches objectAtIndex:indexPath.row] row:indexPath.row];
    

    return cell;
}

- (void)updateLaunches:(NSArray *)launches {
    if (launches != nil) {
        NSLog(@"updating launches");
        self.launches = launches;
    }
}

@end
