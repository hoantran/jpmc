//
//  RestService.h
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface RestService : NSObject
- (void) get:(NSString *) url success:(void (^)(NSData *data))success;

@end

NS_ASSUME_NONNULL_END
