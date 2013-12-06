//
//  Scene.h
//  Tiny Tastes
//
//  Created by davile2 on 10/20/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Scene : NSObject {
    NSString *sceneID;
    NSMutableArray *images;
    NSMutableArray *links;
    NSMutableArray *sounds;
}

@property (nonatomic, retain) NSString *sceneID;
@property (nonatomic, retain) NSMutableArray *images;
@property (nonatomic, retain) NSMutableArray *links;
@property (nonatomic, retain) NSMutableArray *linkDestinations;
@property (nonatomic, retain) NSMutableArray *sounds;

@end
