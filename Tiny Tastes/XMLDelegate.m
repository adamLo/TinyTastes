//
//  XMLDelegate.m
//  Tiny Tastes
//
//  Created by davile2 on 10/20/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "XMLDelegate.h"

@implementation XMLDelegate
@synthesize currentScene, sceneDictionary, audioPlayer, currentSceneArray;

- (XMLDelegate *) initXMLDelegate {
    self = [super init];
    if (self) {
        sceneDictionary = [[NSMutableDictionary alloc] init];
        currentSceneArray = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
	   
    if ([elementName isEqualToString:@"scene"]) {
        //NSLog(@"Creating a new instance of Scene class...");
        currentScene = [[Scene alloc] init];
        NSString *isTitle = (NSString *) [attributeDict objectForKey:@"title"];
        NSString *isEnding = (NSString *) [attributeDict objectForKey:@"end"];
        NSString *isEndStack = (NSString *) [attributeDict objectForKey:@"endstack"];
        NSString *hideSkip = (NSString *) [attributeDict objectForKey:@"hideskip"];
        if ([isTitle isEqualToString:@"true"]) {
            [currentScene setTitlePage:YES];
        }
        if ([isEnding isEqualToString:@"true"]) {
            [currentScene setEnd:YES];
        }
        if ([isEndStack isEqualToString:@"true"]) {
            [currentScene setEndStack:YES];
        }
        if ([hideSkip isEqualToString:@"true"]) {
            [currentScene setHideSkip:YES];
        }
        currentScene.images = [[NSMutableArray alloc] init];
        currentScene.links = [[NSMutableArray alloc] init];
        currentScene.linkDestinations = [[NSMutableArray alloc] init];
        currentScene.sounds = [[NSMutableArray alloc] init];
        currentScene.sceneID = [attributeDict objectForKey:@"id"];
        //NSLog(@"SceneID is %@",currentScene.sceneID);
    }
    
    if ([elementName isEqualToString:@"image"]) {
        //NSLog(@"Adding image to scene...");
        UIImageView *currentImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:([attributeDict objectForKey:@"path"])]];
        CGRect currentImageRect = CGRectMake([[attributeDict objectForKey:@"x"] floatValue], [[attributeDict objectForKey:@"y"] floatValue], [[attributeDict objectForKey:@"w"] floatValue], [[attributeDict objectForKey:@"h"] floatValue]);
        [currentImage setFrame:currentImageRect];
        [currentScene.images addObject: currentImage];
        //NSLog(@"Image is %d",currentScene.images.count);
    }
    
    if ([elementName isEqualToString:@"next"]) {
        [currentScene setNext:YES];
        currentScene.nextSceneID = [attributeDict objectForKey:@"id"];
    }
    
    if ([elementName isEqualToString:@"link"]) {
        //NSLog(@"Adding link to scene...");
        CGRect currentImageRect = CGRectMake([[attributeDict objectForKey:@"x"] floatValue], [[attributeDict objectForKey:@"y"] floatValue], [[attributeDict objectForKey:@"w"] floatValue], [[attributeDict objectForKey:@"h"] floatValue]);
        UIButton *currentLink = [[UIButton alloc] initWithFrame:currentImageRect];
        [currentScene.links addObject:currentLink];
        if ([attributeDict objectForKey:@"id"]) {
            NSString *linkDestination = (NSString *) [attributeDict objectForKey:@"id"];
            if (linkDestination) {
                [currentScene.linkDestinations addObject:@{kSceneLinkKeyID: linkDestination}];
            }
            else {
                NSLog(@"Link id is null in scene with id %@", currentScene.sceneID);
            }
        }
        else if ([attributeDict objectForKey:@"segue"]) {
            NSString* segue = (NSString*)[attributeDict objectForKey:@"segue"];
            if (segue) {
                [currentScene.linkDestinations addObject:@{kSceneLinkKeySegue: segue}];
            }
            else {
                NSLog(@"Link segue is null in scene with id %@", currentScene.sceneID);
            }
        }
        
    }
    
    if ([elementName isEqualToString:@"sound"]) {
        NSString *path = [[NSBundle mainBundle]pathForResource:([attributeDict objectForKey:@"path"]) ofType:([attributeDict objectForKey:@"type"])];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        [audioPlayer setVolume:0.5];
        [currentScene.sounds addObject:audioPlayer];
    }
    
    if ([elementName isEqualToString:@"animations"]) {
        if (!currentScene.animations) {
            currentScene.animations = [[NSMutableArray alloc] init];
        }
    }
    
    if ([elementName isEqualToString:@"animation"]) {
        //Create current animation pointer and copy attributes
        currentAnimation = [[UIImageView alloc] initWithFrame:CGRectMake([[attributeDict objectForKey:@"x"] floatValue], [[attributeDict objectForKey:@"y"] floatValue], [[attributeDict objectForKey:@"w"] floatValue], [[attributeDict objectForKey:@"h"] floatValue])];
        currentAnimation.animationDuration = [[attributeDict objectForKey:@"duration"] doubleValue];
        currentAnimation.animationRepeatCount = [[attributeDict objectForKey:@"repeat"] integerValue];
        
        //Add animation to array
        [currentScene.animations addObject:currentAnimation];
        
    }
    
    if ([elementName isEqualToString:@"animationphase"]) {
        //Add an animation phase to current animation sequence
        NSString *imageName = [attributeDict objectForKey:@"image"];
        if (imageName) {
            UIImage *image = [UIImage imageNamed:imageName];
            if (image) {
                //Valid image, make a mutable version of the images of animation and add current image
                NSMutableArray *images = [[NSMutableArray alloc] initWithArray:currentAnimation.animationImages];
                [images addObject:image];
                currentAnimation.animationImages = images;
            }
        }
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"scene"]) {
        [currentSceneArray addObject:currentScene];
        if ([currentScene endStack]) {
            [sceneDictionary setObject:currentSceneArray forKey:((Scene *)[currentSceneArray objectAtIndex:0]).sceneID];
            currentSceneArray = [[NSMutableArray alloc] init];
        }
        // release user object
        currentScene = nil;
    }
}


@end
