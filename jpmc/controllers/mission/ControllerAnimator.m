//
//  ControllerAnimator.m
//  jpmc
//
//  Created by Hoan Tran on 8/13/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "ControllerAnimator.h"

@interface ControllerAnimator ()
@property (nonatomic) NSTimeInterval duration;
@end


@implementation ControllerAnimator

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.duration = 0.5;
        self.presenting = true;
        self.originalFrame = CGRectZero;
    }
    return self;
}


- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.presenting) {
        UIView *containerView = transitionContext.containerView;
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        UIView *finalView = self.presenting ? toView : [transitionContext viewForKey:UITransitionContextFromViewKey];
        
        CGRect initialFrame = self.presenting ? self.originalFrame : finalView.frame;
        CGRect finalFrame = self.presenting ? finalView.frame : self.originalFrame;
        
        CGFloat xScaleFactor = self.presenting ? initialFrame.size.width / finalFrame.size.width : finalFrame.size.width / initialFrame.size.width;
        CGFloat yScaleFactor = self.presenting ? initialFrame.size.height / finalFrame.size.height : finalFrame.size.height / initialFrame.size.height;
        
        CGAffineTransform scaleTransform = CGAffineTransformMakeScale(xScaleFactor, yScaleFactor);
        
        if(self.presenting){
            finalView.transform = scaleTransform;
            CGPoint initialCenter = CGPointMake((initialFrame.origin.x + initialFrame.size.width)/2 ,
                                                (initialFrame.origin.y + initialFrame.size.height)/2);
            finalView.center = initialCenter;
            finalView.clipsToBounds = YES;
        }
        
        [containerView addSubview:toView];
        [containerView bringSubviewToFront:finalView];
        [UIView animateWithDuration:self.duration delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.0 options:UIViewAnimationOptionTransitionNone animations:^{
            finalView.transform = self.presenting ? CGAffineTransformIdentity : scaleTransform;
            finalView.frame = finalFrame;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    } else {
        UIView *containerView = transitionContext.containerView;
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        
        [containerView addSubview:toView];
        toView.alpha = 0;
        [UIView animateWithDuration:0.2 animations:^{
            toView.alpha = 1.0;
        } completion:^(BOOL finished) {
            [transitionContext completeTransition:YES];
        }];
    }
    
}



- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return self.duration;
}


@end
