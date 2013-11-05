//
//  StoryModelController.m
//  Tiny Tastes
//
//  Created by davile2 on 10/19/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "StoryModelController.h"

#import "StoryDataViewController.h"

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

- (StoryDataViewController *)viewControllerAtKey:(NSString *)key storyboard:(UIStoryboard *)storyboard
{
    // Create a new view controller and pass suitable data.
    StoryDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"StoryDataViewController"];
    dataViewController.dataObject = self.pageData[key];
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
    //NSUInteger index = [self indexOfViewController:(StoryDataViewController *)viewController];
    NSString * dummyString = @"opening1";
    /*if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;*/
    return [self viewControllerAtKey:dummyString storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    /*NSUInteger index = [self indexOfViewController:(StoryDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }*/
    NSString * dummyString = @"opening1";
    return [self viewControllerAtKey:dummyString storyboard:viewController.storyboard];
}

@end