//
//  CDPurchasedItem.h
//  Tiny Tastes
//
//  Created by Adam Lovastyik on 2014.07.09..
//  Copyright (c) 2014 Le Labs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface CDPurchasedItem : NSManagedObject

@property (nonatomic, retain) NSString * itemId;
@property (nonatomic, retain) NSString * xmlFilename;
@property (nonatomic, retain) NSDate * purchaseDate;
@property (nonatomic, retain) NSString * itemType;

@end
