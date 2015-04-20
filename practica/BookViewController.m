//
//  BookViewController.m
//  practica
//
//  Created by Jose Manuel Franco on 18/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "BookViewController.h"
#import "ReaderDocument.h"
#import "PdfViewController.h"
#import "CRONotesViewController.h"
#import "CRONote.h"

@interface BookViewController ()

@end

@implementation BookViewController

UIActivityIndicatorView *activityIndicator;

-(instancetype) initWithBook:(CROBook*) book
                  andContext:(NSManagedObjectContext *)context{
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        _book = book;
        _context=context;
        //Recuperamos el tag de favoritos
        NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[CROTag entityName]];
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tagName == %@",@"Favoritos"];
        [req setPredicate:predicate];
        NSArray *resultFetch=[context executeFetchRequest:req error:nil];
        _favoriteTag=[resultFetch firstObject];
        
    }
    
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    // Asegurarme de que la vista del controlador ocupa solo el espacio
    // que deje un navigation o un tabBar
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    NSLog(@"Navframe Height=%f",
          self.navigationController.navigationBar.frame.size.height);
    
    //Create an instance of activity indicator view
    activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    //set the initial property
    [activityIndicator stopAnimating];
    [activityIndicator hidesWhenStopped];
    activityIndicator.color = [UIColor blueColor];
    //Create an instance of Bar button item with custome view which is of activity indicator
    UIBarButtonItem * barButton = [[UIBarButtonItem alloc] initWithCustomView:activityIndicator];
    //Set the bar button the navigation bar
    [self navigationItem].rightBarButtonItem = barButton;
    
    // Sincronizamos modelo -> vistas
    [self syncWithModel];
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -  Notificaciones




-(void) syncWithModel{
    
    self.title = self.book.title;
    [UIView transitionWithView:self.bookImage
                      duration:0.7
                       options:UIViewAnimationOptionTransitionCrossDissolve
                    animations:^{
                        self.bookImage.image = [UIImage imageWithData:self.book.coverImage];
                    } completion:nil];
    
    [self syncFavoriteButton];
}

-(void) syncFavoriteButton{
    if (self.book.favoriteValue) {
        self.favoriteButton.title = @"★";
    }else{
        self.favoriteButton.title = @"☆";
    }
}




#pragma mark - AGTLibraryTableViewControllerDelegate
//-(void) libraryTableViewController:(AGTLibraryTableViewController *)vc
//                     didSelectBook:(AGTBook *)newBook{
//    
//    // cambiamos modelo y sincronizamos con el nuevo
//    //self.model = newBook;
//   // [self syncWithModel];
//}

- (IBAction)openPdf:(id)sender {
    [activityIndicator startAnimating];
    [self downloadAndRelocatePdf];
    
    
}



- (IBAction)viewNotes:(id)sender {
    
    // Fetch request
    NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[CRONote entityName]];
    req.sortDescriptors = @[[NSSortDescriptor
                             sortDescriptorWithKey:CRONoteAttributes.title
                             ascending:YES],
                            [NSSortDescriptor
                             sortDescriptorWithKey:CRONoteAttributes.modificationDate
                             ascending:NO]];
    
    req.predicate = [NSPredicate predicateWithFormat:@"books == %@", self.book];
    
    // Fetched Results Controller
    NSFetchedResultsController *fc = [[NSFetchedResultsController alloc]
                                      initWithFetchRequest:req
                                      managedObjectContext:self.context
                                      sectionNameKeyPath:nil
                                      cacheName:nil];
    
    // layout
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.minimumLineSpacing = 10;
    layout.minimumInteritemSpacing = 10;
    layout.itemSize = CGSizeMake(120, 150);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    // View controller
    CRONotesViewController *nb = [CRONotesViewController coreDataCollectionViewControllerWithFetchedResultsController:fc
                                                                                                               layout:layout];
    nb.book = self.book;
    
    
    // Push it!
    [self.navigationController pushViewController:nb
                                         animated:YES];
    
}



-(void)downloadAndRelocatePdf{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *baseDocumentPath = [paths objectAtIndex:0];
    NSString *fileName=@"/book.pdf";
    NSString *filePath = [baseDocumentPath stringByAppendingPathComponent:fileName];
    if(self.book.pdf.bookDownloaded){
        [self.book.pdf.binData writeToFile:(filePath) atomically:YES];
        [self loadPdf];
    }else{
        [self withURL:filePath block:^(NSData *pdfData) {
            //Se lo asignamos al book
            self.book.pdf.binData=pdfData;
            self.book.pdf.bookDownloaded=YES;
            [self loadPdf];
        }];
    }
}

-(void) loadPdf{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *baseDocumentPath = [paths objectAtIndex:0];
    NSString *fileName=@"/book.pdf";
    NSString *filePath = [baseDocumentPath stringByAppendingPathComponent:fileName];
    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:nil];
    [activityIndicator stopAnimating];
    if (document != nil){
        PdfViewController *pdfVC = [[PdfViewController alloc] initWithReaderDocument:document];
        //readerViewController.delegate = self;
        //pdfVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        //pdfVC.modalPresentationStyle = UIModalPresentationNone;
        [self.navigationController pushViewController:pdfVC
                                             animated:YES];
    }

}

-(void)withURL:(NSString*)filePath block:(void (^)(NSData* pdf))completionBlock{
    
    //Nos vamos a segundo plano a descargar la imagen
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0), ^{
        
        NSData *data=[[NSData alloc ]initWithContentsOfURL:[NSURL URLWithString:self.book.pdf.url]];
        [data writeToFile:(filePath) atomically:YES];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            completionBlock(data);
        });
    });
}


- (IBAction)flipFavorite:(id)sender {
    self.book.favoriteValue = !self.book.favoriteValue;
    [self syncFavoriteButton];
    if(self.book.favoriteValue){
        [self.book addTagsObject:self.favoriteTag];
    }else{
        [self.book removeTagsObject:self.favoriteTag];
    }
    

}
@end
