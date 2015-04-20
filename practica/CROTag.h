#import "_CROTag.h"

@interface CROTag : _CROTag {}

+(instancetype) tagWithName:(NSString *)name
                       context:(NSManagedObjectContext *) context;


@end
