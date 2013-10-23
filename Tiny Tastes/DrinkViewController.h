//
//  DrinkViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrinkViewController : UIViewController {
    IBOutlet UILabel *countdownLabel;
    IBOutlet UILabel *backLabel;
    IBOutlet UILabel *chooseLabel;

    NSTimer *countdownTimer;
    int secondsCount;
    bool blinkStatus;

    IBOutlet UIImageView *drinkingCritter;
    IBOutlet UIImageView *redLine;

    IBOutlet UIButton *doneButton;
    IBOutlet UIButton *allFinishedButton;
    IBOutlet UIButton *partiallyFinishedButton;
    IBOutlet UIButton *notFinishedButton;
}

@end