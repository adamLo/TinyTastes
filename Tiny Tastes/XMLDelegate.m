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
        currentScene.sceneID = [attributeDict objectForKey:@"id"];
        //NSLog(@"SceneID is %@",currentScene.sceneID);
    }
    
    if ([elementName isEqualToString:@"image"]) {
        //NSLog(@"Adding image to scene...");
        [currentScene.images addObject:[UIImage imageNamed:([attributeDict objectForKey:@"path"])]];
        //NSLog(@"Image is %d",currentScene.images.count);
    }
    
    if ([elementName isEqualToString:@"text"]) {
        //NSLog(@"Adding text to scene...");
        currentScene.text = [attributeDict objectForKey:@"string"];
        //NSLog(@"Text is %@",currentScene.text);
    }
    
    if ([elementName isEqualToString:@"link"]) {
        //NSLog(@"Adding link to scene...");
        [currentScene.links addObject:[attributeDict objectForKey:@"id"]];
        //NSLog(@"Link is %@",currentScene.links.lastObject);
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
