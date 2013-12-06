//
//  TinyShopViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "TinyShopViewController.h"

@interface TinyShopViewController ()

@end

@implementation TinyShopViewController

@synthesize audioPlayer;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.view.backgroundColor = [UIColor colorWithRed:0.99 green:0.99 blue:0.83 alpha:1.0];
    NSString *path = [[NSBundle mainBundle]pathForResource:@"store_background_jingle" ofType:@"mp3"];
    audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL fileURLWithPath:path] error:NULL];
    [audioPlayer setVolume:0.5];
    [audioPlayer setNumberOfLoops: -1];
    [audioPlayer play];

    self.coinsNotifLabel.font = [UIFont fontWithName:@"KBZipaDeeDooDah" size:50];
    NSInteger myNumCoins = [[NSUserDefaults standardUserDefaults] integerForKey:@"coinsKey"];
    self.coinsNotifLabel.text = [NSString stringWithFormat:@"You have %d coins", myNumCoins];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    [audioPlayer stop];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
