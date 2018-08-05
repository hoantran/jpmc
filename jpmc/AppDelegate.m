//
//  AppDelegate.m
//  jpmc
//
//  Created by Hoan Tran on 8/4/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
//    self.window.rootViewController = [[ViewController alloc] init];
//    self.window.backgroundColor = [UIColor cyanColor];
    
    
//    UINavigationBar.appearance().barTintColor = UIColor.white
//    let controller = UINavigationController()
//    let img = UIImage()
//    controller.navigationBar.shadowImage = img
//    window = UIWindow(frame: UIScreen.main.bounds)
//    window?.makeKeyAndVisible()
//    window?.rootViewController = controller
    
//    [[UINavigationBar appearance] setTintColor:[UIColor redColor]];

//    window?.rootViewController = UINavigationController(rootViewController: MainController())
    
    ViewController *controller = [[ViewController alloc] init];
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
