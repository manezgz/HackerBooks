//
//  CROBooksViewController.m
//  practica
//
//  Created by Jose Manuel Franco on 16/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CROBooksViewController.h"
#import "CROBook.h"
#import "CROTag.h"
#import "CROAuthor.h"
#import "BookViewController.h"
@import CoreData;

@interface CROBooksViewController ()<UISearchBarDelegate, UISearchResultsUpdating>

@property(nonatomic) NSInteger searchIndex;
@property (strong,nonatomic) NSFetchedResultsController *fcBooks;
@property (strong,nonatomic) NSFetchedResultsController *fcTags;

@end

@implementation CROBooksViewController

-(instancetype) initWithFetchedResultsControllerTags:(NSFetchedResultsController *)fetchControllerTags
                   withFetchedResultsControllerBooks:(NSFetchedResultsController *) fetchControllerBooks
                                               style:(UITableViewStyle)aStyle{
    
    //Llamamos al inicializador de la superclase
    if(self==[super initWithFetchedResultsController:fetchControllerTags
                                               style:aStyle]){
        _fcBooks=fetchControllerBooks;
        _fcTags=fetchControllerTags;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) viewDidLoad{
    [super viewDidLoad];
    
    //Configuramos la barra de busqueda de libros
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:nil];
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = NO;
    self.searchController.searchBar.scopeButtonTitles=@[@"Tags",@"Title",@"Authors"];
    self.searchController.searchBar.delegate = self;
    
    
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.definesPresentationContext = YES;
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark -DataSource
-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguar el tag
    CROBook *book=nil;
    if(self.searchIndex==0){
        CROTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
        book = [[tag.books allObjects] objectAtIndex:indexPath.row];
    }else{
        book = [self.fcBooks.fetchedObjects objectAtIndex:indexPath.row];
    }
    
    //Actualizamos la imagen del book
    [book updateImageBookInTable:self.tableView];
    
    //Creamos una celda
    static NSString *cellId =@"cellId";
    UITableViewCell *cell =[tableView dequeueReusableCellWithIdentifier:cellId];
    if(cell==nil){
        cell =[[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleSubtitle)
                                     reuseIdentifier:cellId];
    }
    
    //Sincronizamos el book con la celda
    cell.imageView.image = [UIImage imageWithData:book.coverImage];
    cell.textLabel.text=book.title;
    cell.detailTextLabel.text=[self getAuthorsFromSet:book.authors];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    //Devolvemos la celda
    return cell;
    
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(self.searchIndex==0){
        CROTag *tag=[[self.fetchedResultsController fetchedObjects] objectAtIndex:section];
        return [tag.books count];
    }else{
        return [[self.fcBooks fetchedObjects]count];
    }
}

-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    CROBook *book=nil;
    if(self.searchIndex==0){
        // Averiguar el tag
        CROTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
        book = [[tag.books allObjects] objectAtIndex:indexPath.row];
    }else{
        book= [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.row];
    }
    BookViewController *bookVC=[[BookViewController alloc]initWithBook:book andContext:self.fetchedResultsController.managedObjectContext];
    
    bookVC.delegate=self;
    
    [self.navigationController pushViewController:bookVC animated:true];
    
    
}

# pragma mark - Delegate SearchController
- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope{
    NSLog(@"el indice es %ld",selectedScope);
    self.searchIndex=selectedScope;
    [self updateSearchResultsForSearchController:self.searchController];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    self.searchIndex=0;
    self.searchController.searchBar.selectedScopeButtonIndex=0;
}


- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    NSString *searchString = searchController.searchBar.text;
    self.searchIndex=self.searchController.searchBar.selectedScopeButtonIndex;
    NSPredicate *predicate=nil;
    
        switch (self.searchIndex){
            case 0:
                if(![searchString isEqualToString:@""]){
                    predicate = [NSPredicate predicateWithFormat:@"tagName CONTAINS[cd] %@", searchString];
                }else{
                    predicate=[NSPredicate predicateWithValue:YES];
                }
                self.fcTags.fetchRequest.predicate=predicate;
                [self.fcTags performFetch:nil];
                [self setFetchedResultsController:self.fcTags];
                break;
                
            case 1:
                if(![searchString isEqualToString:@""]){
                    predicate = [NSPredicate predicateWithFormat:@"title CONTAINS[cd] %@", searchString];
                }else{
                     predicate=[NSPredicate predicateWithValue:YES];
                }
                self.fcBooks.fetchRequest.predicate=predicate;
                [self.fcBooks performFetch:nil];
                [self setFetchedResultsController:self.fcBooks];
                
                break;
                
            case 2:
                if(![searchString isEqualToString:@""]){
                    predicate = [NSPredicate predicateWithFormat:@"authors.name CONTAINS[cd] %@", searchString];
                }else{
                    predicate=[NSPredicate predicateWithValue:YES];
                }
                self.fcBooks.fetchRequest.predicate=predicate;
                [self.fcBooks performFetch:nil];
                [self setFetchedResultsController:self.fcBooks];
                break;
                
        }
    [self.tableView reloadData];
}

#pragma mark -Delegate bookViewController
- (void)favoriteChangedInbook{
    [self.fetchedResultsController performFetch:nil];
    [self.tableView reloadData];

}



#pragma mark -Utils
-(NSString *) getAuthorsFromSet:(NSSet*)authors{
    NSString *result=@"";
    //NSArray *array=[authors allObjects];
    for(CROAuthor *author in authors){
        result=[result stringByAppendingString:author.name];
        result=[result stringByAppendingString:@" "];
    }
    return result;
}

@end
