//
//  ShopInteriorViewController.h
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.07..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Controller for shop interior. Handles carousel for selection with a collection view.
 */
@interface ShopInteriorViewController : UIViewController <UICollectionViewDataSource, UICollectionViewDelegate>

//Shop items carousel
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView; /** Collectionview displaying shop items as a carousel */
@property (weak, nonatomic) IBOutlet UIButton *leftArrowButton; /** Arrow button pointing left to turn carousel */
@property (weak, nonatomic) IBOutlet UIButton *rightArrowButton; /** Arrow button pointing right to turn carousel */

//Purse
@property (weak, nonatomic) IBOutlet UILabel *purseLabel; /** Static label indicating purse. Should be localized */
@property (weak, nonatomic) IBOutlet UILabel *coinsNumberLabel; /** Label displaying how much coins user has in his purse */

//Purchase
@property (weak, nonatomic) IBOutlet UIView *purchaseConfirmationHolderView; /** Holder view for purchase confirmation dialog */
@property (weak, nonatomic) IBOutlet UILabel *purchaseQuestionLabel; /** Static label at top for localized purchase question */
@property (weak, nonatomic) IBOutlet UIButton *purchaseConfirmationButton; /** Confirmation button on purchase dialog */
@property (weak, nonatomic) IBOutlet UIButton *purchaseCancelButton; /** Cancel button on purchase dialog */

//Actions
- (IBAction)backButtonPressed:(id)sender; /** User pressed back button to leave shop */
- (IBAction)leftArrowPressed:(id)sender; /** User pressed left arrow carousel button */
- (IBAction)rightArrowPressed:(id)sender; /** User pressed right arrow carousel button */
- (IBAction)purchaseConfirmationPressed:(id)sender; /** User pressed condirmation button on purchase dialog to buy selected item */
- (IBAction)purchaseCancelPressed:(id)sender; /** User pressed cancel button on purchase button to go back item browsing */

@end
