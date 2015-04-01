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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];
    
    //Desgargamos el JSON de la URL Proporcionada
    NSData *data=[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://t.co/K9ziV0z3SJ"]];
    if(data!=nil){
        NSError *error;
        NSArray *jsonArray=[NSJSONSerialization JSONObjectWithData:data
                                                           options:kNilOptions
                                                             error:&error];
        
        [self downloadImagesAndPdfsFromArrayOfBooks:jsonArray];
    }
    CROLibraryTableViewController *tableVC=[[CROLibraryTableViewController alloc]initWithLibrary:(self.library)
                                                                                       withStyle:UITableViewStylePlain];
    BookViewController *vcBook=[[BookViewController alloc]initWithBook:([self.library.books objectAtIndex:0])];
    //Asignamos delegados
    tableVC.delegate=vcBook;
    
    
    UINavigationController *navLeft=[[UINavigationController alloc]initWithRootViewController:tableVC];
    UINavigationController *navRight=[[UINavigationController alloc]initWithRootViewController:vcBook];

    
    UISplitViewController *vcSplit=[[UISplitViewController alloc]init];
    [vcSplit setViewControllers:(@[navLeft,navRight])];
    self.window.rootViewController = vcSplit;
    
    //Inicializamos el modelo con el array de books
    NSLog(@"Number is %ld",(long)[self.library.books count]);
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

-(void) downloadImagesAndPdfsFromArrayOfBooks:(NSArray*)arrayOfBooks{
    NSFileManager *fm=[NSFileManager defaultManager];
    //NSString *pathCacheDir=[[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)] objetAtIndex:0];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingString:@"/"];
    NSMutableArray *auxArray=[[NSMutableArray alloc]init];
    NSMutableDictionary *auxDictioanry=[[NSMutableDictionary alloc]init];
    
    for (id obj in arrayOfBooks) {
        if([obj isKindOfClass:[NSDictionary class]]){
            NSDictionary *dictionary=(NSDictionary*)obj;
            
            NSString *imageName =[[[dictionary objectForKey:@"image_url"]componentsSeparatedByString:@"/"]lastObject];
            NSString *imagePath =[documentsDirectoryPath stringByAppendingString:imageName];
            
            
            //Descargamos Imagen
            [self downloadFileWithData:([NSURL URLWithString:([dictionary objectForKey:@"image_url"])])
                              withName:(imagePath)];
            
            //Creamos el libro
            CROBook *book=[[CROBook alloc]initWithTitle:[dictionary objectForKey:(@"title")]
                                           withImageURL:([NSURL fileURLWithPath:(imagePath)])
                                           withPDFURL:([NSURL URLWithString:([dictionary objectForKey:@"pdf_url"])])
                                            withAuthors:[self getObjectFromKey:(@"authors") andDictionary:(dictionary)]
                                               withTags:[self getObjectFromKey:(@"tags") andDictionary:(dictionary)]];
            
            //Añadimos el libro al array
            [auxArray addObject:book];
            [self addBook:(book) toDictionary:(auxDictioanry)];
            
        }
    }
    
    self.library= [[CROLibraryModel alloc]initWithArray:auxArray withDictionary:auxDictioanry];
    
}

-(void)downloadFileWithData:(NSURL*)urlData
                   withName:(NSString*)name{
    
    NSData *data=[[NSData alloc ]initWithContentsOfURL:urlData];
    [data writeToFile:(name) atomically:YES];
}

-(NSArray*) getObjectFromKey:(NSString*) key andDictionary:(NSDictionary*)dictionary{
    NSString *value=[dictionary objectForKey:key];
    return [value componentsSeparatedByString:@","];
}

-(void)addBook:(CROBook*)book toDictionary:(NSMutableDictionary*)dictionary{
    for(NSString *tag in book.tags){
        NSString *tagNormalized=[tag stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if ([dictionary objectForKey:tagNormalized]==nil){
            NSMutableArray *array=[[NSMutableArray alloc]init];
            [array addObject:book];
            [dictionary setObject:array forKey:tagNormalized];
        }else{
            NSMutableArray *array=[dictionary objectForKey:tagNormalized];
            [array addObject:book];
            [dictionary setObject:array forKey:tagNormalized];
        }
    }
}

@end
