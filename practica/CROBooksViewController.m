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

@interface CROBooksViewController ()

@end

@implementation CROBooksViewController


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

#pragma mark -DataSource
-(UITableViewCell *) tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    // Averiguar el tag
    CROTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    CROBook *book = [[tag.books allObjects] objectAtIndex:indexPath.row];
    
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
    CROTag *tag=[[self.fetchedResultsController fetchedObjects] objectAtIndex:section];
    return [tag.books count];
}

-(void) tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    // Averiguar el tag
    CROTag *tag = [self.fetchedResultsController.fetchedObjects objectAtIndex:indexPath.section];
    CROBook *book = [[tag.books allObjects] objectAtIndex:indexPath.row];
    BookViewController *bookVC=[[BookViewController alloc]initWithBook:book andContext:self.fetchedResultsController.managedObjectContext];
    [self.navigationController pushViewController:bookVC animated:true];
    
    
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
