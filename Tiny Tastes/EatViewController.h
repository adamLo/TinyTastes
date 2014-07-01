//
//  EatViewController.h
//  Tiny Tastes
//
//  Created by Noelle Suaifan on 9/18/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface EatViewController : UIViewController {
}

@property (nonatomic, weak) IBOutlet UIImageView *redLine;
@property (nonatomic, weak) IBOutlet UIButton *doneButton;
@property (nonatomic, weak) IBOutlet UIButton *allFinishedButton;
@property (nonatomic, weak) IBOutlet UIButton *partiallyFinishedButton;
@property (nonatomic, weak) IBOutlet UIButton *notFinishedButton;
@property (nonatomic, weak) IBOutlet UIButton *pauseButton;
@property (nonatomic, weak) IBOutlet UIButton *resumeButton;
@property (nonatomic, weak) IBOutlet UILabel *countdownLabel;
@property (nonatomic, weak) IBOutlet UILabel *chooseLabel;
@property (nonatomic, weak) IBOutlet UILabel *timeLeftLabel;
@property (nonatomic, weak) IBOutlet UIImageView *foodImageView; /** ImageView holding photo food */
@property (nonatomic, weak) IBOutlet UIImageView *disappearingFood; /** Imageview displaying animation of disappearing food (appearing plate bottom */
@property (nonatomic, weak) IBOutlet UIImageView *eatingCritter; /** Eating Tiny aniumation */

@property (weak, nonatomic) UIImage *foodImage; /** Masked image of food taken by PhotoViewController */
@property int timeToEat; /** Time in seconds counting down for eating */

- (IBAction)homePressed:(id)sender; /** User pressed home button to go back to home screen */

@end
