//
//  StoryPageViewController.h
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.05..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Reimplemented new Story Book main controller that displays the story book as a PageViewControler. Each page in the book is a single view controller.
 */
@interface StoryPageViewController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, retain) NSString *storyBookFileName; /** File name of story book to display. Opens bundled strorybook if empty */
@property (nonatomic, retain) NSArray *accessories; /** Array of accessory xml file names to display on story pages */

/**
 *  Go directly to scene with given id
 *
 *  @param sceneId Id of scene to go to
 */
- (void)gotoSceneWithID:(NSString*)sceneId;

@end
