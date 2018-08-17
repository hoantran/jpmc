//
//  LaunchViewDelegate.h
//  jpmc
//
//  Created by Hoan Tran on 8/5/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIkit.h>
#import "MissionPopController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MissionPresenter <NSObject>
-(void)present:(UIViewController*)controller;
@end

@interface LaunchViewDelegate : NSObject<UITableViewDelegate,UIViewControllerTransitioningDelegate>
@property (nonatomic, weak) id<MissionPresenter> presentDelegate;
@property (nonatomic, weak) id<MissionInfoProvider> missionInfoProvider;
@end

NS_ASSUME_NONNULL_END
