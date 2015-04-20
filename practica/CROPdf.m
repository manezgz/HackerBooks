#import "CROPdf.h"

@interface CROPdf ()

// Private interface goes here.

@end

@implementation CROPdf

@synthesize bookDownloaded;

+(instancetype) pdfWithUrl:(NSString *)url
                   context:(NSManagedObjectContext *) context{
    CROPdf *pdf=[NSEntityDescription insertNewObjectForEntityForName:[CROPdf entityName]
                                              inManagedObjectContext:context];
    pdf.url=url;
    return pdf;
}





@end
