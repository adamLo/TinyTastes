//
//  EatViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EatViewController : UIViewController {
    IBOutlet UILabel *countdownLabel;
    IBOutlet UILabel *chooseLabel;
    IBOutlet UILabel *timeLeftLabel;

    NSTimer *countdownTimer;
    int secondsCount;
    bool blinkStatus;
    
    IBOutlet UIImageView *eatingCritter;
    IBOutlet UIImageView *foodImageView;
    IBOutlet UIImageView *disappearingFood;
    IBOutlet UIImageView *redLine;
    
    IBOutlet UIButton *doneButton;
    IBOutlet UIButton *allFinishedButton;
    IBOutlet UIButton *partiallyFinishedButton;
    IBOutlet UIButton *notFinishedButton;
}

@property (weak, nonatomic) IBOutlet UIImage *foodImage;
@property int timeToEat;

@end
