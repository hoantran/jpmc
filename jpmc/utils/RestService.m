//
//  RestService.m
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "RestService.h"

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
