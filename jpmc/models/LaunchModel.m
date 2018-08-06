//
//  LaunchModel.m
//  jpmc
//
//  Created by Hoan Tran on 8/5/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LaunchModel.h"

// Though empty, the linker requires the implementation to be present
@implementation LaunchModel


+(NSPredicate *)yearPredicate: (NSString *)year {
    return [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [[evaluatedObject launch_year] isEqualToString:year];
    }];
}

+(NSPredicate *)upcomingPredicate {
    return [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject upcoming];
    }];
}

+(NSPredicate *)dateRangePredicateFrom: (double)from to:(double)to {
    return [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [evaluatedObject launch_date_unix] >= from && [evaluatedObject launch_date_unix] <= to;
    }];
}


#pragma mark - Helper methods
+(NSArray *)filter: (NSArray *)array byYear:(nonnull NSString*)year {
    if (array == nil || [year length] == 0) {
        return [[NSArray alloc]init];
    } else {
        return [array filteredArrayUsingPredicate:[self yearPredicate:year]];
    }
}

+(NSArray *)filter: (NSArray *)array byKind:(LaunchFilter)kind {
    if(kind == LaunchFilterbyUpcoming) {
        return [array filteredArrayUsingPredicate:[self upcomingPredicate]];
    } else {
        return [[NSArray alloc]init];
    }
}

+(NSArray *)filter: (NSArray *)array byDateRangeFrom:(double)from to:(double)to {
    if(from <= to) {
        return [array filteredArrayUsingPredicate:[self dateRangePredicateFrom:from to:to]];
    } else {
        return [[NSArray alloc]init];
    }

}




@end
