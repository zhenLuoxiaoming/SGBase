//
//  AppDelegate.m
//  SGBase
//
//  Created by 罗晓明 on 2018/8/29.
//  Copyright © 2018年 Rowling. All rights reserved.
//

#import "AppDelegate.h"
#import "SGBase.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    NSMutableArray *controls = [NSMutableArray array];
    ViewController *vc = [ViewController new];
    [controls addObject:vc];
    ViewController *vc2 = [ViewController new];
    [controls addObject:vc2];
    ViewController *vc3 = [ViewController new];
    [controls addObject:vc3];
    ViewController *vc4 = [ViewController new];
    [controls addObject:vc4];
    ViewController *vc5 = [ViewController new];
    [controls addObject:vc5];
    self.window                     = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    SGBaseTabBarController *tab     = [SGBaseTabBarController new];
    tab.tabBarBgImg                 = [UIImage imageWithColor:[UIColor whiteColor]];
    tab.tabBarShadowColor           = [UIColor clearColor];
    tab.itemTitles                  = @[@"首页", @"关注", @"", @"消息", @"我的"];
    tab.itemImages                  = @[@"home_gay", @"collection", @"add", @"send", @"personal"];
    tab.itemSelectImages            = @[@"home", @"collection_x", @"add", @"send_x", @"personal_x"];
    tab.itemIndex                   = @"2";
    tab.itemImageInset              = 6;
    tab.controls                    = controls;
    self.window.rootViewController  = tab;
    self.window.backgroundColor     = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
