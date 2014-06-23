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
@property (strong, nonatomic) NSMutableArray *sceneStack;
@property (assign, nonatomic) int currentIndex;
@end

@implementation StoryModelController
@synthesize viewController = _viewController;
@synthesize sceneStack = _sceneStack;
@synthesize currentIndex = _currentIndex;

- (id)init
{
    self = [super init];
    if (self) {
        // Create the data model.
        SceneFactory *sceneFactory = [[SceneFactory alloc] init];
        _pageData = [sceneFactory populateScenes];
        
        _sceneStack = [self.pageData objectForKey:@"titlePage"];
        _currentIndex = 0;
    }    
    return self;
}

- (void) setStoryViewController:(StoryViewController *) viewController;
{
    _viewController = viewController;
}

-(void) changeSceneStack:(NSString *) key {
    _sceneStack = [self.pageData objectForKey:key];
    _currentIndex = 0;
}

- (StoryDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{
    // Return the data view controller for the given index.
    if (([self.sceneStack count] == 0) || (index >= [self.sceneStack count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    StoryDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"StoryDataViewController"];
    [dataViewController setStoryViewController:_viewController];
    dataViewController.dataObject = self.sceneStack[index];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(StoryDataViewController *)viewController
{
    // Return the index of the given data view controller.
    // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
    return [self.sceneStack indexOfObject:viewController.dataObject];
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ((_currentIndex == 0) || (_currentIndex == NSNotFound)) {
        return nil;
    }

    _currentIndex--;
    return [self viewControllerAtIndex:_currentIndex storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    if (((Scene *) [self.sceneStack objectAtIndex:_currentIndex]).end == YES) {
        [_viewController performSegueWithIdentifier:@"toPhotoView" sender:_viewController];
        return nil;
    }
    if (_currentIndex == [self.sceneStack count] - 1) {
        return nil;
    }
    _currentIndex++;
    return [self viewControllerAtIndex:_currentIndex storyboard:viewController.storyboard];
}

@end