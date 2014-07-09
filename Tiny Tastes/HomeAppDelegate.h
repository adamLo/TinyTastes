//
//  HomeAppDelegate.h
//  Tiny Tastes
//
//  Created by davile2 on 9/18/13.
//  Copyright (c) 2013 le labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/**
 *  Return application document directory URL. Needed for Core Data
 *
 *  @return URL to application document directory
 */
- (NSURL *)applicationDocumentsDirectory;

@end
