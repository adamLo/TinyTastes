//
//  Scene.m
//  Tiny Tastes
//
//  Created by davile2 on 10/20/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "Scene.h"

const NSString* kSceneLinkKeyID = @"id";
const NSString* kSceneLinkKeySegue = @"segue";

@implementation Scene
@synthesize sceneID, images, links, linkDestinations, sounds;

- (NSString*)description {
    return [NSString stringWithFormat:@"Scene [sceneId = %@, links=%@, likDestinations=%@, next=%d, end=%d, endStack=%d, animations=%@, nextSceneID=%@, hideSkip=%d]", sceneID, links, linkDestinations, self.next, self.end, self.endStack, self.animations, self.nextSceneID, self.hideSkip];
}

@end
