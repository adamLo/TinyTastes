//
//  StoryPageViewController.h
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.05..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString* const kStoryDictionaryKeyScene; /** Key to scenes in story dictionary */
extern NSString* const kStoryDictionaryKeyImage; /** Key to images in story dictionary */
extern NSString* const kStoryDictionaryKeyX; /** Key to X in story dictionary */
extern NSString* const kStoryDictionaryKeyY; /** Key to Y in story dictionary */
extern NSString* const kStoryDictionaryKeyW; /** Key to W in story dictionary */
extern NSString* const kStoryDictionaryKeyH; /** Key to H in story dictionary */
extern NSString* const kStoryDictionaryKeyPath; /** Key to path in story dictionary */
extern NSString* const kStoryDictionaryKeyID; /** Key to ID in story dictionary */
extern NSString* const kStoryDictionaryKeyNext; /** Key to next in story dictionary */
extern NSString* const kStoryDictionaryKeyLink; /** Key to link in story dictionary */
extern NSString* const kStoryDictionaryKeySound; /** Key to sound in story dictionary */
extern NSString* const kStoryDictionaryKeyType; /** Key to type in story dictionary */
extern NSString* const kStoryDictionaryKeyAnimation; /** Key to animation in story dictionary */
extern NSString* const kStoryDictionaryKeyDuration; /** Key to duration in story dictionary */
extern NSString* const kStoryDictionaryKeyRepeat; /** Key to repeat in story dictionary */
extern NSString* const kStoryDictionaryKeySegue; /** Key to segue in story dictionary */
extern NSString* const kStoryDictionaryKeyTitle; /** Key to title in story dictionary */
extern NSString* const kStoryDictionaryKeyPrev; /** Key to prev in story dictionary */
extern NSString* const kStoryDictionaryKeyHideSkip; /** Key to hideskip in story dictionary */

/**
 *  Reimplemented new Story Book main controller that displays the story book as a PageViewControler. Each page in the book is a single view controller.
 */
@interface StoryPageViewController : UIPageViewController <UIPageViewControllerDataSource, UIPageViewControllerDelegate>

@property (nonatomic, retain) NSString *storyBookFileName; /** File name of story book to display. Opens bundled strorybook if empty */

/**
 *  Go directly to scene with given id
 *
 *  @param sceneId Id of scene to go to
 */
- (void)gotoSceneWithID:(NSString*)sceneId;

@end
