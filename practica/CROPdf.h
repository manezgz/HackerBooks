#import "_CROPdf.h"

@interface CROPdf : _CROPdf {}

@property(nonatomic) BOOL bookDownloaded;
+(instancetype) pdfWithUrl:(NSString *)name
                   context:(NSManagedObjectContext *) context;


-(void)downloadAndRelocatePdf;

@end
