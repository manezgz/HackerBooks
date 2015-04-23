//
//  CROBooksViewController.h
//  practica
//
//  Created by Jose Manuel Franco on 16/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CROCoreDataTableViewController.h"
#import "BookViewController.h"

@interface CROBooksViewController : CROCoreDataTableViewController<CROFavoriteChangedInBook>

@property (strong, nonatomic) UISearchController *searchController;

-(instancetype) initWithFetchedResultsControllerTags:(NSFetchedResultsController *)fetchControllerTags
                   withFetchedResultsControllerBooks:(NSFetchedResultsController *) fetchControllerBooks
                                               style:(UITableViewStyle)aStyle;

@end
