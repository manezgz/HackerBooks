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
           withTags:(NSArray*)tags
       withFavorite:(BOOL)isFavorite{
    
    if(self=[super init]){
        self.title=title;
        self.image=image;
        self.pdf=pdf;
        self.authors=authors;
        self.tags=tags;
        self.isFavorite=isFavorite;
    }
    return self;
}

-(NSURL*) imageProxy{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingString:@"/"];
    NSString *imageName =[[[self.image absoluteString]componentsSeparatedByString:@"/"]lastObject];
    NSString *imagePath =[documentsDirectoryPath stringByAppendingString:imageName];
    return [NSURL fileURLWithPath:(imagePath)];
}

-(NSURL*) pdfProxy{
    NSString *pdfName=[[self.pdf.path componentsSeparatedByString:@"/"]lastObject];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingString:@"/"];
    NSString *pdfPath =[documentsDirectoryPath stringByAppendingString:pdfName];
    return [NSURL fileURLWithPath:(pdfPath)];
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super init]) {
        self.title = [decoder decodeObjectForKey:@"title"];
        self.image = [decoder decodeObjectForKey:@"image"];
        self.pdf = [decoder decodeObjectForKey:@"pdf"];
        self.authors = [decoder decodeObjectForKey:@"authors"];
        self.tags = [decoder decodeObjectForKey:@"tags"];
        self.isFavorite = [decoder decodeBoolForKey:@"isFavorite"];

    }
    return self;
}

-(void) changeFavorite{
    //Cambiamos
    self.isFavorite=!self.isFavorite;
    
    //Notificamos
    NSNotification *notification=[NSNotification notificationWithName:(BOOK_FAVORITE_CHANGED)
                                                               object:(self)
                                                             userInfo:(@{BOOK_KEY:self}
                                                                       )];
    [[NSNotificationCenter defaultCenter]postNotification:(notification)];

    
}

- (void)encodeWithCoder:(NSCoder *)encoder {
    [encoder encodeObject:self.title forKey:@"title"];
    [encoder encodeObject:self.image forKey:@"image"];
    [encoder encodeObject:self.pdf forKey:@"pdf"];
    [encoder encodeObject:self.authors forKey:@"authors"];
    [encoder encodeObject:self.tags forKey:@"tags"];
    [encoder encodeBool:self.isFavorite forKey:@"isFavorite"];
}



@end
