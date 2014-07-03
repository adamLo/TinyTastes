//
//  Scene.h
//  Tiny Tastes
//
//  Created by davile2 on 10/20/13.
//  Copyright (c) 2013 Le Labs. All rights reserved.
//

#import <Foundation/Foundation.h>

extern const NSString* kSceneLinkKeyID; /** Key to id in link dictionary in links */
extern const NSString* kSceneLinkKeySegue; /** Key to segue in link dictionary in links */

@interface Scene : NSObject {
    NSString *sceneID;
    NSMutableArray *images;
    NSMutableArray *links;
    NSMutableArray *sounds;
}

@property (nonatomic, retain) NSString *sceneID; /** ID of scene */
@property (nonatomic, retain) NSMutableArray *images; /** Images on scene */
@property (nonatomic, retain) NSMutableArray *links; /** Links on scene. Can either point to different scene with id or a segue on the storyboard */
@property (nonatomic, retain) NSMutableArray *linkDestinations; /** Contains dictionaries with either "id" or "segue" keys */
@property (nonatomic, retain) NSMutableArray *sounds; /** Sounds on scene */
@property (nonatomic, assign) BOOL titlePage; /** YES to indicate this is the cover page of the story book */
@property (nonatomic, assign) BOOL next; /** YES to indicate there's a scene next to it */
@property (nonatomic, assign) BOOL end; /** YES to end the story and go to eating screen when turning page */
@property (nonatomic, assign) BOOL hideSkip; /** YES to hide "skip to eat" button */
@property (nonatomic, retain) NSMutableArray *animations; /** Lopped andimations on the scene */
@property (nonatomic, assign) BOOL endStack; /** Indicate that this scene was the final in the stack */
@property (nonatomic, retain) NSString* nextSceneID; /** ID of next scene */

@end
