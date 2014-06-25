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

@property (assign, nonatomic, readonly) NSInteger currentIndex;

- (void) setStoryViewController:(StoryViewController *) controller;
- (StoryDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(StoryDataViewController *)viewController;
- (void) changeSceneStack:(NSString *) key;

/**
 *  Go directly to scene with given id
 *
 *  @param sceneId Id of scene to go to
 */
- (void)goToSceneWithId:(NSString*)sceneId;

@end