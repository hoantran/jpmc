//
//  LaunchController.h
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterResultReceiver.h"
#import "LaunchViewDelegate.h"

@interface LaunchController : UIViewController<FilterResultReceiver, MissionPresenter>


@end

