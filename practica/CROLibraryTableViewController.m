//
//  CROLibraryTableViewController.m
//  Library
//
//  Created by Jose Manuel Franco on 29/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CROLibraryTableViewController.h"
#import "BookViewController.h"

@interface CROLibraryTableViewController ()

@end

@implementation CROLibraryTableViewController

-(id)initWithLibrary:(CROLibraryModel*)aLibrary
           withStyle:(UITableViewStyle) aStyle{
    
    if(self=[super initWithStyle:aStyle]){
        _model=aLibrary;
        self.title = @"Library";
        _arrayOfTags=[self.model.dictOfTags allKeys];
        self.tableView.delegate=self;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    NSData *imageData=[[NSData alloc]initWithContentsOfURL:(book.image)];
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
    // Averiguamos de qué vino se trata
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
    [self.delegate libraryTableViewController:(self) didSelectABook:([self bookForIndexPath:(indexPath)])];

    //BookViewController *vcBook=[[BookViewController alloc]initWithBook:([self bookForIndexPath:(indexPath)])];
    //[self.navigationController pushViewController:vcBook animated:YES];
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
