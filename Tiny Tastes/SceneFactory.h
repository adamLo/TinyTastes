//
//  SceneFactory.h
//  Tiny Tastes
//
//  Created by davile2 on 10/20/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scene.h"
#import "XMLDelegate.h"

@interface SceneFactory : NSObject {
    NSXMLParser *nsXmlParser;
    XMLDelegate *xmlDelegate;
    NSMutableArray *sceneArray;
}

-(SceneFactory *) init;
-(NSMutableArray *) populateScenes;
@end
