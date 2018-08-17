//
//  MissionCollectionViewDataSource.h
//  jpmc
//
//  Created by Hoan Tran on 8/14/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "MissionPopController.h"

NS_ASSUME_NONNULL_BEGIN

extern NSString *const MISSION_CELL_ID;

@interface MissionCollectionViewDataSource : NSObject<UICollectionViewDataSource>
@property (nonatomic, weak) id<MissionInfoProvider> missionInfoProvider;
@end

NS_ASSUME_NONNULL_END
