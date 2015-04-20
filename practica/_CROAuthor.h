// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CROAuthor.h instead.

#import <CoreData/CoreData.h>

extern const struct CROAuthorAttributes {
	__unsafe_unretained NSString *name;
} CROAuthorAttributes;

extern const struct CROAuthorRelationships {
	__unsafe_unretained NSString *books;
} CROAuthorRelationships;

@class CROBook;

@interface CROAuthorID : NSManagedObjectID {}
@end

@interface _CROAuthor : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CROAuthorID* objectID;

@property (nonatomic, strong) NSString* name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _CROAuthor (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(CROBook*)value_;
- (void)removeBooksObject:(CROBook*)value_;

@end

@interface _CROAuthor (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
