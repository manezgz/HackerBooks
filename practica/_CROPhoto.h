// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CROPhoto.h instead.

#import <CoreData/CoreData.h>

extern const struct CROPhotoAttributes {
	__unsafe_unretained NSString *photo;
} CROPhotoAttributes;

extern const struct CROPhotoRelationships {
	__unsafe_unretained NSString *notes;
} CROPhotoRelationships;

@class CRONote;

@interface CROPhotoID : NSManagedObjectID {}
@end

@interface _CROPhoto : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CROPhotoID* objectID;

@property (nonatomic, strong) NSData* photo;

//- (BOOL)validatePhoto:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@end

@interface _CROPhoto (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(CRONote*)value_;
- (void)removeNotesObject:(CRONote*)value_;

@end

@interface _CROPhoto (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitivePhoto;
- (void)setPrimitivePhoto:(NSData*)value;

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

@end
