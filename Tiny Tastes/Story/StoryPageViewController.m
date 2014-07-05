//
//  StoryPageViewController.m
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.05..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import "StoryPageViewController.h"
#import "XMLDictionary.h"
#import "StoryPageController.h"

@interface StoryPageViewController () {
    NSDictionary *storyBook; //Actual story book
    NSDictionary *currentPage; //Actual page index in the story book
    
    NSMutableDictionary *pageControllerCache; //Cache containing UIViewControllers for already created pages
}

@end

@implementation StoryPageViewController

//XML dictionary keys
NSString* const kStoryDictionaryKeyScene = @"scene";
NSString* const kStoryDictionaryKeyImage = @"image";
NSString* const kStoryDictionaryKeyX = @"x";
NSString* const kStoryDictionaryKeyY = @"y";
NSString* const kStoryDictionaryKeyW = @"w";
NSString* const kStoryDictionaryKeyH = @"h";
NSString* const kStoryDictionaryKeyPath = @"path";
NSString* const kStoryDictionaryKeyID = @"id";
NSString* const kStoryDictionaryKeyNext = @"next";
NSString* const kStoryDictionaryKeyLink = @"link";
NSString* const kStoryDictionaryKeySound = @"sound";
NSString* const kStoryDictionaryKeyType = @"type";

//Class-level constants
CGFloat const kStoryBookmarkHeightHidden = 30; //Bookmark height when not displayed
CGFloat const kStoryBookmarkHeightSet = 107; //Bookmark height when set
NSString* const kStoryBookmarkDefaultsKey = @"BookmarkedStorySceneId"; //Key in NSUSerdefaults for bookmark

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self loadStoryBookWithFilename:@"story.xml"];
    
    self.dataSource = self;
    self.delegate = self;
    
    pageControllerCache = [[NSMutableDictionary alloc] init];
    
    self.view.backgroundColor = [UIColor darkGrayColor];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadStoryBookWithFilename:(NSString*)xmlFile {
    
    //Load and parse story book
    NSString *path = [[NSBundle mainBundle] pathForResource:xmlFile ofType:nil];
    [XMLDictionaryParser sharedInstance].attributesMode = XMLDictionaryAttributesModeUnprefixed;
    storyBook = [NSDictionary dictionaryWithXMLFile:path];
    
    //get starting page
    currentPage = [[storyBook objectForKey:kStoryDictionaryKeyScene] firstObject];
    
    //Clear cache
    [pageControllerCache removeAllObjects];
    
    //Load first page
    [self setViewControllers:@[[self controllerForSceneID:[currentPage objectForKey:kStoryDictionaryKeyID]]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        NSLog(@"Finished");
    }];
}

#pragma mark Page caching

/**
 *  Get page controller from cache or create if does not exist
 *
 *  @param sceneID Id of page scene
 *
 *  @return Page controller
 */
- (StoryPageController*)controllerForSceneID:(NSString*)sceneID {
    
    //Find in cache
    StoryPageController* controller = [pageControllerCache objectForKey:sceneID];
    
    if (!controller) {
        //Find page description in the story
        for (NSDictionary *pageData in [storyBook objectForKey:kStoryDictionaryKeyScene]) {
            if ([[pageData objectForKey:kStoryDictionaryKeyID] isEqualToString:sceneID]) {
                //Found scene
                
                //Create controller for page
                controller = [[StoryPageController alloc] init];
                controller.view.frame = self.view.frame;
                controller.pageViewController = self;
                [controller loadStoryPage:pageData];
                
                //Add to cache
                [pageControllerCache setObject:controller forKey:sceneID];
                
                return controller;
            }
        }
    }
    
    return controller;
}

- (void)gotoSceneWithID:(NSString *)sceneId {
    StoryPageController *controller = [self controllerForSceneID:sceneId];
    if (controller) {
        //Load first page
        [self setViewControllers:@[controller] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
            NSLog(@"Finished");
        }];
    }
}

#pragma mark UIPageViewController dataSource

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {

    //Get current scene id
    NSString *currentSceneId = [[(StoryPageController*)viewController pageData] objectForKey:kStoryDictionaryKeyID];
    
    //Find previous scene id
    NSString *prevSceneId;
    for (NSDictionary *pageData in [storyBook objectForKey:kStoryDictionaryKeyScene]) {
        NSDictionary *next = [pageData objectForKey:kStoryDictionaryKeyNext];
        if ([[next objectForKey:kStoryDictionaryKeyID] isEqualToString:currentSceneId]) {
            //We got previous page
            prevSceneId = [pageData objectForKey:kStoryDictionaryKeyID];
            break;
        }
        
        if ([[pageData objectForKey:kStoryDictionaryKeyLink] isKindOfClass:[NSDictionary class]]) {
            //One link only
            if ([[[pageData objectForKey:kStoryDictionaryKeyLink] objectForKey:kStoryDictionaryKeyID] isEqualToString:currentSceneId]) {
                //Got the link
                prevSceneId = [pageData objectForKey:kStoryDictionaryKeyID];
                break;
            }
        }
        else if ([[pageData objectForKey:kStoryDictionaryKeyLink] isKindOfClass:[NSArray class]]) {
            //Search over links
            for (NSDictionary *linkDict in [pageData objectForKey:kStoryDictionaryKeyLink]) {
                if ([[linkDict objectForKey:kStoryDictionaryKeyID] isEqualToString:currentSceneId]) {
                    //Got the link
                    prevSceneId = [pageData objectForKey:kStoryDictionaryKeyID];
                    break;
                }
            }
        }
    }
    
    //Get controller from cache
    StoryPageController *prevController;
    if (prevSceneId) {
        prevController = [self controllerForSceneID:prevSceneId];
    }
    
    return prevController;
}

- (UIViewController*)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSDictionary *pageData = [(StoryPageController*)viewController pageData];
    NSDictionary *next = [pageData objectForKey:kStoryDictionaryKeyNext];
    
    StoryPageController *nextController;
    if (next) {
        nextController = [self controllerForSceneID:[next objectForKey:kStoryDictionaryKeyID]];
    }
    
    if (!nextController) {
        //No next scene, go to eating screen
    }
    
    return nextController;
    
}

@end
