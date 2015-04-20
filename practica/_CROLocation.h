// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CROLocation.h instead.

#import <CoreData/CoreData.h>

extern const struct CROLocationAttributes {
	__unsafe_unretained NSString *address;
	__unsafe_unretained NSString *latitude;
	__unsafe_unretained NSString *longitude;
} CROLocationAttributes;

extern const struct CROLocationRelationships {
	__unsafe_unretained NSString *notes;
} CROLocationRelationships;

@class CRONote;

@interface CROLocationID : NSManagedObjectID {}
@end

@interface _CROLocation : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CROLocationID* objectID;

@property (nonatomic, strong) NSString* address;

//- (BOOL)validateAddress:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* latitude;

//- (BOOL)validateLatitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* longitude;

//- (BOOL)validateLongitude:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@end

@interface _CROLocation (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(CRONote*)value_;
- (void)removeNotesObject:(CRONote*)value_;

@end

@interface _CROLocation (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveAddress;
- (void)setPrimitiveAddress:(NSString*)value;

- (NSString*)primitiveLatitude;
- (void)setPrimitiveLatitude:(NSString*)value;

- (NSString*)primitiveLongitude;
- (void)setPrimitiveLongitude:(NSString*)value;

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

@end
