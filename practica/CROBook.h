//
//  CROBook.h
//  Library
//
//  Created by Jose Manuel Franco on 27/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UIKit;

@interface CROBook : NSObject

@property(nonatomic,strong) NSString *title;
@property(nonatomic,strong) NSURL *image;
@property(nonatomic,strong) NSURL *pdf;
@property(nonatomic,strong) NSArray *authors;
@property(nonatomic,strong) NSArray *tags;

-(id) initWithTitle:(NSString *)title
       withImageURL:(NSURL*)image
         withPDFURL:(NSURL*)image
        withAuthors:(NSArray*)authors
           withTags:(NSArray*)tags;



@end
