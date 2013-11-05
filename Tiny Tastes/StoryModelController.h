//
//  StoryModelController.h
//  Tiny Tastes
//
//  Created by davile2 on 10/19/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@class StoryDataViewController;

@interface StoryModelController : NSObject <UIPageViewControllerDataSource>

- (StoryDataViewController *)viewControllerAtKey:(NSString *)key storyboard:(UIStoryboard *)storyboard;
- (NSString *)keyOfViewController:(StoryDataViewController *)viewController;

@end