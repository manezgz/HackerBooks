//
//  CRODataHandler.m
//  practica
//
//  Created by Jose Manuel Franco on 16/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CRODataHandler.h"
#import "CROBook.h"
#import "CROAuthor.h"
#import "CROTag.h"
#import "CROPdf.h"

@implementation CRODataHandler




#pragma mark -Interface Implementation

-(NSArray*) getJsonArray{
    NSArray *jsonArray=nil;
    NSData *data=nil;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [[paths objectAtIndex:0] stringByAppendingString:@"/"];
    NSString *jsonPath=[documentsDirectoryPath stringByAppendingString:@"json.json"];
    //Descargamos JSON
    [self downloadFileWithData:([NSURL URLWithString:@"https://t.co/K9ziV0z3SJ"])
                          withName:(jsonPath)];
            
    data=[NSData dataWithContentsOfURL:[NSURL fileURLWithPath:(jsonPath)]];
    if(data!=nil){
        NSError *error;
        jsonArray=[NSJSONSerialization JSONObjectWithData:data
                                                  options:kNilOptions
                                                    error:&error];
    }
    return jsonArray;
    
}


-(void) addJsonArray:(NSArray*)arrayJSON
   toCoreDataContext:(NSManagedObjectContext *)context{
    
    //Creamos el tag de favoritos
    [CROTag tagWithName:@"Favoritos"
                context:context];
    
    for (NSDictionary *dict in arrayJSON) {
        
        
        //Book
        CROBook *book=[CROBook bookWithTitle:([dict objectForKey:@"title"])
                           withUrlCoverImage:([dict objectForKey:@"image_url"])
                                     authors:(nil)
                       
                                     context:context];
        
        //Authors
        NSArray *authors =[self getObjectFromKey:(@"authors")
                                   andDictionary:(dict)];
        
        for(NSString *obj in authors){
            //Hacemos un trim a obj
            NSString *trimmedAuthor = [obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            CROAuthor *author=[CROAuthor authorWithName:trimmedAuthor
                                                context:context];
            [book addAuthorsObject:author];
        }
        
        //Pdf
        CROPdf *pdf=[CROPdf pdfWithUrl:[dict objectForKey:@"pdf_url"]
                               context:context];
        [book setPdf:pdf];
        
        //Tags
        NSArray *tags =[self getObjectFromKey:(@"tags")
                                andDictionary:(dict)];
        
        for(NSString *obj in tags){
            //Hacemos un trim a obj
            NSString *trimmedTag = [obj stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            CROTag *tag=[CROTag tagWithName:trimmedTag
                                    context:context];
            [book addTagsObject:tag];
        }
    }
    //Hacemos fetch de los tags
     NSFetchRequest *req = [NSFetchRequest fetchRequestWithEntityName:[CROAuthor entityName]];
    NSArray *array = [context executeFetchRequest:req error:nil];
    for(CROAuthor *author in array){
        NSLog(@"%@",author.name);
    }
    
    
}
   
#pragma mark -Class Internal
-(void) downloadFileWithData:(NSURL*)urlData
                    withName:(NSString*)name{
    
    NSData *data=[[NSData alloc ]initWithContentsOfURL:urlData];
    [data writeToFile:(name) atomically:YES];
}
    
    
-(NSArray*) getObjectFromKey:(NSString*) key
               andDictionary:(NSDictionary*)dictionary{
    
    NSString *value=[dictionary objectForKey:key];
    return [value componentsSeparatedByString:@","];
}



@end
