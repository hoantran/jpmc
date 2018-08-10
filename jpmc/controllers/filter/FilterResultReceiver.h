//
//  FilterResultReceiver.h
//  jpmc
//
//  Created by Hoan Tran on 8/6/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef struct {
    BOOL upcoming;
    NSString *from;
    NSString *to;
} FilterResult;


@protocol FilterResultReceiver <NSObject>
-(void)filterDidComplete:(FilterResult)result;
@end

NS_ASSUME_NONNULL_END
