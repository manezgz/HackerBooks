//
//  CROLibraryModel.h
//  Library
//
//  Created by Jose Manuel Franco on 27/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CROBook.h"

@interface CROLibraryModel : NSObject

@property(nonatomic,strong) NSArray *arrayOfTagsSorted;
@property(nonatomic,strong) NSDictionary *dictOfTags;
@property(strong,nonatomic) CROBook *bookSelected;

-(id) initWithArray:(NSArray*)anArray withDictionary:(NSDictionary*)dict;

-(NSUInteger)	booksCount;

-(NSArray*)	tags;

-(NSUInteger)	bookCountForTag:(NSString*)	tag;

-(NSArray*)	booksForTag:	(NSString	*)	tag;

-(CROBook*)	bookForTag:(NSString*)	tag	atIndex:(NSUInteger)	index;


@end
