//
//  LaunchViewDelegate.m
//  jpmc
//
//  Created by Hoan Tran on 8/5/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "LaunchViewDelegate.h"
#import "LaunchCell.h"
#import "MissionPopController.h"
#import "ControllerAnimator.h"

@interface LaunchViewDelegate()
@property (nonatomic, strong) ControllerAnimator *animator;
@end

@implementation LaunchViewDelegate

- (instancetype)init {
    self = [super init];
    if (self) {
        self.animator = [[ControllerAnimator alloc]init];
    }
    return self;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.presentDelegate != nil && [self.presentDelegate respondsToSelector:@selector(present:)]) {
        // should have one place to get data being presented
//        MissionController *controller = [[MissionController alloc]init];
//        controller.missionInfoProvider = self.missionInfoProvider;
//        controller.row = indexPath.row;
//        [tableView deselectRowAtIndexPath:indexPath animated:YES];
//        [[self.launcherDelegate navigator] pushViewController:controller animated:YES];
        
        MissionPopController *popController = [[MissionPopController alloc]init];
        popController.transitioningDelegate = self;
        popController.missionInfoProvider = self.missionInfoProvider;
        popController.row = indexPath.row;
        [tableView deselectRowAtIndexPath:indexPath animated:YES];

        [self.presentDelegate present:popController];
    }
    
    
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    self.animator.presenting = YES;
    return self.animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    self.animator.presenting = NO;
    return self.animator;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LAUNCH_CELL_HEIGHT;
}



@end
