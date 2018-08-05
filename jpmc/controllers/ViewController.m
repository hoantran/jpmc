//
//  ViewController.m
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "ViewController.h"
#import "RestService.h"
#import "LaunchModel.h"
#import "LaunchSiteModel.h"

@interface ViewController ()
@property (strong, nonatomic) NSArray* launches;
//@property (strong, nonatomic) NSArray* next;
@end

@implementation ViewController
RestService *svr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    svr = [[RestService alloc] init];
    [svr get:@"https://api.spacexdata.com/v2/launches/next" success:^(NSData * _Nonnull data) {
        NSLog(@"What's up, Doc?");
//        NSError *parseError = nil;
//        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
//        NSLog(@"The response is - %@",responseDictionary);
        NSError* err = nil;
//        self.launches = [LaunchModel arrayOfModelsFromData:data error:&err];
//        NSLog(err);
//        NSLog(self.launches);
//        LaunchModel *nextLaunch = [[LaunchModel alloc] initWithString:data error:&err];
        LaunchModel *x = [[LaunchModel alloc] initWithData:data error:&err];
        NSLog(@"mission name: %@", x.mission_name);
        
        NSLog(@"ok");
    }];
}


@end

