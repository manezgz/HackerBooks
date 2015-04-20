//
//  PdfViewController.m
//  practica
//
//  Created by Jose Manuel Franco on 18/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "PdfViewController.h"

@interface PdfViewController ()

@end

@implementation PdfViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    // Do any additional setup after loading the view.
    UIBarButtonItem *addNoteButton=[[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                    target:nil
                                    action:nil];
    UIBarButtonItem *notesButton=[[UIBarButtonItem alloc]
                                     initWithImage:([UIImage imageNamed:@"Reader-Thumbs.png"])
                                     style:UIBarButtonItemStyleBordered
                                     target:nil
                                     action:nil];
    UIBarButtonItem *favoriteButton=[[UIBarButtonItem alloc]
                                           initWithTitle:@"☆"
                                           style:UIBarButtonItemStyleBordered
                                           target:nil
                                           action:nil];
    

    self.navigationItem.rightBarButtonItems=@[addNoteButton,notesButton,favoriteButton];
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
