//
//  StoryDataViewController.m
//  Tiny Tastes
//
//  Created by davile2 on 10/19/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "StoryDataViewController.h"
#import "StoryViewController.h"

@interface StoryDataViewController ()
@property (weak, nonatomic) StoryViewController *viewController;
@property (nonatomic, assign) BOOL loaded;
@end

@implementation StoryDataViewController
@synthesize viewController = _viewController;
@synthesize loaded = _loaded;
@synthesize backButton = _backButton;
@synthesize skipButton = _skipButton;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setLoaded:YES];
    self.view.backgroundColor = [UIColor colorWithRed:0.33 green:0.32 blue:0.32 alpha:1.0];
    _loaded = [self loaded];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    self.view.backgroundColor = [UIColor colorWithRed:0.33 green:0.32 blue:0.32 alpha:1.0];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    for (UIImageView *image in self.dataObject.images) {
        [self.view addSubview:image];
    }
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"storyNarration"] == YES) {
        for (AVAudioPlayer *audioPlayer in self.dataObject.sounds) {
            [audioPlayer play];
        }
    }
    //Buttons to change story screen
    /*
    NSInteger tagCount = 0;
    for (UIButton *button in self.dataObject.links) {
        [button addTarget:self action:@selector(changeViewController:) forControlEvents:UIControlEventTouchUpInside];
        [button setTag:tagCount];
        [self.view addSubview:button];
        tagCount++;
    }
    */
    [self.view bringSubviewToFront:_backButton];
    [self.view bringSubviewToFront:_skipButton];
}

- (void)viewWillDisappear:(BOOL)animated
{
    for (AVAudioPlayer *audioPlayer in self.dataObject.sounds) {
        [audioPlayer stop];
    }
}

- (void) changeViewController:(UIButton*)button
{
    if(_loaded) {
        //NSInteger buttonId = [button tag];
        //[_viewController changeViewController:[self.dataObject.linkDestinations objectAtIndex:buttonId]];
    }
}

- (void) addButtons:(id) vc
{
    StoryViewController *vcontroller = (StoryViewController *) vc;
    _viewController = vcontroller;
}

@end