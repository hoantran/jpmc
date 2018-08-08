//
//  LaunchViewDelegate.h
//  jpmc
//
//  Created by Hoan Tran on 8/5/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
#import "MissionController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MissionLauncher <NSObject>
-(UINavigationController *)navigator;
@end

@interface LaunchViewDelegate : NSObject<UITableViewDelegate>
@property (nonatomic, weak) id<MissionLauncher> launcherDelegate;
@property (nonatomic, weak) id<MissionInfoProvider> missionInfoProvider;
@end

NS_ASSUME_NONNULL_END
