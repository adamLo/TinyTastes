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
    
    self.storyModeLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.letsEatLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.letsDrinkLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.tinyShopLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    self.settingsLabel.titleLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    
    [self.storyModeLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.letsEatLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.letsDrinkLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.tinyShopLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [self.settingsLabel setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
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
