//
//  StoryViewController.h
//  Tiny Tastes
//
//  Created by davile2 on 10/19/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryDataViewController.h"


@class StoryViewController;

@interface StoryViewController : UIViewController <UIPageViewControllerDelegate>

@property (strong, nonatomic) UIPageViewController *pageViewController;

- (void) changeSceneStack:(NSString *) key;

- (void)gotoSceneWithId:(NSString*)sceneId;

@end