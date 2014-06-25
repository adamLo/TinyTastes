//
//  PhotoViewController.h
//  Tiny Tastes
//
//  Created by guest user on 10/8/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    
    UIImage *chosenImage;
    IBOutlet UILabel *customizeTimerLabel;
    IBOutlet UILabel *mealOrSnackLabel;
    IBOutlet UILabel *timeDisplayLabel;
    IBOutlet UIStepper *mealStepper;
    IBOutlet UIButton *eatLabel;
    IBOutlet UIButton *retakeLabel;
    IBOutlet UISegmentedControl *mealOrSnackControl;
    IBOutlet UIImageView *thoughtBubble;
    IBOutlet UILabel *cameraInstructionLabel;
}

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) IBOutlet UIButton *instructionLabel;
@property (strong, nonatomic) IBOutlet UIButton *cameraIcon;

- (IBAction)mealStepperValueChanged:(UIStepper *)sender;
- (IBAction)takePhoto:(UIButton *)sender;
- (IBAction)captureNow;
- (IBAction)homeButtonPressed:(id)sender; /** User pressed home button to go back to home screen */

@end
