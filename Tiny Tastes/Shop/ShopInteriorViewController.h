//
//  ShopInteriorViewController.h
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.07..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Controller for shop interior. Handles carousel for selection.
 */
@interface ShopInteriorViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *leftArrowButton; /** Arrow button pointing left to turn carousel */
@property (weak, nonatomic) IBOutlet UIButton *rightArrowButton; /** Arrow button pointing right to turn carousel */

- (IBAction)backButtonPressed:(id)sender; /** User pressed back button to leave shop */
- (IBAction)leftArrowPressed:(id)sender; /** User pressed left arrow carousel button */
- (IBAction)rightArrowPressed:(id)sender; /** User pressed right arrow carousel button */

@end
