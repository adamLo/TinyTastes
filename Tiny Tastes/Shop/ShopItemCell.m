//
//  ShopItemCell.m
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.08..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import "ShopItemCell.h"
#import "XMLDictionary.h"

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
        [XMLDictionaryParser sharedInstance].attributesMode = XMLDictionaryAttributesModeUnprefixed;
        NSDictionary *itemData = [NSDictionary dictionaryWithXMLFile:path];
        
        UIImage *itemImage = [UIImage imageNamed:[itemData objectForKey:@"storeimage"]];
        self.itemImageView.image = itemImage;
        
    }
    else {
        NSLog(@"Missing xml file %@ for item", fileName);
    }
    
}

@end
