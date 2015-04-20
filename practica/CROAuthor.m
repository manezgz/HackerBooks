#import "CROAuthor.h"

@interface CROAuthor ()

// Private interface goes here.

@end

@implementation CROAuthor

+(instancetype) authorWithName:(NSString *)name
                      context:(NSManagedObjectContext *) context{
    
    
    //CROAuthor es una entidad "Reutilizable" así que antes de insertar miraremos a ver si ya existe un objeto con ese mismo nombre
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[CROAuthor entityName]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@",name];
    [req setPredicate:predicate];
    CROAuthor *author=nil;
    NSArray *resultFetch=[context executeFetchRequest:req error:nil];
    if([resultFetch count]==0){
        author=[NSEntityDescription insertNewObjectForEntityForName:[CROAuthor entityName]
                                          inManagedObjectContext:context];
        author.name=name;
    }else{
        author=[resultFetch firstObject];
    }
    return author;
}

@end
