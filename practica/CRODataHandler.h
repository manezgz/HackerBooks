//
//  CRODataHandler.h
//  practica
//
//  Created by Jose Manuel Franco on 16/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@class AGTSimpleCoreDataStack;

@interface CRODataHandler : NSObject

-(NSArray*) getJsonArray;


-(void) addJsonArray:(NSArray*)arrayJSON
                         toCoreDataContext:(NSManagedObjectContext *)context;



@end