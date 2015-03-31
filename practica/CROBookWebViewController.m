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
        NSData *pdfData = [[NSData alloc] initWithContentsOfURL:aURL];
        self.pdf=pdfData;
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self.browser loadData:(self.pdf)
                  MIMEType:(@"application/pdf")
          textEncodingName:@"utf-8"
                   baseURL:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
