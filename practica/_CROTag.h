// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CROTag.h instead.

#import <CoreData/CoreData.h>

extern const struct CROTagAttributes {
	__unsafe_unretained NSString *tagName;
} CROTagAttributes;

extern const struct CROTagRelationships {
	__unsafe_unretained NSString *books;
} CROTagRelationships;

@class CROBook;

@interface CROTagID : NSManagedObjectID {}
@end

@interface _CROTag : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CROTagID* objectID;

@property (nonatomic, strong) NSString* tagName;

//- (BOOL)validateTagName:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *books;

- (NSMutableSet*)booksSet;

@end

@interface _CROTag (BooksCoreDataGeneratedAccessors)
- (void)addBooks:(NSSet*)value_;
- (void)removeBooks:(NSSet*)value_;
- (void)addBooksObject:(CROBook*)value_;
- (void)removeBooksObject:(CROBook*)value_;

@end

@interface _CROTag (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveTagName;
- (void)setPrimitiveTagName:(NSString*)value;

- (NSMutableSet*)primitiveBooks;
- (void)setPrimitiveBooks:(NSMutableSet*)value;

@end
