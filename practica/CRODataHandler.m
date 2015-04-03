//
//  CRODataHandler.m
//  practica
//
//  Created by Jose Manuel Franco on 3/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CRODataHandler.h"

@implementation CRODataHandler

#pragma mark -Class Internal
-(void)downloadFileWithData:(NSURL*)urlData
                   withName:(NSString*)name{
    
    NSData *data=[[NSData alloc ]initWithContentsOfURL:urlData];
    [data writeToFile:(name) atomically:YES];
}

-(void)addBook:(CROBook*)book
  toDictionary:(NSMutableDictionary*)dictionary{
    
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

-(NSArray*) getObjectFromKey:(NSString*) key
               andDictionary:(NSDictionary*)dictionary{
    
    NSString *value=[dictionary objectForKey:key];
    return [value componentsSeparatedByString:@","];
}

NSInteger mySort( NSString *section1, NSString *section2, void *context){
    
    if ([section1 isEqualToString:(@"Favorites")]){
        return NSOrderedAscending;
    }else if ([section2 isEqualToString:@"Favorites"]){
        return NSOrderedDescending;
    }else{
        return [section1 compare:section2];
    }
}

#pragma mark -Interface Implementation

-(NSArray*) getJsonArray{
    NSArray *jsonArray=nil;
    NSData *data=nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingString:@"/"];
    NSString *jsonPath=[documentsDirectoryPath stringByAppendingString:@"json.json"];
    //Comprobamos si ya tenemos descargado el JSON y sino lo descargamos
    if(![[NSUserDefaults standardUserDefaults]boolForKey:JSON_DOWNLOADED]){
        //Tenemos que descargar el json
        [self downloadFileWithData:([NSURL URLWithString:@"https://t.co/K9ziV0z3SJ"])
                          withName:(jsonPath)];
        //Seteamos en NUsersDefault JsonDownloaded a true
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:JSON_DOWNLOADED];
    }
    
    data=[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:(jsonPath)]];
    if(data!=nil){
        NSError *error;
        jsonArray=[NSJSONSerialization JSONObjectWithData:data
                                                  options:kNilOptions
                                                    error:&error];
    }
    return jsonArray;

}

-(void) downloadImagesFromJSONArray:(NSArray*)arrayOfBooks{
    //Descargamos Imagenes sino están descargada
    if(![[NSUserDefaults standardUserDefaults]boolForKey:IMAGES_DOWNLOADED]){
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingString:@"/"];
        for (id obj in arrayOfBooks) {
            if([obj isKindOfClass:[NSDictionary class]]){
                NSDictionary *dictionary=(NSDictionary*)obj;
                
                NSString *imageName =[[[dictionary objectForKey:@"image_url"]componentsSeparatedByString:@"/"]lastObject];
                NSString *imagePath =[documentsDirectoryPath stringByAppendingString:imageName];
                //Tenemos que descargar la imagen
                [self downloadFileWithData:([NSURL URLWithString:([dictionary objectForKey:@"image_url"])])
                                  withName:(imagePath)];
                
            }
        }
        //Seteamos en NUsersDefault ImagesDownlaoded a true
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:IMAGES_DOWNLOADED];
    }
}

-(CROLibraryModel*) createModelFromJsonArray:(NSArray*)arrayOfBooks{
    NSMutableDictionary *auxDictionary=nil;
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:(@"bookDictionary")]!=nil){
        auxDictionary=[NSKeyedUnarchiver unarchiveObjectWithData:([[NSUserDefaults standardUserDefaults]objectForKey:(@"bookDictionary")])];
        
        //Nos falta que actualicemos la ruta de las imagenes a las ruta del simulador actual ya que esta va cambiando
                       
    }else{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingString:@"/"];
        auxDictionary=[[NSMutableDictionary alloc]init];
        //Añadimos la categoria de favoritos al diccionario
        NSMutableArray *arrayFavorites=[[NSMutableArray alloc]init];
        [auxDictionary setObject:arrayFavorites forKey:@"Favorites"];
        
        for (id obj in arrayOfBooks) {
            if([obj isKindOfClass:[NSDictionary class]]){
                NSDictionary *dictionary=(NSDictionary*)obj;
                
                NSString *imageName =[[[dictionary objectForKey:@"image_url"]componentsSeparatedByString:@"/"]lastObject];
                NSString *imagePath =[documentsDirectoryPath stringByAppendingString:imageName];
                
                //Creamos el libro
                CROBook *book=[[CROBook alloc]initWithTitle:[dictionary objectForKey:(@"title")]
                                               withImageURL:([NSURL fileURLWithPath:(imagePath)])
                                                 withPDFURL:([NSURL URLWithString:([dictionary objectForKey:@"pdf_url"])])
                                                withAuthors:[self getObjectFromKey:(@"authors") andDictionary:(dictionary)]
                                                   withTags:[self getObjectFromKey:(@"tags") andDictionary:(dictionary)]
                                               withFavorite:(NO)];
                
                //Añadimos el libro al diccionario
                [self addBook:(book) toDictionary:(auxDictionary)];
                
            }
        }
    }
    
    
    //Creamos un array con las categorias ordenadas
    NSArray *arrayOfTags=[auxDictionary allKeys];
    //Ordenamos el array de las categorias
    arrayOfTags= [arrayOfTags sortedArrayUsingFunction:mySort context:NULL];
    
    return [[CROLibraryModel alloc]initWithArray:arrayOfTags withDictionary:auxDictionary];

}

-(CROBook*) getInitialBook:(CROLibraryModel*)model{
    CROBook *book=nil;
    if([[NSUserDefaults standardUserDefaults]objectForKey:(@"bookSelected")]!=nil){
        book=[NSKeyedUnarchiver unarchiveObjectWithData:([[NSUserDefaults standardUserDefaults]objectForKey:(@"bookSelected")])];
    }else{
        if([[model.dictOfTags objectForKey:@"Favorites"] count]>0){
            book=[[model.dictOfTags objectForKey:@"Favorites"] firstObject];
        }else{
            NSString *defaultTag=[model.arrayOfTagsSorted objectAtIndex:1];
            book=[[model.dictOfTags objectForKey:(defaultTag)]firstObject];
        }
    }
    return book;
}




@end
