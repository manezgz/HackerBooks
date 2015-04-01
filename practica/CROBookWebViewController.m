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

-(id)initWitURL:(NSURL*)aURL{
    if(self=[super init]){
        //NSData *pdfData = [[NSData alloc] initWithContentsOfURL:aURL];
        self.urlPdf=aURL;
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
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.browser.delegate=self;
}

-(void)loadPDF{
    NSData *pdfData = [[NSData alloc] initWithContentsOfURL:(self.urlPdf)];
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
