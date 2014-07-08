//
//  ShopItemCell.m
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.08..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import "ShopItemCell.h"
#import "XMLDictionary.h"
#import "UIFont+TinyTastes.h"
#import "UIImage+Resize.h"

@implementation ShopItemCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setupItemWithXMLFile:(NSString *)fileName{
    
    //Load and parse story book
    NSString *path = [[NSBundle mainBundle] pathForResource:fileName ofType:nil];
    if (path) {
        
        //Get item details
        [XMLDictionaryParser sharedInstance].attributesMode = XMLDictionaryAttributesModeUnprefixed;
        NSDictionary *itemData = [NSDictionary dictionaryWithXMLFile:path];
        
        //Set item image
        UIImage *itemImage = [UIImage imageNamed:[itemData objectForKey:@"storeimage"]];
        self.itemImageView.image = itemImage;
        
        //Set up description
        NSMutableAttributedString *itemDescription = [[NSMutableAttributedString alloc] initWithAttributedString:[[NSAttributedString alloc] initWithString:[itemData objectForKey:@"description"] attributes:@{NSFontAttributeName: [UIFont ttFont30]}]];
        [itemDescription appendAttributedString:[[NSAttributedString alloc] initWithString:@"\n"]];
        //Add price
        [itemDescription appendAttributedString:[[NSAttributedString alloc] initWithString:NSLocalizedString(@"Price: ", @"Price title on shop item description") attributes:@{NSFontAttributeName: [UIFont ttFont20]}]];
        
        UIImage *coinImage = [[UIImage imageNamed:@"coin"] resizedImage:CGSizeMake(30, 28) interpolationQuality:kCGInterpolationHigh];
        for (int coins = 0; coins < round([[itemData objectForKey:@"price"] doubleValue]); coins++) {
            NSTextAttachment *coin = [[NSTextAttachment alloc] init];
            coin.image = coinImage;
            coin.bounds = CGRectMake(0, -8, 30, 28);
            [itemDescription appendAttributedString:[NSAttributedString attributedStringWithAttachment:coin]];
            [itemDescription appendAttributedString:[[NSAttributedString alloc] initWithString:@" "]];
        }
                                                                                                                                                                               
        //Set description
        self.itemDetailsLabel.attributedText = itemDescription;
        CGRect descFrame = self.itemDetailsLabel.frame;
        descFrame.size.height = [itemDescription boundingRectWithSize:CGSizeMake(descFrame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        self.itemDetailsLabel.frame = descFrame;
                                                                                                                                                                               
    }
    else {
        NSLog(@"Missing xml file %@ for item", fileName);
    }
    
}

@end
