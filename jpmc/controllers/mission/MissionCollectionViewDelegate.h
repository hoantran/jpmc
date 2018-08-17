//
//  MissionCollectionViewDelegate.h
//  jpmc
//
//  Created by Hoan Tran on 8/14/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol ItemChangeListener <NSObject>
-(void)item:(int)item;
@end

@interface MissionCollectionViewDelegate : NSObject<UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
@property (nonatomic, weak) id<ItemChangeListener> itemChangeListener;
@end

NS_ASSUME_NONNULL_END
