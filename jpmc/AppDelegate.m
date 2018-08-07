//
//  AppDelegate.m
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "AppDelegate.h"
#import "LaunchController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    // ..............................................................................................
    // For a simple app such as this one that has a small number of screens,
    // this common practice of allowing one viewController calling another directly is sufficient and effective.
    // For a larger app where switching graph between the many controllers are more complex,
    // a coordinator pattern or the likes would be more appropriate to move the routing responsibilities 
    // from the viewControllers onto objects specifically designed for this role.
    // These patterns separate the routing concerns from the viewControllers leaving them
    // more concentrated on UI tasks.
    // ..............................................................................................
    
    LaunchController *controller = [[LaunchController alloc] init];
    self.window.rootViewController = [[UINavigationController alloc]initWithRootViewController:controller];
    self.window.backgroundColor = [UIColor whiteColor];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
}


- (void)applicationWillTerminate:(UIApplication *)application {
}


@end
