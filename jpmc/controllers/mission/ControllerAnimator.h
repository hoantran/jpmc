//
//  ControllerAnimator.h
//  jpmc
//
//  Created by Hoan Tran on 8/13/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ControllerAnimator : NSObject<UIViewControllerAnimatedTransitioning>
@property (nonatomic) BOOL presenting;
@property (nonatomic) CGRect originalFrame;

@end

NS_ASSUME_NONNULL_END
