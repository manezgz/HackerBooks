//
//  CROBookViewController.m
//  practica
//
//  Created by Jose Manuel Franco on 26/5/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CROBookViewController.h"
#import "CROBookWebViewController.h"

@interface CROBookViewController ()

@end

@implementation CROBookViewController

-(id)initWithBook:(CROBook*)aBook{
    if(self=[super init]){
        _book=aBook;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self synchronizeViewAndModel];
    self.navigationItem.rightBarButtonItem = self.splitViewController.displayModeButtonItem;
    
    // Alta en notificaciones de library
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookDidChange:)
               name:BOOK_DID_CHANGE_NOTIFICATION
             object:nil];
    
}

-(void) notifyThatBookDidChange:(NSNotification *) notification{
    
    // sacamos el nuevo libro
    CROBook *book = [notification.userInfo objectForKey:BOOK_KEY];
    self.book = book;
    [self synchronizeViewAndModel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;
}

- (IBAction)openPdf:(id)sender {
    NSLog(@"Toco boton");
    CROBookWebViewController *vcPDF=[[CROBookWebViewController alloc]initWithBook:(self.book)];
    [self.navigationController pushViewController:vcPDF animated:YES];
}
- (IBAction)favoriteButtonPressed:(id)sender {
    [self.book changeFavorite];
    [self synchronizeViewAndModel];
}

- (void)synchronizeViewAndModel{
    self.title=self.book.title;
    NSData *imageData=[[NSData alloc]initWithContentsOfURL:([self.book imageProxy])];
    self.bookImage.image = [UIImage imageWithData:(imageData)];
    if(self.book.isFavorite){
        self.favoriteButton.title = @"★";
    }else{
        self.favoriteButton.title = @"☆";
    }
    
}


#pragma mark Delegate
- (void)libraryTableViewController:(CROLibraryTableViewController *)tableVC
                    didSelectABook:(CROBook *)aBook
                       atIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Delegado recibe peticion");
    self.book=aBook;
    //self.indexPath=indexPath;
    [self synchronizeViewAndModel];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
