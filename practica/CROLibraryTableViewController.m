//
//  CROLibraryTableViewController.m
//  Library
//
//  Created by Jose Manuel Franco on 29/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CROLibraryTableViewController.h"
#import "CROBookViewController.h"

@interface CROLibraryTableViewController ()

@end

@implementation CROLibraryTableViewController

-(id)initWithLibrary:(CROLibraryModel*)aLibrary
           withStyle:(UITableViewStyle) aStyle{
    
    if(self=[super initWithStyle:aStyle]){
        _model=aLibrary;
        self.title = @"Hacker Books";
        _arrayOfTags=self.model.arrayOfTagsSorted;
        
        //Le damos de alta como observer de la notificación de que se aha modificado un libro favorito
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(modelDidChange:)
                                                     name:BOOK_FAVORITE_CHANGED
                                                   object:nil];
    }
    return self;
}

-(void)viewDidLoad{
    self.edgesForExtendedLayout=UIRectEdgeNone;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}

-(void)dealloc{
    // Baja en notificaciones
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
   
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.arrayOfTags count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSString *tag=[self.arrayOfTags objectAtIndex:section];
    return [[self.model.dictOfTags objectForKey:(tag)] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"BookCell";
    
    CROBook *book = [self bookForIndexPath:(indexPath)];
    // Creamos una celda
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        // La creamos de cero
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                          reuseIdentifier:CellIdentifier];
    }
    
    // Sincronizamos modelo con vista (celda)
    NSData *imageData=[[NSData alloc]initWithContentsOfURL:([book imageProxy])];
    cell.imageView.image = [UIImage imageWithData:(imageData)];
    cell.textLabel.text =book.title;
    cell.detailTextLabel.text=[book.authors componentsJoinedByString:@","];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView
titleForHeaderInSection:(NSInteger)section{
    return [self.arrayOfTags objectAtIndex:section];
}

- (NSString *)tableView:(UITableView *)tableView
titleForFooterInSection:(NSInteger)section{
    NSString *tag=[self.arrayOfTags objectAtIndex:section];
    int items=[[self.model.dictOfTags objectForKey:(tag)]count];
    return [NSString stringWithFormat:@"%d items",items];
}

- (CROBook *)bookForIndexPath:(NSIndexPath *)indexPath
{
    // Averiguamos de qué book se trata
    CROBook *book = nil;
    
    NSString *section=[self.arrayOfTags objectAtIndex:indexPath.section];
    
    book=[[self.model.dictOfTags valueForKey:(section)] objectAtIndex:(indexPath.row)];
     
    return book;
}

#pragma mark -Table View Delegate
- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected ROW");
    // Avisar al delegado
    CROBook *book=[self bookForIndexPath:(indexPath)];
    [self.delegate libraryTableViewController:(self)
                               didSelectABook:(book)
                                  atIndexPath:indexPath];
    
    //actualizamos el puntero a libro seleccionado
    self.model.bookSelected=book;
    // Mando también la notificación
    [self postNotificationThatSelectedBookDidChange:book];

}

- (void)libraryTableViewController:(CROLibraryTableViewController *)tableVC
                    didSelectABook:(CROBook *)aBook
                       atIndexPath:(NSIndexPath *)indexPath{
    
    //creamos un BookViewController y le casco un Push
    CROBookViewController *bookVC=[[CROBookViewController alloc]initWithBook:aBook];
    [self.navigationController pushViewController:bookVC animated:(YES)];
    
}

#pragma mark -Notifications
- (void) modelDidChange:(NSNotification *)aNotification{
    CROBook *book = [aNotification.userInfo objectForKey:BOOK_KEY];
    //Aplicamos los cambios al array de Favoritos
    if(book.isFavorite){
        [[self.model.dictOfTags objectForKey:(@"Favorites")] addObject:book];
    }else{
        //Como debe hacer algo raro por ahi lo recorremos y buscamos por titulo
        for(CROBook *bookInArray in [self.model.dictOfTags objectForKey:(@"Favorites")]){
            if([bookInArray.title isEqualToString:(book.title)]){
                bookInArray.isFavorite=NO;
                [[self.model.dictOfTags objectForKey:(@"Favorites")] removeObject:bookInArray];
                break;
            }
        }
        
    }
    
    [self.tableView reloadData];
}

-(void) postNotificationThatSelectedBookDidChange:(CROBook*)selectedBook{
    
    // Mando también la notificación
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    
    NSNotification *n = [NSNotification
                         notificationWithName:BOOK_DID_CHANGE_NOTIFICATION
                         object:self
                         userInfo:@{BOOK_KEY:selectedBook}];
    [nc postNotification:n];
    
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
