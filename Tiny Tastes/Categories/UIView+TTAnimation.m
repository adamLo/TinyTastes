//
//  UIView+TTAnimation.m
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.11..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import "UIView+TTAnimation.h"
#import "Constants.h"

@implementation UIView (TTAnimation)

- (UIImageView*)imageViewWithTag:(NSInteger)tag {
    for (id subview in self.subviews) {
        if ([subview isKindOfClass:[UIImageView class]] && ([(UIImageView*)subview tag] == tag)) {
            return subview;
        }
    }
    
    return nil;
}

- (UIImageView*)addImageViewFromDictionary:(NSDictionary*)imageDict sequence:(NSInteger)sequence {
    
    //Construct imageview
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake([[imageDict objectForKey:kStoryDictionaryKeyX] floatValue], [[imageDict objectForKey:kStoryDictionaryKeyY]floatValue], [[imageDict objectForKey:kStoryDictionaryKeyW] floatValue], [[imageDict objectForKey:kStoryDictionaryKeyH] floatValue])];
    
    //Add image if exists
    if ([imageDict objectForKey:kStoryDictionaryKeyPath]) {
        imageView.image = [UIImage imageNamed:[imageDict objectForKey:kStoryDictionaryKeyPath]];
    }
    
    //Set tag, this will help layering
    imageView.tag = ([imageDict objectForKey:kStoryDictionaryKeyTag] != nil) ? [[imageDict objectForKey:kStoryDictionaryKeyTag] integerValue] : sequence;
    
    //Add animations if there are
    if ([[imageDict objectForKey:kStoryDictionaryKeyAnimation] isKindOfClass:[NSArray class]]) {
        //We have animation images
        
        //Add animation phase images
        NSMutableArray *animationImages = [[NSMutableArray alloc] init];
        for (NSString *imgName in [imageDict objectForKey:kStoryDictionaryKeyAnimation]) {
            UIImage *image = [UIImage imageNamed:imgName];
            if (image) {
                [animationImages addObject:image];
            }
        }
        imageView.animationImages = [NSArray arrayWithArray:animationImages];
        
        //Set animation properties
        imageView.animationDuration = [[imageDict objectForKey:kStoryDictionaryKeyDuration] floatValue];
        imageView.animationRepeatCount = [[imageDict objectForKey:kStoryDictionaryKeyRepeat] integerValue];
        
        //set first image if not set
        if (!imageView.image) {
            imageView.image = [imageView.animationImages firstObject];
        }
    }
    
    if ([imageDict objectForKey:kStoryDictionaryKeyAboveTag]) {
        NSInteger tag = [[imageDict objectForKey:kStoryDictionaryKeyAboveTag] integerValue];
        UIImageView *imageViewBelow = [self imageViewWithTag:tag];
        if (imageViewBelow) {
            [self insertSubview:imageView aboveSubview:imageViewBelow];
        }
        else {
            NSLog(@"Not found imageview with tag %d", tag);
        }
    }
    else {
        [self addSubview:imageView];
    }
    
    return imageView;
    
}

@end
