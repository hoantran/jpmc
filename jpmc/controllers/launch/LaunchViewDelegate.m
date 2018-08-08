//
//  LaunchViewDelegate.m
//  jpmc
//
//  Created by Hoan Tran on 8/5/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "LaunchViewDelegate.h"
#import "LaunchCell.h"
#import "MissionController.h"

@implementation LaunchViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Mission on row [%lu]", [indexPath row]);
    
    if (self.launcherDelegate != nil && [self.launcherDelegate respondsToSelector:@selector(navigator)]) {
        // should have one place to get data being presented
        MissionController *controller = [[MissionController alloc]init];
        controller.missionInfoProvider = self.missionInfoProvider;
        controller.row = indexPath.row;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        [[self.launcherDelegate navigator] pushViewController:controller animated:YES];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LAUNCH_CELL_HEIGHT;
}

@end
