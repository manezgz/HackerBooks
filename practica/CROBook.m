//
//  CROBook.m
//  Library
//
//  Created by Jose Manuel Franco on 27/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CROBook.h"

@implementation CROBook

-(id) initWithTitle:(NSString *)title
       withImageURL:(NSURL*)image
         withPDFURL:(NSURL*)pdf
        withAuthors:(NSArray*)authors
           withTags:(NSArray*)tags{
    
    if(self=[super init]){
        self.title=title;
        self.image=image;
        self.pdf=pdf;
        self.authors=authors;
        self.tags=tags;
    }
    return self;
}


@end
