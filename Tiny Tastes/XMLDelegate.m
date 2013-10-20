//
//  XMLDelegate.m
//  Tiny Tastes
//
//  Created by davile2 on 10/20/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "XMLDelegate.h"

@implementation XMLDelegate

- (XMLDelegate *) initXMLDelegate {
    self = [super init];
    return self;
}

- (void)parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
	
    NSLog(@"Called parse");
    
    if ([elementName isEqualToString:@"scene"]) {
        NSLog(@"user element found – create a new instance of Scene class...");
        Scene * scene = [[Scene alloc] init];
        scene.sceneID = [attributeDict objectForKey:@"id"];
        NSLog(@"SceneID is %@",scene.sceneID);
    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    NSLog(@"Processing value for : %@", string);
}

- (void)parser:(NSXMLParser *)parser
 didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName {
}


@end
