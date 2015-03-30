//
//  BookViewController.m
//  practica
//
//  Created by Jose Manuel Franco on 30/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "BookViewController.h"

@interface BookViewController ()

@end

@implementation BookViewController

-(id)initWithBook:(CROBook*)aBook{
    if(self=[super init]){
        _book=aBook;
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self synchronizeViewAndModel];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout=UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)synchronizeViewAndModel{
    self.titleValue.text=self.book.title;
    self.authorValue.text=[self.book.authors componentsJoinedByString:@","];
    self.tagValue.text=[self.book.tags componentsJoinedByString:@","];
    NSData *imageData=[[NSData alloc]initWithContentsOfURL:(self.book.image)];
    self.bookImage.image = [UIImage imageWithData:(imageData)];
    
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
