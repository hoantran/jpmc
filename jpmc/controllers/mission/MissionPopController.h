//
//  MissionPopController.h
//  jpmc
//
//  Created by Hoan Tran on 8/13/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TitleView.h"
#import "MissionCollectionViewDelegate.h"
#import "LaunchModel.h"

NS_ASSUME_NONNULL_BEGIN

@protocol MissionInfoProvider <NSObject>
-(LaunchModel *)launchInfoFor:(NSInteger)row;
-(NSString *)iconFileNameFor:(NSInteger)row;
-(NSUInteger)rowCount;
@end


@interface MissionPopController : UIViewController
@property (nonatomic, weak) id<MissionInfoProvider> missionInfoProvider;
@property (nonatomic) NSInteger row;
@end

NS_ASSUME_NONNULL_END
