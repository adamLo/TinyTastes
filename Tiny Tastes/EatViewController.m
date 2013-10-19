//
//  EatViewController.m
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import "EatViewController.h"

@interface EatViewController ()

@end

@implementation EatViewController

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
    allFinishedButton.hidden = YES;
    allFinishedButtonImage.alpha = 0;
    partiallyFinishedButton.hidden = YES;
    partiallyFinishedButtonImage.alpha = 0;
    notFinishedButton.hidden = YES;
    notFinishedButtonImage.alpha = 0;
    
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"frame.jpg"]];
 
    eatingCritter.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"eating_critter_1.jpg"],
                                     [UIImage imageNamed:@"eating_critter_2.jpg"], nil];
    eatingCritter.animationDuration = 1;
    [self.view addSubview:eatingCritter];
    [eatingCritter startAnimating];
    
    [self setTimer];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)timerRun {
    secondsCount = secondsCount - 1;
    int minutes = secondsCount / 60;
    int seconds = secondsCount - (minutes * 60);
    
    NSString *timerOutput = [NSString stringWithFormat:@"%2d:%.2d", minutes, seconds];
    countdownLabel.text = timerOutput;
    
    if (secondsCount == 0) {
        [countdownTimer invalidate];
        countdownTimer = nil;
        [self doneButtonClicked];
    }
    
}
- (void)setTimer {
    secondsCount = 100;
    countdownTimer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(timerRun) userInfo:nil repeats: YES];
}

- (IBAction)doneButtonClicked {
    [countdownTimer invalidate];
    countdownTimer = nil;
    allFinishedButton.hidden = NO;
    partiallyFinishedButton.hidden = NO;
    notFinishedButton.hidden = NO;
    doneButton.hidden = 0;
    allFinishedButtonImage.alpha = 1;
    partiallyFinishedButtonImage.alpha = 1;
    notFinishedButtonImage.alpha = 1;
    doneButtonImage.alpha = 0;
}

@end
