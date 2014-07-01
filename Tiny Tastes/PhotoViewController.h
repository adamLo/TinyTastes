//
//  PhotoViewController.h
//  Tiny Tastes
//
//  Created by guest user on 10/8/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *instructionLabel;
@property (weak, nonatomic) IBOutlet UIButton *cameraIcon;
@property (weak, nonatomic) IBOutlet UILabel *customizeTimerLabel;
@property (weak, nonatomic) IBOutlet UILabel *mealOrSnackLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeDisplayLabel;
@property (weak, nonatomic) IBOutlet UIStepper *mealStepper;
@property (weak, nonatomic) IBOutlet UIButton *eatLabel;
@property (weak, nonatomic) IBOutlet UIButton *retakeLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *mealOrSnackControl;
@property (weak, nonatomic) IBOutlet UIImageView *thoughtBubble;
@property (weak, nonatomic) IBOutlet UILabel *cameraInstructionLabel;

- (IBAction)mealStepperValueChanged:(UIStepper *)sender;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)captureNow;
- (IBAction)homeButtonPressed:(id)sender; /** User pressed home button to go back to home screen */

@end
