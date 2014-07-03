//
//  StoryModelController.m
//  Tiny Tastes
//
//  Created by davile2 on 10/19/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "StoryModelController.h"
#import "SceneFactory.h"

@interface StoryModelController()
@property (readonly, strong, nonatomic) NSDictionary *pageData;
@property (strong, nonatomic) NSArray *sceneStack;
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
        _pageData = [NSDictionary dictionaryWithDictionary:[sceneFactory populateScenes]];
        sceneFactory = nil;
        
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

/**
 *  Moving backwards in the story
 */
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    if ((_currentIndex == 0) || (_currentIndex == NSNotFound)) {
        //This is the first page of the current scene stack
        
        Scene *currentScene = self.sceneStack[_currentIndex];
        
        //Check if there is a preceding scene
        for (NSString *sceneKey in self.pageData) {
            NSArray *scenes = [self.pageData objectForKey:sceneKey];
            for (Scene *scene in scenes) {            
                if (([scene.linkDestinations indexOfObject:currentScene.sceneID] != NSNotFound) || [scene.nextSceneID isEqualToString:currentScene.sceneID]) {
                    //Got the last fork in the story
                    
                    //Change scene stack for the one that has this scene
                    [self changeSceneStack:sceneKey];
                    
                    //Switch to last scene in the stack
                    _currentIndex = [scenes indexOfObject:scene];
                    return [self viewControllerAtIndex:_currentIndex storyboard:viewController.storyboard];
                }
            }
            
        }
        
        //No previous scene
        return nil;
        
    }

    //Just simply scroll backwards
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
        NSString *nextId = [(Scene*)[self.sceneStack objectAtIndex:_currentIndex] nextSceneID];
        if (nextId) {
            [self changeSceneStack:nextId];
            _currentIndex = -1; //To let it increase to 0;
        }
        else {
            return nil;
        }
    }
    _currentIndex++;
    return [self viewControllerAtIndex:_currentIndex storyboard:viewController.storyboard];
}

- (void)goToSceneWithId:(NSString*)sceneId {
    for (NSString *sceneKey in self.pageData) {
        NSArray *scenes = [self.pageData objectForKey:sceneKey];
        for (Scene *scene in scenes) {
            if ([scene.sceneID isEqualToString:sceneId]) {
                //Change scene stack for the one that has this scene
                _sceneStack = [self.pageData objectForKey:sceneKey];
                _currentIndex = [scenes indexOfObject:scene];
                
                break;
            }
        }
    }
}

- (void)dealloc {
    _sceneStack = nil;
    _pageData = nil;
}

@end