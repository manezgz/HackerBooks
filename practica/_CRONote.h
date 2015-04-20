// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CRONote.h instead.

#import <CoreData/CoreData.h>

extern const struct CRONoteAttributes {
	__unsafe_unretained NSString *creationDate;
	__unsafe_unretained NSString *modificationDate;
	__unsafe_unretained NSString *noteText;
	__unsafe_unretained NSString *pageNumber;
	__unsafe_unretained NSString *title;
} CRONoteAttributes;

extern const struct CRONoteRelationships {
	__unsafe_unretained NSString *books;
	__unsafe_unretained NSString *location;
	__unsafe_unretained NSString *photo;
} CRONoteRelationships;

@class CROBook;
@class CROLocation;
@class CROPhoto;

@interface CRONoteID : NSManagedObjectID {}
@end

@interface _CRONote : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CRONoteID* objectID;

@property (nonatomic, strong) NSDate* creationDate;

//- (BOOL)validateCreationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSDate* modificationDate;

//- (BOOL)validateModificationDate:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* noteText;

//- (BOOL)validateNoteText:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* pageNumber;

@property (atomic) int16_t pageNumberValue;
- (int16_t)pageNumberValue;
- (void)setPageNumberValue:(int16_t)value_;

//- (BOOL)validatePageNumber:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) CROBook *books;

//- (BOOL)validateBooks:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) CROLocation *location;

//- (BOOL)validateLocation:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) CROPhoto *photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@end

@interface _CRONote (CoreDataGeneratedPrimitiveAccessors)

- (NSDate*)primitiveCreationDate;
- (void)setPrimitiveCreationDate:(NSDate*)value;

- (NSDate*)primitiveModificationDate;
- (void)setPrimitiveModificationDate:(NSDate*)value;

- (NSString*)primitiveNoteText;
- (void)setPrimitiveNoteText:(NSString*)value;

- (NSNumber*)primitivePageNumber;
- (void)setPrimitivePageNumber:(NSNumber*)value;

- (int16_t)primitivePageNumberValue;
- (void)setPrimitivePageNumberValue:(int16_t)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (CROBook*)primitiveBooks;
- (void)setPrimitiveBooks:(CROBook*)value;

- (CROLocation*)primitiveLocation;
- (void)setPrimitiveLocation:(CROLocation*)value;

- (CROPhoto*)primitivePhoto;
- (void)setPrimitivePhoto:(CROPhoto*)value;

@end
