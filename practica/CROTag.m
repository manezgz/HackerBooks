#import "CROTag.h"

@interface CROTag ()

// Private interface goes here.

@end

@implementation CROTag

+(instancetype) tagWithName:(NSString *)name
                    context:(NSManagedObjectContext *) context{
    
    //CROTag es una entidad "Reutilizable" así que antes de insertar miraremos a ver si ya existe un objeto con ese mismo nombre
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[CROTag entityName]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tagName == %@",name];
    [req setPredicate:predicate];
    CROTag *tag=nil;
    NSArray *resultFetch=[context executeFetchRequest:req error:nil];
    if([resultFetch count]==0){
        tag=[NSEntityDescription insertNewObjectForEntityForName:[CROTag entityName]
                                                    inManagedObjectContext:context];
        tag.tagName=name;
    }else{
        tag=[resultFetch firstObject];
    }
    
    return tag;
    
}

@end
