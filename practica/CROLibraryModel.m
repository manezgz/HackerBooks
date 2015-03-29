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
-(id) initWithArray:(NSArray*)anArray{
    if(self=[super init]){
        self.books=anArray;
    }
    return self;
}

-(NSUInteger)	booksCount{
    return [self.books count];
}

-(NSArray*)	tags{
    return nil;
}

-(NSUInteger)	bookCountForTag:(NSString*)	tag{
    int result=0;
    for(CROBook *book in self.books){
        for(NSString *tagBook in book.tags){
            if([tagBook isEqualToString:(tag)]){
                result=result+1;
            }
        }
    }
    return result;
}

-(NSArray*)	booksForTag:	(NSString	*)	tag{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for(CROBook *book in self.books){
        for(NSString *tagBook in book.tags){
            if([tagBook isEqualToString:(tag)]){
                [array addObject:book];
            }
        }
    }
    return array;
}

-(CROBook*)	bookForTag:(NSString*)	tag	atIndex:(NSUInteger)	index{
    NSMutableArray *array=[[NSMutableArray alloc]init];
    for(CROBook *book in self.books){
        for(NSString *tagBook in book.tags){
            if([tagBook isEqualToString:(tag)]){
                [array addObject:book];
            }
        }
    }
    return [array objectAtIndex:index];
}


@end
