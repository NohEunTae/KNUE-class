//
//  AppDelegate.m
//  KNUEclass
//
//  Created by 양동욱 on 2018. 2. 16..
//  Copyright © 2018년 nohkwon. All rights reserved.
//

#import "AppDelegate.h"
#import "KNLoginViewController.h"
#import "KNImageManager.h"
#import <QuickLook/QuickLook.h>
#import "KNALectureTabBarController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setLoginViewControllerToRootViewController];
    [self setNavigationBarAttributeSet];
    [self setTabBarAttributeSet];

    return YES;
}

#pragma mark LoginViewController To RootViewController

- (void)setLoginViewControllerToRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    KNLoginViewController *loginVC = [[KNLoginViewController alloc] init];
    self.window.rootViewController = loginVC;
    [self.window makeKeyAndVisible];
}

#pragma mark Set Navigation Bar Attribute Set

- (void)setNavigationBarAttributeSet {
    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:81.0f/255.0f green:128.0f/255.0f blue:1.0f alpha:1.0f]];
    [[UINavigationBar appearanceWhenContainedInInstancesOfClasses:@[[QLPreviewController class]]]
     setBackgroundImage:[UIImage imageNamed:@"preview_naviBarColor"]
     forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor], NSForegroundColorAttributeName,
                                                          [UIFont fontWithName:@"Arial-BoldMT" size:25.0f], NSFontAttributeName, nil]];
}

#pragma mark Set Tab Bar Attribute Set

- (void)setTabBarAttributeSet {
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Arial-BoldMT" size:10.0f], NSFontAttributeName, nil] forState:UIControlStateNormal];
    
    [[UITabBar appearance] setBarTintColor:[UIColor colorWithRed:81.0f/255.0f green:128.0f/255.0f blue:1.0f alpha:1.0f]];
    [[UITabBar appearance] setTintColor:[UIColor whiteColor]];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIColor whiteColor], NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
}

- (void)applicationWillResignActive:(UIApplication *)application { //비활성화 직전
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


- (void)applicationWillTerminate:(UIApplication *)application { // 앱 종료전
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
