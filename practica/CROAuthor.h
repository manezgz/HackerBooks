#import "_CROAuthor.h"

@interface CROAuthor : _CROAuthor {}


+(instancetype) authorWithName:(NSString *)name
                       context:(NSManagedObjectContext *) context;

@end
