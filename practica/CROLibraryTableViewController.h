//
//  CROLibraryTableViewController.h
//  Library
//
//  Created by Jose Manuel Franco on 29/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CROLibraryModel.h"
#define BOOK_SELECTED_CHANGED @"bookSelectedChanged"

@class CROLibraryTableViewController;

@protocol CROLibraryTableViewControllerDelegate <NSObject>

- (void)libraryTableViewController:(CROLibraryTableViewController *)tableVC
                    didSelectABook:(CROBook *)aBook
                       atIndexPath:(NSIndexPath *)indexPath;

@end

@interface CROLibraryTableViewController : UITableViewController<CROLibraryTableViewControllerDelegate>

@property(strong,nonatomic) CROLibraryModel *model;
@property(strong,nonatomic) NSArray *arrayOfTags;
@property (weak, nonatomic) id<CROLibraryTableViewControllerDelegate> delegate;

-(id)initWithLibrary:(CROLibraryModel*)aLibrary
           withStyle:(UITableViewStyle) aStyle;

@end
