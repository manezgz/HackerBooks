//
//  BookViewController.h
//  practica
//
//  Created by Jose Manuel Franco on 18/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CROBook.h"
#import "CROTag.h"
#import "CROPdf.h"

@protocol CROFavoriteChangedInBook <NSObject>

- (void)favoriteChangedInbook;

@end

@interface BookViewController : UIViewController

@property (nonatomic,assign)  id <CROFavoriteChangedInBook> delegate;
@property(strong,nonatomic) CROBook *book;
@property(weak, nonatomic) IBOutlet UIImageView *bookImage;
@property(weak, nonatomic) IBOutlet UIBarButtonItem *favoriteButton;
@property(strong,nonatomic) CROTag *favoriteTag;
@property(strong,nonatomic) NSManagedObjectContext *context;

-(instancetype) initWithBook:(CROBook*)book
                  andContext:(NSManagedObjectContext *) context;

- (IBAction)openPdf:(id)sender;
- (IBAction)flipFavorite:(id)sender;

@end
