//
//  SceneFactory.m
//  Tiny Tastes
//
//  Created by davile2 on 10/20/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "SceneFactory.h"

@implementation SceneFactory

- (SceneFactory *)init {
    self = [super init];
    if (self) {
        NSString *xmlPath = [[NSBundle mainBundle] pathForResource:@"story" ofType:@"xml"];
        NSData *xmlData = [[NSMutableData alloc] initWithContentsOfFile:xmlPath];
        nsXmlParser = [[NSXMLParser alloc] initWithData: xmlData ];
        xmlDelegate = [[XMLDelegate alloc] initXMLDelegate];
        [nsXmlParser setDelegate:xmlDelegate];
    
        sceneDictionary = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (NSMutableDictionary *)populateScenes {
    [nsXmlParser parse];
    sceneDictionary = xmlDelegate.sceneDictionary;
    return sceneDictionary;
}

- (void)dealloc {
    sceneDictionary = nil;
}

@end
