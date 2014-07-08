//
//  ShopItemCell.h
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.08..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  Cell prototype for shop items
 */
@interface ShopItemCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *itemImageView; /** ImageView displaying item photo */
@property (weak, nonatomic) IBOutlet UILabel *itemDetailsLabel; /** Label to display item properties in formatted string */

/**
 *  Set up cell with item details in given xml file that will be read from bundle
 *
 *  @param fileName XML file name that gives accessory details
 */
- (void)setupItemWithXMLFile:(NSString*)fileName;

@end
