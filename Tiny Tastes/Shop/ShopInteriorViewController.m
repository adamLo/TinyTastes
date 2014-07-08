//
//  ShopInteriorViewController.m
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.07..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import "ShopInteriorViewController.h"
#import "ShopItemCell.h"

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
    
    //TODO: Replace this array with a proper implementation
    shopItems = @[@"accessory_shirt_white.xml", @"accessory_shirt_red.xml", @"accessory_shirt_blue.xml", @"accessory_shirt_orange.xml", @"accessory_shirt_pink.xml"];
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
}

- (void)viewDidDisappear:(BOOL)animated {
    //Reset status bar style
    [[UIApplication sharedApplication] setStatusBarStyle:statusbarStyle animated:NO];
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
    [cell setupItemWithXMLFile:[shopItems objectAtIndex:indexPath.row]];
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return collectionView.bounds.size;
}

#pragma mark - UICollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    //TODO: implement selection
}

@end
