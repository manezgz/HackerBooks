//
//  CROCoreDataStack.h
//  practica
//
//  Created by Jose Manuel Franco on 14/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

@import Foundation;
@import CoreData;

@class NSManagedObjectContext;

@interface CROCoreDataStack : NSObject

@property (strong, nonatomic, readonly) NSManagedObjectContext *context;

+(NSString *) persistentStoreCoordinatorErrorNotificationName;

+(CROCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                                databaseFilename:(NSString*) aDBName;

+(CROCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName;

+(CROCoreDataStack *) coreDataStackWithModelName:(NSString *)aModelName
                                     databaseURL:(NSURL*) aDBURL;

-(id) initWithModelName:(NSString *)aModelName
            databaseURL:(NSURL*) aDBURL;

-(void) zapAllData;

-(void) saveWithErrorBlock: (void(^)(NSError *error))errorBlock;

-(NSArray *) executeFetchRequest:(NSFetchRequest *)req
                      errorBlock:(void(^)(NSError *error)) errorBlock;


@end
