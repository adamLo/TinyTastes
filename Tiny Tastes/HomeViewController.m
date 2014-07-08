//
//  HomeViewController.m
//  Tiny Tastes
//
//  Created by davile2 on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "HomeViewController.h"
#import <UIKit/UIKit.h>
#import "UIFont+TinyTastes.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize audioPlayer;

- (void)viewDidLoad
{
    [super viewDidLoad];

    //Set background
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"homescreen_bg"]];
    
    //Localize button captions
    [self.tinyShopButton setTitle:NSLocalizedString(@"Tiny shop", @"Tiny shop button title on home screen") forState:UIControlStateNormal];
    [self.letsEatButton setTitle:NSLocalizedString(@"Let's eat!", @"Eat button title on home screen") forState:UIControlStateNormal];
    [self.letsDrinkButton setTitle:NSLocalizedString(@"Let's drink", @"Drink button title on home screen") forState:UIControlStateNormal];
    [self.storyModeButton setTitle:NSLocalizedString(@"STORY TIME", @"Story button title on home screen") forState:UIControlStateNormal];
    [self.settingsButton setTitle:NSLocalizedString(@"Settings", @"Settings button title on home screen") forState:UIControlStateNormal];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"main_menu_music" ofType:@"mp3"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    
    //Set up Tiny character animation
    self.animatedTiny.animationImages = @[[UIImage imageNamed:@"home_tiny_00"], [UIImage imageNamed:@"home_tiny_01"], [UIImage imageNamed:@"home_tiny_02"], [UIImage imageNamed:@"home_tiny_03"], [UIImage imageNamed:@"home_tiny_04"], [UIImage imageNamed:@"home_tiny_05"], [UIImage imageNamed:@"home_tiny_04"], [UIImage imageNamed:@"home_tiny_03"], [UIImage imageNamed:@"home_tiny_02"], [UIImage imageNamed:@"home_tiny_01"]];
    self.animatedTiny.animationRepeatCount = 0;
    self.animatedTiny.animationDuration = 1.5;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"backgroundSound"] == YES) {
        [audioPlayer setVolume:0.5];
        [audioPlayer setNumberOfLoops: -1];
        [audioPlayer play];
    }
    
    //Start animations
    [self.animatedTiny startAnimating];
}

- (void)viewWillDisappear:(BOOL)animated {
    if ([audioPlayer isPlaying]) {
        [audioPlayer stop];
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    
    //Stop animations
    [self.animatedTiny stopAnimating];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    return (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft
            || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight);
}

@end
