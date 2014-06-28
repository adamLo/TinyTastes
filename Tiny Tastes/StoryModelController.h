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

/**
 *  A controller object that manages a simple model -- a collection of month names.
 *
 *  The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: 
 *  and pageViewController:viewControllerAfterViewController:.
 *  It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 *
 *  There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. 
 *  Given the data model, these methods create, configure, and return a new view controller on demand.
*/
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