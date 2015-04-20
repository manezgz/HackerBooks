// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CROBook.h instead.

#import <CoreData/CoreData.h>

extern const struct CROBookAttributes {
	__unsafe_unretained NSString *coverImage;
	__unsafe_unretained NSString *coverImageURL;
	__unsafe_unretained NSString *favorite;
	__unsafe_unretained NSString *title;
} CROBookAttributes;

extern const struct CROBookRelationships {
	__unsafe_unretained NSString *authors;
	__unsafe_unretained NSString *notes;
	__unsafe_unretained NSString *pdf;
	__unsafe_unretained NSString *tags;
} CROBookRelationships;

@class CROAuthor;
@class CRONote;
@class CROPdf;
@class CROTag;

@interface CROBookID : NSManagedObjectID {}
@end

@interface _CROBook : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
@property (nonatomic, readonly, strong) CROBookID* objectID;

@property (nonatomic, strong) NSData* coverImage;

//- (BOOL)validateCoverImage:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* coverImageURL;

//- (BOOL)validateCoverImageURL:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSNumber* favorite;

@property (atomic) BOOL favoriteValue;
- (BOOL)favoriteValue;
- (void)setFavoriteValue:(BOOL)value_;

//- (BOOL)validateFavorite:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSString* title;

//- (BOOL)validateTitle:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *authors;

- (NSMutableSet*)authorsSet;

@property (nonatomic, strong) NSSet *notes;

- (NSMutableSet*)notesSet;

@property (nonatomic, strong) CROPdf *pdf;

//- (BOOL)validatePdf:(id*)value_ error:(NSError**)error_;

@property (nonatomic, strong) NSSet *tags;

- (NSMutableSet*)tagsSet;

@end

@interface _CROBook (AuthorsCoreDataGeneratedAccessors)
- (void)addAuthors:(NSSet*)value_;
- (void)removeAuthors:(NSSet*)value_;
- (void)addAuthorsObject:(CROAuthor*)value_;
- (void)removeAuthorsObject:(CROAuthor*)value_;

@end

@interface _CROBook (NotesCoreDataGeneratedAccessors)
- (void)addNotes:(NSSet*)value_;
- (void)removeNotes:(NSSet*)value_;
- (void)addNotesObject:(CRONote*)value_;
- (void)removeNotesObject:(CRONote*)value_;

@end

@interface _CROBook (TagsCoreDataGeneratedAccessors)
- (void)addTags:(NSSet*)value_;
- (void)removeTags:(NSSet*)value_;
- (void)addTagsObject:(CROTag*)value_;
- (void)removeTagsObject:(CROTag*)value_;

@end

@interface _CROBook (CoreDataGeneratedPrimitiveAccessors)

- (NSData*)primitiveCoverImage;
- (void)setPrimitiveCoverImage:(NSData*)value;

- (NSString*)primitiveCoverImageURL;
- (void)setPrimitiveCoverImageURL:(NSString*)value;

- (NSNumber*)primitiveFavorite;
- (void)setPrimitiveFavorite:(NSNumber*)value;

- (BOOL)primitiveFavoriteValue;
- (void)setPrimitiveFavoriteValue:(BOOL)value_;

- (NSString*)primitiveTitle;
- (void)setPrimitiveTitle:(NSString*)value;

- (NSMutableSet*)primitiveAuthors;
- (void)setPrimitiveAuthors:(NSMutableSet*)value;

- (NSMutableSet*)primitiveNotes;
- (void)setPrimitiveNotes:(NSMutableSet*)value;

- (CROPdf*)primitivePdf;
- (void)setPrimitivePdf:(CROPdf*)value;

- (NSMutableSet*)primitiveTags;
- (void)setPrimitiveTags:(NSMutableSet*)value;

@end
