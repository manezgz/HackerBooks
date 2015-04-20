// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CROPdf.h instead.

#import <CoreData/CoreData.h>

extern const struct CROPdfAttributes {
	__unsafe_unretained NSString *binData;
	__unsafe_unretained NSString *url;
} CROPdfAttributes;

extern const struct CROPdfRelationships {
	__unsafe_unretained NSString *book;
} CROPdfRelationships;

@class CROBook;

@interface CROPdfID : NSManagedObjectID {}
@end

@interface _CROPdf : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CROPdfID* objectID;

@property (nonatomic, strong) NSData* binData;

//- (BOOL)validateBinData:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* url;

//- (BOOL)validateUrl:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) CROBook *book;

//- (BOOL)validateBook:(id*)value_ error:(NSError**)error_;

@end

@interface _CROPdf (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveBinData;
- (void)setPrimitiveBinData:(NSData*)value;

- (NSString*)primitiveUrl;
- (void)setPrimitiveUrl:(NSString*)value;

- (CROBook*)primitiveBook;
- (void)setPrimitiveBook:(CROBook*)value;

@end
