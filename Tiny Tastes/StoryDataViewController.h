//
//  StoryDataViewController.h
//  Tiny Tastes
//
//  Created by davile2 on 10/19/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "Scene.h"

@class StoryViewController;

@interface StoryDataViewController : UIViewController

@property (weak, nonatomic) Scene * dataObject;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UIButton *skipButton;
@property (weak, nonatomic) IBOutlet UIButton *narrationButton;

- (void) setStoryViewController:(StoryViewController *) controller;

@end