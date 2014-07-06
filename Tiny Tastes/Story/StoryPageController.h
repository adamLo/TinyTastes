//
//  StoryPageController.h
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.05..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StoryPageViewController.h"

/**
 *  Custom UIViewController representing a page in the story book
 */
@interface StoryPageController : UIViewController

@property (nonatomic, weak) NSDictionary *pageData; /** Current page data from XML storybook */
@property (nonatomic, weak) StoryPageViewController *pageViewController; /** Parent controller */

/**
 *  Initialize a story page controller to create story subviews
 *
 *  @param storyPage  Dictionary that describes story page look
 */
- (void)loadStoryPage:(NSDictionary*)storyPage;

/**
 *  Toggle narration on/off
 *
 *  @param narrationOn Yes to turn on, NO to turn off
 */
- (void)toggleNarrationOn:(BOOL)narrationOn;

@end
