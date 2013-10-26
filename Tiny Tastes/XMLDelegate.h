//
//  XMLDelegate.h
//  Tiny Tastes
//
//  Created by davile2 on 10/20/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Scene.h"

@interface XMLDelegate : NSObject <NSXMLParserDelegate> {
    Scene * currentScene;
    NSMutableArray * scenes;
}

@property (nonatomic, retain) NSMutableArray *scenes;
@property (nonatomic, retain) Scene *currentScene;

- (XMLDelegate *) initXMLDelegate;

@end
