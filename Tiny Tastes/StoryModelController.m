//
//  StoryModelController.m
//  Tiny Tastes
//
//  Created by davile2 on 10/19/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "StoryModelController.h"
#import "SceneFactory.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

@interface StoryModelController()
@property (readonly, strong, nonatomic) NSMutableDictionary *pageData;
@end

@implementation StoryModelController
@synthesize viewController = _viewController;

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        SceneFactory *sceneFactory = [[SceneFactory alloc] init];
        _pageData = [sceneFactory populateScenes];
    }
    return self;
}

- (void) setStoryViewController:(StoryViewController *) viewController;
{
    _viewController = viewController;
}

- (StoryDataViewController *)viewControllerAtKey:(NSString *)key storyboard:(UIStoryboard *)storyboard
{
    // Create a new view controller and pass suitable data.
    StoryDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"StoryDataViewController"];
    dataViewController.dataObject = self.pageData[key];
    [_viewController setStoryViewController:dataViewController];
    return dataViewController;
}

- (NSString *) keyOfViewController:(StoryDataViewController *)viewController
{
    NSString * dummyString = @"opening1";
    return dummyString;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSString * dummyString = @"opening1";
    return [self viewControllerAtKey:dummyString storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSString * dummyString = @"opening1";
    return [self viewControllerAtKey:dummyString storyboard:viewController.storyboard];
}

@end