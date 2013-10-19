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
    NSTimer *countdownTimer;
    int secondsCount;
    IBOutlet UIImageView *eatingCritter;
    
    IBOutlet UIImageView *doneButtonImage;
    IBOutlet UIImageView *allFinishedButtonImage;
    IBOutlet UIImageView *partiallyFinishedButtonImage;
    IBOutlet UIImageView *notFinishedButtonImage;
    
    IBOutlet UIButton *doneButton;
    IBOutlet UIButton *allFinishedButton;
    IBOutlet UIButton *partiallyFinishedButton;
    IBOutlet UIButton *notFinishedButton;
}

@end
