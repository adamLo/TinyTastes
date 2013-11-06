//
//  XMLDelegate.m
//  Tiny Tastes
//
//  Created by davile2 on 10/20/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "XMLDelegate.h"

@implementation XMLDelegate
@synthesize currentScene, scenes;

- (XMLDelegate *) initXMLDelegate {
    self = [super init];
    scenes = [[NSMutableDictionary alloc] init];
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
        currentScene.text = [[NSMutableArray alloc] init];
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
    
    if ([elementName isEqualToString:@"text"]) {
        //NSLog(@"Adding text to scene...");
        CGRect currentImageRect = CGRectMake(120, 450, 800, 200);
        UILabel *text = [[UILabel alloc] initWithFrame:currentImageRect];
        text.text = (NSString *) [attributeDict objectForKey:@"string"];
        [text setNumberOfLines:4];
        [text setFont:[UIFont fontWithName:@"KBZipaDeeDooDah" size:45]];
        [currentScene.text addObject:text];
        //NSLog(@"Text is %@",currentScene.text);
    }
    
    if ([elementName isEqualToString:@"link"]) {
        //NSLog(@"Adding link to scene...");
        CGRect currentImageRect = CGRectMake([[attributeDict objectForKey:@"x"] floatValue], [[attributeDict objectForKey:@"y"] floatValue], [[attributeDict objectForKey:@"w"] floatValue], [[attributeDict objectForKey:@"h"] floatValue]);
        UIButton *currentLink = [[UIButton alloc] initWithFrame:currentImageRect];
        NSString *linkDestination = (NSString *) [attributeDict objectForKey:@"id"];
        [currentScene.links addObject:currentLink];
        [currentScene.linkDestinations addObject:linkDestination];
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"scene"]) {
        [scenes setObject:currentScene forKey:currentScene.sceneID];
        // release user object
        currentScene = nil;
    }
}


@end
