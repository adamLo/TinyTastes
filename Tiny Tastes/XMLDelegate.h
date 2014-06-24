//
//  XMLDelegate.h
//  Tiny Tastes
//
//  Created by davile2 on 10/20/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "Scene.h"

@interface XMLDelegate : NSObject <NSXMLParserDelegate> {
    Scene * currentScene;
    NSMutableArray * currentSceneArray;
    NSMutableDictionary * sceneDictionary;
    UIImageView *currentAnimation;
}

@property (nonatomic, retain) NSMutableDictionary *sceneDictionary;
@property (nonatomic, retain) Scene *currentScene;
@property (nonatomic, retain) NSMutableArray *currentSceneArray;
@property (strong, nonatomic) AVAudioPlayer *audioPlayer;

- (XMLDelegate *) initXMLDelegate;

@end
