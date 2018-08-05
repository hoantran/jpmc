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


@interface LaunchModel : JSONModel
@property (nonatomic) int         flight_number;
@property (nonatomic) NSString          *mission_name;
@property (nonatomic) NSString          *launch_year;
@property (nonatomic) long         launch_date_unix;
@property (nonatomic) NSString          *launch_date_utc;
@property (nonatomic) NSString          *launch_date_local;
@property (nonatomic) NSString <Ignore> *rocket;
@property (nonatomic) NSString <Ignore> *telemetry;
@property (nonatomic) NSString <Ignore> *reuse;
@property (nonatomic) LaunchSiteModel   *launch_site;
@property (nonatomic) NSString <Optional> *launch_success;
@property (nonatomic) NSString <Ignore> *links;
@property (nonatomic) NSString <Optional> *details;
@property (nonatomic) NSString <Optional> *upcoming;
@end

//"flight_number": 67,
//"mission_name": "Merah Putih",
//"launch_year": "2018",
//"launch_date_unix": 1533619080,
//"launch_date_utc": "2018-08-07T05:18:00.000Z",
//"launch_date_local": "2018-08-07T01:18:00-04:00",
//"rocket": {},
//"telemetry": {},
//"reuse": {},
//"launch_site": {},
//"launch_success": null,
//"links": {},
//"details": null,
//"upcoming": true


//@interface LaunchModel : JSONModel
//@property (nonatomic) NSInteger         flightNumber;
//@property (nonatomic) NSString          *missionName;
//@property (nonatomic) NSInteger         launchYear;
//@property (nonatomic) NSInteger         launch_date_unix;
//@property (nonatomic) NSString          *launch_date_utc;
//@property (nonatomic) NSString          *launch_date_local;
//@property (nonatomic) NSString <Ignore> *rocket;
//@property (nonatomic) NSString <Ignore> *telemetry;
//@property (nonatomic) NSString <Ignore> *reuse;
//@property (nonatomic) LaunchSiteModel   *launchSite;
//@property (nonatomic) BOOL              launch_success;
//@property (nonatomic) NSString <Ignore> *links;
//@property (nonatomic) NSString          *details;
//@property (nonatomic) BOOL              upcoming;
//@end






#endif /* LaunchModel_h */
