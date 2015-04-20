#import "CRONote.h"
#import "CROPhoto.h"
#import <UIKit/UIKit.h>

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
    
    //Creamos una foto y se la asignamos
    CROPhoto *photo=[NSEntityDescription insertNewObjectForEntityForName:[CROPhoto entityName]
                                                inManagedObjectContext:context];
    NSData *data=UIImageJPEGRepresentation([UIImage imageNamed:@"noImage"], 0.9);
    photo.photo = data;

    
    [note setPhoto:photo];
    note.title=title;
    note.creationDate = [NSDate date];
    note.noteText=text;
    note.pageNumber=pageNumber;
    note.modificationDate = [NSDate date];
    
    return note;
}

@end
