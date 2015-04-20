#import "_CROBook.h"
#import <Foundation/Foundation.h>
@import UIKit;

@interface CROBook : _CROBook {}
// Custom logic goes here.

@property(nonatomic) BOOL imageUpdated;

+(instancetype) bookWithTitle:(NSString *)title
            withUrlCoverImage:(NSString*)url
                      authors:(NSSet*)authors
                      context:(NSManagedObjectContext *) context;

-(void) updateImageBookInTable:(UITableView*)tableView;



@end
