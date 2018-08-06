//
//  LaunchModel.h
//  jpmc
//
//  Created by Hoan Tran on 8/5/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#ifndef LaunchModel_h
#define LaunchModel_h

#import <Foundation/Foundation.h>
#import "JSONModel.h"
#import "LaunchSiteModel.h"


typedef NS_ENUM(NSInteger, LaunchFilter) {
    LaunchFilterbyUpcoming
};

@interface LaunchModel : JSONModel
@property (nonatomic) int                   flight_number;
@property (nonatomic) NSString              *mission_name;
@property (nonatomic) NSString              *launch_year;
@property (nonatomic) double                launch_date_unix;
@property (nonatomic) NSString              *launch_date_utc;
@property (nonatomic) NSString              *launch_date_local;
@property (nonatomic) NSString <Ignore>     *rocket;
@property (nonatomic) NSString <Ignore>     *telemetry;
@property (nonatomic) NSString <Ignore>     *reuse;
@property (nonatomic) LaunchSiteModel       *launch_site;
@property (nonatomic) NSString <Optional>   *launch_success;
@property (nonatomic) NSString <Ignore>     *links;
@property (nonatomic) NSString <Optional>   *details;
@property (nonatomic) BOOL    upcoming;

+(NSArray *)filter: (NSArray *)array byYear:(nonnull NSString*)year;
+(NSArray *)filter: (NSArray *)array byKind:(LaunchFilter)kind;
+(NSArray *)filter: (NSArray *)array byDateRangeFrom:(double)from to:(double)to;
+(double)earliest: (NSArray *)array;
+(double)latest: (NSArray *)array;

@end

#endif /* LaunchModel_h */
