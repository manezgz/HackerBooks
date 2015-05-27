//
//  CROBookViewController.h
//  practica
//
//  Created by Jose Manuel Franco on 26/5/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CROBook.h"
#import "CROLibraryTableViewController.h"

@interface CROBookViewController : UIViewController<CROLibraryTableViewControllerDelegate,UISplitViewControllerDelegate>

@property(nonatomic,strong) CROBook *book;
@property(nonatomic,weak) IBOutlet UIImageView *bookImage;
@property(nonatomic,weak) IBOutlet UIBarButtonItem *favoriteButton;
-(id)initWithBook:(CROBook*)aBook;

@end
