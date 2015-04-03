//
//  BookViewController.h
//  practica
//
//  Created by Jose Manuel Franco on 30/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CROBook.h"
#import "CROLibraryTableViewController.h"

#define BOOK_FAVORITE_CHANGED @"bookFavoriteChanged"
#define BOOK_KEY @"book"
#define INDEX_PATH_KEY @"indexPath"

@interface BookViewController : UIViewController<CROLibraryTableViewControllerDelegate,UISplitViewControllerDelegate>


@property(nonatomic,strong) CROBook *book;
@property(nonatomic,weak) IBOutlet UILabel *titleValue;
@property(nonatomic,weak) IBOutlet UILabel *tagValue;
@property(nonatomic,weak) IBOutlet UILabel *authorValue;
@property(nonatomic,weak) IBOutlet UIImageView *bookImage;
@property(nonatomic,weak) IBOutlet UISwitch *bookSwitch;

-(id)initWithBook:(CROBook*)aBook;

- (IBAction)openPDF:(id)sender;

- (IBAction)favoriteSwitchChanged:(id)sender;

@end
