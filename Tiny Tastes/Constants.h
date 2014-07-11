//
//  Constants.h
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.09..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Holder class for various constants
 */
@interface Constants : NSObject

//User defaults keys
extern NSString* const TTDefaultsKeyPurseCoins; /** Key to purse coins in user defaults */

//Story Book and shop resource XML keys
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
extern NSString* const kStoryDictionaryKeyTag; /** Key to tag in story dictionary */
extern NSString* const kStoryDictionaryKeyAboveTag; /** Key to aboveTag in story dictionary */
extern NSString* const kStoryDictionaryKeyScenes; /** Key to scenes in story dictionary */

@end
