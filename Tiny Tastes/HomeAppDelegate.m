//
//  HomeAppDelegate.m
//  Tiny Tastes
//
//  Created by davile2 on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "HomeAppDelegate.h"
#import "SetReminderAlertsViewController.h"
#import "Crittercism.h"
#import "CoreDataManager.h"

@implementation HomeAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.

#ifndef DEBUG
    //Start up Crittercism crash reporting when running on real device
    [Crittercism enableWithAppID:@"53a898f907229a1613000002"];
#endif
    
    //Initialize Core Data
    if (![[CoreDataManager sharedInstance] persistentStoreCoordinator]) {
        NSLog(@")Failed to set up persistence manager");
    }
    
    // Handle launching from a notification
    application.applicationIconBadgeNumber = 0;
    
    SetReminderAlertsViewController *setReminderViewController = [[SetReminderAlertsViewController alloc] init];
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    //first time app is launched
    if (![prefs boolForKey:@"HasLaunchedOnce"]) {
        //first time the app was launched, schedule default notifications
        [setReminderViewController scheduleDefaultNotifications];
        [prefs setBool:YES forKey:@"HasLaunchedOnce"];
        [prefs setBool:YES forKey:@"backgroundSound"];
        [prefs setBool:NO forKey:@"storyNarration"];
        [prefs synchronize];
    }
    
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

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Reminder from Tiny Tastes"
                                                        message:notification.alertBody
                                                       delegate:self cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    
    // Request to reload table view data
    [[NSNotificationCenter defaultCenter] postNotificationName:@"reloadData" object:self];
    
    // Set icon badge number to zero
    application.applicationIconBadgeNumber = 0;
}

#pragma mark - Application's Documents directory

// Returns the URL to the application's Documents directory.
- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end
