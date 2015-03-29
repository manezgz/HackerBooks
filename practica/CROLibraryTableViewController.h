//
//  CROLibraryTableViewController.h
//  Library
//
//  Created by Jose Manuel Franco on 29/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CROLibraryModel.h"

@interface CROLibraryTableViewController : UITableViewController<UITableViewDelegate>

@property(strong,nonatomic) CROLibraryModel *model;
@property(strong,nonatomic) NSArray *arrayOfTags;

-(id)initWithLibrary:(CROLibraryModel*)aLibrary
           withStyle:(UITableViewStyle) aStyle;

@end
