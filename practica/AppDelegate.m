//
//  AppDelegate.m
//  practica
//
//  Created by Jose Manuel Franco on 29/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "AppDelegate.h"
#import "CROLibraryTableViewController.h"
#import "BookViewController.h"
#import "CRODataHandler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Obtenemos el array con Obj JSON parseados
    CRODataHandler *dataHandler=[[CRODataHandler alloc]init];
    NSArray *arrayJSON=[dataHandler getJsonArray];
    
    //Bajamos imagenes si es necesario
    [dataHandler downloadImagesFromJSONArray:arrayJSON];
    
    //Creamos el modelo
    self.model=[dataHandler createModelFromJsonArray:(arrayJSON)];
    self.model.bookSelected=[dataHandler getInitialBook:(self.model)];
    
    //Configuramos la Universalidad de la Aplicacion
    if([[UIDevice currentDevice] userInterfaceIdiom] ==UIUserInterfaceIdiomPad){
        [self configureAppForIpadWithModel:(CROLibraryModel*)self.model];
    }else{
        [self configureAppForIphoneWithModel:(CROLibraryModel*)self.model];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    NSDictionary *dict=self.model.dictOfTags;
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:dict];
    [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"bookDictionary"];
    
    CROBook *bookSelected=self.model.bookSelected;
    NSData *dataBook = [NSKeyedArchiver archivedDataWithRootObject:bookSelected];
    [[NSUserDefaults standardUserDefaults] setObject:dataBook forKey:@"bookSelected"];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
     NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.model.dictOfTags];
     [[NSUserDefaults standardUserDefaults] setObject:data forKey:@"bookDictionary"];
    
    CROBook *bookSelected=self.model.bookSelected;
    NSData *dataBook = [NSKeyedArchiver archivedDataWithRootObject:bookSelected];
    [[NSUserDefaults standardUserDefaults] setObject:dataBook forKey:@"bookSelected"];
}

-(void) configureAppForIpadWithModel:(CROLibraryModel*)model{
    CROLibraryTableViewController *tableVC=[[CROLibraryTableViewController alloc]initWithLibrary:(model)
                                                                                       withStyle:UITableViewStylePlain];
    BookViewController *vcBook=[[BookViewController alloc]initWithBook:(model.bookSelected)];
    //Asignamos delegados
    tableVC.delegate=vcBook;
    
    
    UINavigationController *navLeft=[[UINavigationController alloc]initWithRootViewController:tableVC];
    UINavigationController *navRight=[[UINavigationController alloc]initWithRootViewController:vcBook];
    
    
    UISplitViewController *vcSplit=[[UISplitViewController alloc]init];
    vcSplit.delegate=vcBook;
    [vcSplit setViewControllers:(@[navLeft,navRight])];
    self.window.rootViewController = vcSplit;
}

-(void) configureAppForIphoneWithModel:(CROLibraryModel*)model{
    //Creamos el controlador
    CROLibraryTableViewController *tableVC=[[CROLibraryTableViewController alloc]initWithLibrary:(model)
                                                                                       withStyle:UITableViewStylePlain];
   
    //Creaoms el combinador
    UINavigationController *navVC=[[UINavigationController alloc]init];
    [navVC pushViewController:tableVC animated:(YES)];
    
    //Asiganamos delegados
    tableVC.delegate=tableVC;
    
    //Lo hacemos root
    self.window.rootViewController = navVC;
}

@end
