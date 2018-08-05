//
//  LaunchSiteModel.h
//  jpmc
//
//  Created by Hoan Tran on 8/5/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#ifndef LaunchSiteModel_h
#define LaunchSiteModel_h

#import <Foundation/Foundation.h>
#import "JSONModel.h"

//@interface LaunchSiteModel : JSONModel
//@property (nonatomic) NSString *siteId;
//@property (nonatomic) NSString *siteName;
//@property (nonatomic) NSString *siteNameLong;
//@end

@interface LaunchSiteModel : JSONModel
@property (nonatomic) NSString *site_id;
@property (nonatomic) NSString *site_name;
@property (nonatomic) NSString *site_name_long;
@end

#endif /* LaunchSiteModel_h */
