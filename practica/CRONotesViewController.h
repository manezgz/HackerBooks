//
//  AGTNotesViewController.h
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 17/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "CROCoreDataCollectionViewController.h"
#import "CROBook.h"

@interface CRONotesViewController : CROCoreDataCollectionViewController

@property(strong,nonatomic)CROBook *book;

@end
