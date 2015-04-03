//
//  CRODataHandler.h
//  practica
//
//  Created by Jose Manuel Franco on 3/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CROLibraryModel.h"
#import "CROBook.h"

#define JSON_DOWNLOADED @"JSON_DOWNLOADED"
#define IMAGES_DOWNLOADED @"IMAGES_DOWNLOADED"

@interface CRODataHandler : NSObject

-(NSArray*) getJsonArray;

-(void) downloadImagesFromJSONArray:(NSArray*)arrayJSON;

-(CROLibraryModel*) createModelFromJsonArray:(NSArray*)arrayJSON;

-(CROBook*) getInitialBook:(CROLibraryModel*)model;


@end
