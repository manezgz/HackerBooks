//
//  CROBookWebViewController.h
//  practica
//
//  Created by Jose Manuel Franco on 31/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CROBookWebViewController : UIViewController<UIWebViewDelegate>

@property(weak,nonatomic) IBOutlet UIWebView *browser;
@property(strong,nonatomic) NSURL *urlPdf;
@property(nonatomic,weak) IBOutlet UIActivityIndicatorView *activityView;

-(id)initWitURL:(NSURL*)aURL;

@end
