//
//  AppDelegate.m
//  practica
//
//  Created by Jose Manuel Franco on 29/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "AppDelegate.h"
#import "CROCoreDataStack.h"
#import "CRODataHandler.h"
#import "CROBooksViewController.h"
#import "CROBook.h"
#import "CROTag.h"
#import "ReaderDocument.h"
#import "ReaderViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *baseDocumentPath = [paths objectAtIndex:0];
//    NSString *filePath = [baseDocumentPath stringByAppendingPathComponent:@"/temp.pdf"];
//    NSData *data=[[NSData alloc ]initWithContentsOfURL:[NSURL URLWithString:@"http://eloquentjavascript.net/Eloquent_JavaScript.pdf"]];
//    [data writeToFile:(filePath) atomically:YES];
//    ReaderDocument *document = [ReaderDocument withDocumentFilePath:filePath password:nil];
//    
//    if (document != nil)
//    {
//        ReaderViewController *readerViewController = [[ReaderViewController alloc] initWithReaderDocument:document];
//        //readerViewController.delegate = self;
//        
//        readerViewController.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
//        readerViewController.modalPresentationStyle = UIModalPresentationFullScreen;
//        
//        UINavigationController *navVC=[[UINavigationController alloc]initWithRootViewController:readerViewController];
//        self.window.rootViewController=navVC;
//    }
    
    //Creamos el CoreDataStack
    self.model = [CROCoreDataStack coreDataStackWithModelName:@"Model"];
    
    //Llamamos a CRODataHandler
    CRODataHandler *dataHandler=[[CRODataHandler alloc]init];
    NSArray *array=[dataHandler getJsonArray];
    [dataHandler addJsonArray:array
            toCoreDataContext:self.model.context];
    
    //Sacamos un Fetch para los tags
    NSFetchRequest *request=[NSFetchRequest fetchRequestWithEntityName:[CROTag entityName]];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:CROTagAttributes.tagName
                                                              ascending:YES]];
                                
    NSFetchedResultsController *fcTags=[[NSFetchedResultsController alloc]initWithFetchRequest:request
                                                                           managedObjectContext:self.model.context
                                                                             sectionNameKeyPath:@"tagName" cacheName:nil];
    
    //Configuramos el NSFetchController Para Books
    NSFetchRequest *requestBooks=[NSFetchRequest fetchRequestWithEntityName:[CROBook entityName]];
    
    requestBooks.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:CROBookAttributes.title
                                                              ascending:YES]];
    
    NSFetchedResultsController *fcBooks=[[NSFetchedResultsController alloc]initWithFetchRequest:requestBooks
                                               managedObjectContext:self.model.context
                                                 sectionNameKeyPath:nil
                                                          cacheName:nil];

    
    //Creamos controlador de Books
    CROBooksViewController *booksVC=[[CROBooksViewController alloc] initWithFetchedResultsControllerTags:fcTags
                                                                       withFetchedResultsControllerBooks:fcBooks
                                                                                                   style:UITableViewStylePlain];
    
    
    UINavigationController *navVC=[[UINavigationController alloc]initWithRootViewController:booksVC];
     self.window.rootViewController=navVC;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    
}
@end
