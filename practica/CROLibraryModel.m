//
//  CROLibraryModel.m
//  Library
//
//  Created by Jose Manuel Franco on 27/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CROLibraryModel.h"
#import "CROBook.h"

@implementation CROLibraryModel
-(id) initWithArray:(NSArray*)anArray
     withDictionary:(NSDictionary*)dict{
    if(self=[super init]){
        self.arrayOfTagsSorted=anArray;
        self.dictOfTags=dict;
    }
    return self;
}




-(NSUInteger)	booksCount{
    return 30;
}

-(NSArray*)	tags{
    return [self.dictOfTags allKeys];
}

-(NSUInteger)	bookCountForTag:(NSString*)	tag{
    NSArray *array=[self.dictOfTags objectForKey:(tag)];
    return [array count];
}

-(NSArray*)	booksForTag:	(NSString	*)	tag{
    return [self.dictOfTags objectForKey:tag];
}

-(CROBook*)	bookForTag:(NSString*)	tag	atIndex:(NSUInteger)index{
    NSArray *array=[self.dictOfTags objectForKey:(tag)];
    return [array objectAtIndex:index];
}


@end
