//
//  HomeViewController.m
//  Tiny Tastes
//
//  Created by davile2 on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "HomeViewController.h"
#import <UIKit/UIKit.h>

@interface HomeViewController ()

@end

@implementation HomeViewController

@synthesize audioPlayer;

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImage *image = [UIImage imageNamed:@"menu_page.jpg"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:image];
    
    storyModeLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    letsEatLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    letsDrinkLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    tinyShopLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    settingsLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    
    [storyModeLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [letsEatLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [letsDrinkLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [tinyShopLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [settingsLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    NSString *path = [[NSBundle mainBundle]pathForResource:@"main_menu_music" ofType:@"mp3"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    
    //Set up Tiny character animation
    self.animatedTiny.animationImages = @[[UIImage imageNamed:@"home_tiny_0"], [UIImage imageNamed:@"home_tiny_1"], [UIImage imageNamed:@"home_tiny_2"], [UIImage imageNamed:@"home_tiny_3"], [UIImage imageNamed:@"home_tiny_4"], [UIImage imageNamed:@"home_tiny_5"], [UIImage imageNamed:@"home_tiny_6"], [UIImage imageNamed:@"home_tiny_5"], [UIImage imageNamed:@"home_tiny_4"], [UIImage imageNamed:@"home_tiny_3"], [UIImage imageNamed:@"home_tiny_2"], [UIImage imageNamed:@"home_tiny_1"]];
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
