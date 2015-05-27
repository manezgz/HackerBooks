//
//  CROBookWebViewController.m
//  practica
//
//  Created by Jose Manuel Franco on 31/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CROBookWebViewController.h"

@interface CROBookWebViewController ()

@end

@implementation CROBookWebViewController

-(id)initWithBook:(CROBook *)aBook{
    if(self=[super initWithNibName:nil
                            bundle:nil]){
        //NSData *pdfData = [[NSData alloc] initWithContentsOfURL:aURL];
        self.book=aBook;

    }
    return self;
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadPDF];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.browser.delegate=self;
    [self.activityView setHidden:NO];
    [self.activityView startAnimating];
    // Alta en notificaciones de library
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self
           selector:@selector(notifyThatBookDidChange:)
               name:BOOK_DID_CHANGE_NOTIFICATION
             object:nil];
    self.edgesForExtendedLayout=UIRectEdgeNone;
    self.extendedLayoutIncludesOpaqueBars=NO;
    self.automaticallyAdjustsScrollViewInsets=NO;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.browser.delegate=self;
}

#pragma mark - Notificaciones
-(void) notifyThatBookDidChange:(NSNotification *) notification{
    
    // sacamos el nuevo libro
    CROBook *book = [notification.userInfo objectForKey:BOOK_KEY];
    self.book = book;
    [self loadPDF];
}

-(void)loadPDF{
    self.navigationController.title=self.book.title;
    //Lo primero comprobamos si el pdf ya ha sido descargado
    NSData *pdfData=[[NSData alloc ]initWithContentsOfURL:(self.book.pdfProxy)];
    if(pdfData==nil){
        //Sino lo descargo
        NSData *data=[[NSData alloc ]initWithContentsOfURL:self.book.pdf];
        [data writeToFile:(self.book.pdfProxy.path) atomically:YES];
        pdfData=[[NSData alloc ]initWithContentsOfURL:self.book.pdfProxy];
    }
    
    [self.browser loadData:(pdfData)
             MIMEType:(@"application/pdf")
     textEncodingName:@"utf-8"
              baseURL:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [self.activityView setHidden:NO];
    
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [self.activityView setHidden:YES];
    [self.activityView stopAnimating];
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
