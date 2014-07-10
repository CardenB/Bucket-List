//
//  LSAppDelegate.m
//  ListShare
//
//  Created by Carden Bagwell on 7/7/14.
//  Copyright (c) 2014 Carden Bagwell. All rights reserved.
//

#import "LSAppDelegate.h"
#import "LSContactManagerTableViewController.h"
#import "LSSubclassConfigViewController.h"
#import "LSPresenterDelegate.h"
#import "LSDesignFactory.h"
#import <Parse/Parse.h>

@interface LSAppDelegate() <LSPresenterDelegate>

//Nav Controllers
@property (nonatomic, strong) UINavigationController *mainNav;


@end

@implementation LSAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    [Parse setApplicationId:@"3HPUHzjWZjPNd0ZDrYIvdpkdkiYExT69mHCclEoe"
                  clientKey:@"NTQCUlnjQ2P5Wtf0MAkni9eA4BE2xj6epqWYHwkW"];
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen]
                                                   bounds]];
    self.window.backgroundColor = [LSDesignFactory mainBackgroundColor];
    [self.window makeKeyAndVisible];
    [self setup];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



#pragma mark - Setup

-(void) setup
{
    /*self.mainNav = [[UINavigationController alloc] initWithRootViewController:[[LSContactManagerTableViewController
                                                                                alloc] initWithStyle:UITableViewStylePlain]];*/
    UIViewController *initialController = [[LSSubclassConfigViewController alloc]
                                           initWithDelegate:self];
    self.mainNav = [[UINavigationController alloc]
                    initWithRootViewController:initialController];
    [LSDesignFactory configureNavBarDesign:self.mainNav];
    self.window.rootViewController = self.mainNav;
    
}

#pragma mark - Delegates

- (void)presentAsMainViewController:(UIViewController *)viewController
{
    
    [self.mainNav setViewControllers:@[viewController] animated:YES];
    
    viewController.navigationItem.leftBarButtonItem = self.window.rootViewController.navigationItem.leftBarButtonItem;
    
}



@end
