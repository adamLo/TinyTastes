//
//  StoryModelController.h
//  Tiny Tastes
//
//  Created by davile2 on 10/19/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryViewController.h"
#import "StoryDataViewController.h"


@class StoryDataViewController;

@interface StoryModelController : NSObject <UIPageViewControllerDataSource>
@property (strong, nonatomic) StoryViewController *viewController;

- (void) setStoryViewController:(StoryViewController *) controller;
- (StoryDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(StoryDataViewController *)viewController;
//- (StoryDataViewController *)viewControllerAtKey:(NSString *)key storyboard:(UIStoryboard *)storyboard;
//- (NSString *)keyOfViewController:(StoryDataViewController *)viewController;

@end