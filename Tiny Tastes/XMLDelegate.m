//
//  XMLDelegate.m
//  Tiny Tastes
//
//  Created by davile2 on 10/20/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "XMLDelegate.h"

@implementation XMLDelegate
@synthesize currentScene, scenes, audioPlayer;

- (XMLDelegate *) initXMLDelegate {
    self = [super init];
    scenes = [[NSMutableArray alloc] init];
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
    
    if ([elementName isEqualToString:@"link"]) {
        //NSLog(@"Adding link to scene...");
        CGRect currentImageRect = CGRectMake([[attributeDict objectForKey:@"x"] floatValue], [[attributeDict objectForKey:@"y"] floatValue], [[attributeDict objectForKey:@"w"] floatValue], [[attributeDict objectForKey:@"h"] floatValue]);
        UIButton *currentLink = [[UIButton alloc] initWithFrame:currentImageRect];
        NSString *linkDestination = (NSString *) [attributeDict objectForKey:@"id"];
        [currentScene.links addObject:currentLink];
        [currentScene.linkDestinations addObject:linkDestination];
    }
    
    if ([elementName isEqualToString:@"sound"]) {
        NSString *path = [[NSBundle mainBundle]pathForResource:([attributeDict objectForKey:@"path"]) ofType:([attributeDict objectForKey:@"type"])];
        audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
        [audioPlayer setVolume:0.5];
        [currentScene.sounds addObject:audioPlayer];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"scene"]) {
        [scenes addObject:currentScene];
        // release user object
        currentScene = nil;
    }
}


@end
