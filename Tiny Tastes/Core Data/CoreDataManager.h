//
//  CoreDataManager.h
//  emu
//
//  Created by Adam Lovastyik on 2013.09.01..
//  Copyright (c) 2013 Tinker Square, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 Manager helper class for CoreData
 */
@interface CoreDataManager : NSObject

@property (nonatomic, strong) NSManagedObjectContext* managedObjectContext; /** Default managed object context for main thread*/
@property (readonly, nonatomic, strong) NSManagedObjectModel* managedObjectModel; /** CD Model */
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator* persistentStoreCoordinator; /** Persistence coordinator to handle CD access through threads. */

/**
 Returns/creates shared instance for singleton object
 @return Shared instance
 */
+ (instancetype) sharedInstance;

/**
 Creates a new ManagedObjectContext thread-safely.  !!! This is for temporary contexts, if later we need long-term use of contexts take care like here: http://stackoverflow.com/questions/3474960/generic-approach-to-nsmanagedobjectcontext-in-multi-threaded-application
 @return ManagedObjectContext
 */
- (NSManagedObjectContext*)createNewManagedObjectContext;

/**
    Using private methods of CoreDataManager this public method is used for cleaning the database and creating a brand new and empty one. This is used for testing purposes, namely first cleaning the databes then pre-persisting location share test data. For more info please check the EMAppDelegate's persistTestDataForLocationShareTestWithOptions: method as well.
 */
- (void)recreateDatabase;

@end
