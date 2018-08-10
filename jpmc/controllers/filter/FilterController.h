//
//  FilterController.h
//  jpmc
//
//  Created by Hoan Tran on 8/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FilterResultReceiver.h"

@protocol FilterResultReceiver;

NS_ASSUME_NONNULL_BEGIN

@interface FilterController : UIViewController
@property (nonatomic, weak) id<FilterResultReceiver> filterResultDelegate;
-(instancetype)init:(FilterResult) prevFilter;
@end

NS_ASSUME_NONNULL_END
