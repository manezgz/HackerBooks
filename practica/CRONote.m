#import "CRONote.h"

@interface CRONote ()

// Private interface goes here.

@end

@implementation CRONote

+(instancetype) noteWithTitle:(NSString *)title
                     withText:(NSString *)text
                 inPageNumber:(NSNumber *) pageNumber
                      context:(NSManagedObjectContext *) context{
    
    CRONote *note=[NSEntityDescription insertNewObjectForEntityForName:[CRONote entityName]
                                                inManagedObjectContext:context];
    note.title=title;
    note.creationDate = [NSDate date];
    note.noteText=text;
    note.pageNumber=pageNumber;
    note.modificationDate = [NSDate date];
    
    return note;
}

@end
