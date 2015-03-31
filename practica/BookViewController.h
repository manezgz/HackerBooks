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

@interface BookViewController : UIViewController<CROLibraryTableViewControllerDelegate>


@property(nonatomic,strong) CROBook *book;
@property(nonatomic,weak) IBOutlet UILabel *titleValue;
@property(nonatomic,weak) IBOutlet UILabel *tagValue;
@property(nonatomic,weak) IBOutlet UILabel *authorValue;
@property(nonatomic,weak) IBOutlet UIImageView *bookImage;

-(id)initWithBook:(CROBook*)aBook;

- (IBAction)openPDF:(id)sender;

@end
