#import "_CRONote.h"

@interface CRONote : _CRONote {}

+(instancetype) noteWithTitle:(NSString *)title
                     withText:(NSString *)text
                 inPageNumber:(NSNumber *) pageNumber
                   context:(NSManagedObjectContext *) context;

@end
