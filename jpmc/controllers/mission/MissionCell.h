//
//  MissionCell.h
//  jpmc
//
//  Created by Hoan Tran on 8/17/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaunchModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface MissionCell : UICollectionViewCell
-(void)setLaunchInfo: (LaunchModel *)launch iconFile:(NSString *)iconFileName;
@end

NS_ASSUME_NONNULL_END
