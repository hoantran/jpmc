//
//  ViewController.m
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "ViewController.h"
#import "RestService.h"

@interface ViewController ()

@end

@implementation ViewController
RestService *svr;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    svr = [[RestService alloc] init];
    [svr get:@"https://api.spacexdata.com/v2/launches/all" success:^(NSData * _Nonnull data) {
        NSLog(@"What's up, Doc?");
        NSError *parseError = nil;
        NSDictionary *responseDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&parseError];
        NSLog(@"The response is - %@",responseDictionary);
    }];
}


@end

