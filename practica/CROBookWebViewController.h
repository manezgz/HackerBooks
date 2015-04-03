//
//  CROBookWebViewController.h
//  practica
//
//  Created by Jose Manuel Franco on 31/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CROBook.h"
#import "CROLibraryTableViewController.h"

@interface CROBookWebViewController : UIViewController<UIWebViewDelegate>

@property(weak,nonatomic) IBOutlet UIWebView *browser;
@property(strong,nonatomic) CROBook *book;
@property(nonatomic,weak) IBOutlet UIActivityIndicatorView *activityView;

-(id)initWithBook:(CROBook*)aBook;

@end
