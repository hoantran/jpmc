//
//  RestService.m
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "RestService.h"

// ..............................................................................................
// Barebone impletation without unit testing
// Most likely, a full app would download specialized date such as images or videos.
// In that case, this service would expand to include those specific functions
//

// Timing out a GET request would be very useful
// when Internet connection is not possible.
// A timeout signal would alert the user that something is wrong with connectivity, and
// not with the application itself.

// A "Cancel" request would also be useful when the controller issuing the original request
// no longer cares about the result

// This service is re-entrant. So multiple simultaneous requests are possible
// ..............................................................................................


@implementation RestService

- (void)get:(NSString *)url success:(void (^)(NSData * _Nonnull))success {
    NSURL *urlRequest = [[NSURL alloc] initWithString:url];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithURL:urlRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == NULL) {
            NSLog(@"Retrieved data successfully!");
            success(data);
        } else {
            NSLog(@"ERR: Encountered errors when retrieving data from [%@]", url);
        }
    }];
    
//

    [dataTask resume];
}

@end
