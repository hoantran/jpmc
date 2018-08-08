//
//  LaunchCell.h
//  jpmc
//
//  Created by Hoan Tran on 8/7/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LaunchModel.h"

NS_ASSUME_NONNULL_BEGIN


extern CGFloat const LAUNCH_CELL_HEIGHT;

@interface LaunchCell : UITableViewCell
- (void)setLaunchInfo:(LaunchModel *)launch row:(NSInteger)row;
@end

NS_ASSUME_NONNULL_END
