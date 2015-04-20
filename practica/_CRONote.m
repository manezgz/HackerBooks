// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CRONote.m instead.

#import "_CRONote.h"

const struct CRONoteAttributes CRONoteAttributes = {
	.creationDate = @"creationDate",
	.modificationDate = @"modificationDate",
	.noteText = @"noteText",
	.pageNumber = @"pageNumber",
	.title = @"title",
};

const struct CRONoteRelationships CRONoteRelationships = {
	.books = @"books",
	.location = @"location",
	.photo = @"photo",
};

@implementation CRONoteID
@end

@implementation _CRONote

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Note" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Note";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Note" inManagedObjectContext:moc_];
}

- (CRONoteID*)objectID {
	return (CRONoteID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"pageNumberValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"pageNumber"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic creationDate;

@dynamic modificationDate;

@dynamic noteText;

@dynamic pageNumber;

- (int16_t)pageNumberValue {
	NSNumber *result = [self pageNumber];
	return [result shortValue];
}

- (void)setPageNumberValue:(int16_t)value_ {
	[self setPageNumber:[NSNumber numberWithShort:value_]];
}

- (int16_t)primitivePageNumberValue {
	NSNumber *result = [self primitivePageNumber];
	return [result shortValue];
}

- (void)setPrimitivePageNumberValue:(int16_t)value_ {
	[self setPrimitivePageNumber:[NSNumber numberWithShort:value_]];
}

@dynamic title;

@dynamic books;

@dynamic location;

@dynamic photo;

@end

