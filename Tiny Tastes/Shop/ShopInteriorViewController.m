//
//  ShopInteriorViewController.m
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.07..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import "ShopInteriorViewController.h"
#import "ShopItemCell.h"
#import "Constants.h"
#import "XMLDictionary.h"
#import "UIFont+TinyTastes.h"

@interface ShopInteriorViewController () {
    UIStatusBarStyle statusbarStyle; //retain status bar style to reset when leaving shop
    NSArray *shopItems; //Array of XML file names for items in the shop
}

@end

@implementation ShopInteriorViewController

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
    // Do any additional setup after loading the view.
    
    //Set background
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"shop_interior_background"]]];
    
    //Localize labels
    self.purseLabel.text = NSLocalizedString(@"You have", @"Purse label on shop interior screen");
    
    //Set up buttons
    [self.purchaseConfirmationButton.titleLabel setFont:[UIFont ttFont35]];
    [self.purchaseConfirmationButton setTitle:NSLocalizedString(@"I want to buy it", @"Purchase confirmation button on shop screen") forState:UIControlStateNormal];
    
    [self.purchaseCancelButton.titleLabel setFont:[UIFont ttFont40]];
    [self.purchaseCancelButton setTitle:NSLocalizedString(@"No", @"Purchase cancel button on shop screen") forState:UIControlStateNormal];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    
    //Retain and change status bar style
    statusbarStyle = [[UIApplication sharedApplication] statusBarStyle];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
    
    //Hide purchase confirmation dialog
    self.purchaseConfirmationHolderView.hidden = YES;
    
    //Display purse contents
    [self displayPurseContents];
    
    //Load shop items
    [self loadShopItems];
}

- (void)viewDidDisappear:(BOOL)animated {
    //Reset status bar style
    [[UIApplication sharedApplication] setStatusBarStyle:statusbarStyle animated:NO];
}

#pragma mark - Load shop items

/**
 *  Loads shop items from xml file names into an array containing all item properties
 */
- (void)loadShopItems {
    
    // TODO: These should come from a persistent storage
    NSArray *xmlFiles = @[@"accessory_shirt_white.xml", @"accessory_shirt_red.xml", @"accessory_shirt_blue.xml", @"accessory_shirt_orange.xml", @"accessory_shirt_pink.xml", @"accessory_spoon_red.xml"];
    
    [XMLDictionaryParser sharedInstance].attributesMode = XMLDictionaryAttributesModeUnprefixed;
    //Load each item data
    NSMutableArray *tempItems = [[NSMutableArray alloc] init];
    for (NSString* fileName in xmlFiles) {
        NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
        if (path) {
            
            //Get item details
            NSDictionary *itemData = [NSDictionary dictionaryWithXMLFile:path];
            if (itemData) {
                [tempItems addObject:itemData];
            }
            else {
                NSLog(@"Dictionary could not be parsed from %@", path);
            }
        }
        else {
            NSLog(@"File not found: %@", fileName);
        }
    }
    shopItems = [NSArray arrayWithArray:tempItems];
    
    [self.collectionView reloadData];
}

#pragma mark - Purse

/**
 *  Display number of coins in the purse
 */
- (void)displayPurseContents {
    self.coinsNumberLabel.text = [NSString stringWithFormat:@"x %d", [[NSUserDefaults standardUserDefaults] integerForKey:TTDefaultsKeyPurseCoins]];
}

#pragma mark - Carousel

- (IBAction)leftArrowPressed:(id)sender {
    
    //Scroll to prior item if not already at first position
    NSIndexPath *currentIndexpath = [[self.collectionView indexPathsForVisibleItems] firstObject];
    if (currentIndexpath.row > 0) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndexpath.row-1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

- (IBAction)rightArrowPressed:(id)sender {
    
    //Scroll to next item if not already at last position
    NSIndexPath *currentIndexpath = [[self.collectionView indexPathsForVisibleItems] lastObject];
    if (currentIndexpath.row < shopItems.count-1) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:currentIndexpath.row+1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:YES];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

- (IBAction)backButtonPressed:(id)sender {
    //Go back
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UICollectionView datasource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return shopItems.count;
}

- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //Dequeue cell
    ShopItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"shopItemCell" forIndexPath:indexPath];
    
    //Setup cell
    [cell setupItemWithDictionary:[shopItems objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    //Show confirmation dialog
    [self togglePurchaseDialogVisible:YES completion:nil];
    
}

#pragma mark - Purchase

/**
 *  Toggle purchase confirmation dialog visiblity
 *
 *  @param visible         YES to show NO to hide
 *  @param completionBlock Block to execute when animation finished
 */
- (void)togglePurchaseDialogVisible:(BOOL)visible completion:(void (^)())completionBlock {
    
    if (visible) {
        self.purchaseConfirmationHolderView.alpha = 0.0;
        self.purchaseConfirmationHolderView.hidden = NO;
    }
    
    [UIView animateWithDuration:0.4 animations:^{
        self.purchaseConfirmationHolderView.alpha = visible ? 1.0 : 0;
    } completion:^(BOOL finished) {
        if (!visible) {
            self.purchaseConfirmationHolderView.hidden = YES;
            self.purchaseConfirmationHolderView.alpha = 1.0;
        }
        
        //Execute completion block
        if (completionBlock) {
            completionBlock();
        }
    }];
    
}

- (IBAction)purchaseConfirmationPressed:(id)sender {
    // TODO: Make purchase
    
    [self togglePurchaseDialogVisible:NO completion:^{
        // TODO: implement actual purchase transaction
        NSDictionary *item = [shopItems objectAtIndex:[[[self.collectionView indexPathsForSelectedItems] firstObject] row]];
        NSLog(@"Selected item: %@", item);
    }];
}

- (IBAction)purchaseCancelPressed:(id)sender {
    
    //Hide purchase confirmation dialog
    [self togglePurchaseDialogVisible:NO completion:nil];
}

@end
