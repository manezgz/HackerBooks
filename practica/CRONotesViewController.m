//
//  AGTNotesViewController.m
//  Everpobre
//
//  Created by Fernando Rodríguez Romero on 17/06/14.
//  Copyright (c) 2014 Agbo. All rights reserved.
//

#import "CRONotesViewController.h"
#import "CRONote.h"
#import "CRONoteCellView.h"
#import "CROPhoto.h"
#import "NoteViewController.h"

static NSString *cellId = @"NoteCellId";

@interface CRONotesViewController ()

@end

@implementation CRONotesViewController

#pragma mark -  View Lifecicle
-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self registerCell];
    
    self.title = @"Notes";
    
    self.collectionView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1];
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                         target:self
                                                                         action:@selector(addNote:)];
    self.navigationItem.rightBarButtonItem = add;
}

#pragma mark - cell registration
-(void) registerCell{
    
    UINib *nib = [UINib nibWithNibName:@"CRONoteCollectionViewCell"
                                bundle:nil];
    [self.collectionView registerNib:nib
          forCellWithReuseIdentifier:cellId];
}

#pragma mark - Data Source
-(UICollectionViewCell*) collectionView:(UICollectionView *)collectionView
                 cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    // Obtener el objeto
    CRONote *note = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    // Obtener la celda
    CRONoteCellView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellId
                                                                      forIndexPath:indexPath];
    // Configurarla
    [cell observeNote:note];
    
    
    // Devolcerla
    return cell;
}

#pragma mark - Utils
-(void) addNote:(id) sender{
    
    NoteViewController *newNoteVC = [[NoteViewController alloc] initForNewNoteInBook:self.book];
    [self.navigationController pushViewController:newNoteVC
                                         animated:YES];
    
}

@end
