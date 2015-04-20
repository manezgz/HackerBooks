#import "CROBook.h"
@import UIKit;

@interface CROBook ()

// Private interface goes here.

@end

@implementation CROBook

@synthesize imageUpdated;

+(instancetype) bookWithTitle:(NSString *)title
            withUrlCoverImage:(NSString*)url
                      authors:(NSSet*)authors
                      context:(NSManagedObjectContext *) context{
    
    CROBook *book=[NSEntityDescription insertNewObjectForEntityForName:[CROBook entityName]
                                                inManagedObjectContext:context];
    
    book.title=title;
    book.authors=authors;
    book.coverImageURL=url;
    book.favoriteValue=NO;
    
    //Sacamos la imagen generica
    NSData * imageData = UIImagePNGRepresentation([UIImage imageNamed:@"bookCoverGeneric"]);
    book.coverImage=imageData;
    book.imageUpdated=NO;
    
    return book;
}

-(void) updateImageBookInTable:(UITableView*)tableView{
    if(!self.imageUpdated){
        [self withImage:^(NSData *imageData) {
            self.coverImage=imageData;
            self.imageUpdated=YES;
            [tableView reloadData];
        }];
    }
}

-(void)withImage:(void (^)(NSData* image))completionBlock{
    
    //Nos vamos a segundo plano a descargar la imagen
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        NSURL *imgURL =[NSURL URLWithString:self.coverImageURL];
        
        NSData *data=[NSData dataWithContentsOfURL:imgURL];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(data);
        });
    });
}

@end
