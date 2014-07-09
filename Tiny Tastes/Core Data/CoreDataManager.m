//
//  CoreDataManager.m
//  emu
//
//  Created by Adam Lovastyik on 2013.09.01..
//  Copyright (c) 2013 Tinker Square, Inc. All rights reserved.
//

#import "CoreDataManager.h"
#import "HomeAppDelegate.h"
#import <CoreData/CoreData.h>

@interface CoreDataManager () {
    
}

- (BOOL)cleanDatabase:(NSError*)error;
- (BOOL)createDatabase:(NSError*)error;

@end

@implementation CoreDataManager

@synthesize managedObjectModel = _managedObjectModel;
@synthesize managedObjectContext = _managedObjectContext;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

#define SQLITE_DB_NAME @"TinyTastes.sqlite"

#pragma mark - private methods

- (BOOL)cleanDatabase:(NSError *)error {
    NSURL *storeURL = [[(HomeAppDelegate*)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory] URLByAppendingPathComponent:SQLITE_DB_NAME];
    
    NSPersistentStoreCoordinator* coordinator = [self persistentStoreCoordinator];
    BOOL resultForStoreRemove = NO;
    BOOL resultForFileRemove = NO;
    
    if ([[coordinator persistentStores] count] > 0) {
        resultForStoreRemove = [coordinator removePersistentStore:[[coordinator persistentStores] objectAtIndex:0] error:&error];
    }
    
    resultForFileRemove = [[NSFileManager defaultManager] removeItemAtPath:storeURL.path error:&error];
    
    return resultForFileRemove && resultForStoreRemove;
}


- (BOOL)createDatabase:(NSError*)error {
    NSURL *storeURL = [[(HomeAppDelegate*)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory] URLByAppendingPathComponent:SQLITE_DB_NAME];
    
    
    NSPersistentStoreCoordinator* coordinator = [self persistentStoreCoordinator];
    
    NSDictionary *options = @{
                              NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption : @YES
                              };
    
    
    NSPersistentStore* newStore = [coordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error];
    
    
    if (!newStore) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
    }
    
    return newStore != nil;
    
}



#pragma mark - instantiation
+ (instancetype) sharedInstance {
    
    static dispatch_once_t once;
    static id sharedInstance;
    
    dispatch_once(&once, ^{
        sharedInstance = [[self alloc] init];
    });
    
    return sharedInstance;
    
}

#pragma mark -
- (NSManagedObjectContext*) managedObjectContext {
    @synchronized(self) {
        if (!_managedObjectContext) {
            NSPersistentStoreCoordinator* coordinator = [self persistentStoreCoordinator];
            if (coordinator != nil) {
                _managedObjectContext = [[NSManagedObjectContext alloc] init];
                [_managedObjectContext setPersistentStoreCoordinator:coordinator];
            }
            
            //TODO: Change merge policy on main thread managedObjectContext if concurrency issues happen.
            //[_managedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicyType]; //See more here: http://stackoverflow.com/a/8152401
            
            //Add notification for context save to merge
            [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mergeChanges:) name:NSManagedObjectContextDidSaveNotification object:_managedObjectContext];
        }
    }
    
    return _managedObjectContext;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    // Returns the persistent store coordinator for the application.
    // If the coordinator doesn't already exist, it is created and the application's store added to it.
    @synchronized(self) {
        if (!_persistentStoreCoordinator) {
    
            NSURL *storeURL = [[(HomeAppDelegate*)[[UIApplication sharedApplication] delegate] applicationDocumentsDirectory] URLByAppendingPathComponent:SQLITE_DB_NAME];
    
            NSError *error = nil;
            _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
            NSDictionary *options = @{
                              NSMigratePersistentStoresAutomaticallyOption : @YES,
                              NSInferMappingModelAutomaticallyOption : @YES
                              };
    
            if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter:
         @{NSMigratePersistentStoresAutomaticallyOption:@YES, NSInferMappingModelAutomaticallyOption:@YES}
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
                
                NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        
                //TODO: remove this from production code
#warning Remove it in production
                abort();
        
                return nil;
            }
        }
    }
    
    return _persistentStoreCoordinator;
}

- (NSManagedObjectContext*)createNewManagedObjectContext {
    
    NSManagedObjectContext* MOC = [[NSManagedObjectContext alloc] init];
    [MOC setUndoManager:nil];
    [MOC setPersistentStoreCoordinator: [self persistentStoreCoordinator]];
    
    MOC.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy; // See more here: http://stackoverflow.com/a/8152401
    
    //Add notification for context save to merge
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(mergeChanges:) name:NSManagedObjectContextDidSaveNotification object:MOC];
    
    return MOC;
}

- (NSManagedObjectModel *)managedObjectModel {
    @synchronized(self) {
        if (!_managedObjectModel) {
    
            NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"TinyTastes" withExtension:@"momd"];
            _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
        }
    }
    return _managedObjectModel;
}

#pragma mark Recreate

- (void)recreateDatabase {
    NSError* cleanError;
    NSError* createError;
    
    if (![self cleanDatabase:cleanError]) {
        
        NSLog(@"Database clean FAILED. %@, %@", cleanError.userInfo, cleanError.localizedDescription);
    } else {
        if (![self createDatabase:createError]) {
            
            NSLog(@"Database recreation FAILED. %@, %@", createError.userInfo, createError.localizedDescription);
        } else {
            
            NSLog(@"!!! Database RECREATION successfully done. !!!");
        }
    }
}

#pragma mark Merge

- (void)mergeChanges:(NSNotification *)notification {
    // Merge changes into the main context on the main thread
    [self.managedObjectContext performSelectorOnMainThread:@selector(mergeChangesFromContextDidSaveNotification:)
                                  withObject:notification
                               waitUntilDone:YES];
}

@end
