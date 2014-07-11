//
//  UIView+TTAnimation.h
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.11..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Helper category to add animations from XML-read dictionary
 */
@interface UIView (TTAnimation)

/**
 *  Find already added imageview with given tag for layering
 *
 *  @param tag Tag of needed imageView
 *
 *  @return ImageView or nothing
 */
- (UIImageView*)imageViewWithTag:(NSInteger)tag;

/**
 *  Construct an imageview from dictionary. Add animation if there's any
 *
 *  @param imageDict Dictionary describing image
 *  @param sequence Sequence order in processing. Will be added as tag if tag property not set
 *
 *  @return Imageview
 */
- (UIImageView*)addImageViewFromDictionary:(NSDictionary*)imageDict sequence:(NSInteger)sequence;

@end
