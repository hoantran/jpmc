//
//  TitleView.h
//  jpmc
//
//  Created by Hoan Tran on 8/14/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TapDelegate <NSObject>
-(void)handleTap;
@end

@interface TitleView : UIView
@property (nonatomic, weak) id<TapDelegate> tapDelegate;
-(void)setTitle:(NSString *)newTitle;
@end

NS_ASSUME_NONNULL_END
