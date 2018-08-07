//
//  LaunchViewDelegate.m
//  jpmc
//
//  Created by Hoan Tran on 8/5/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "LaunchViewDelegate.h"
#import "LaunchCell.h"

@implementation LaunchViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"Mission on row [%lu]", [indexPath row]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LAUNCH_CELL_HEIGHT;
}

@end
