// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CROBook.m instead.

#import "_CROBook.h"

const struct CROBookAttributes CROBookAttributes = {
	.coverImage = @"coverImage",
	.coverImageURL = @"coverImageURL",
	.favorite = @"favorite",
	.title = @"title",
};

const struct CROBookRelationships CROBookRelationships = {
	.authors = @"authors",
	.notes = @"notes",
	.pdf = @"pdf",
	.tags = @"tags",
};

@implementation CROBookID
@end

@implementation _CROBook

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Book" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Book";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Book" inManagedObjectContext:moc_];
}

- (CROBookID*)objectID {
	return (CROBookID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	if ([key isEqualToString:@"favoriteValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"favorite"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
		return keyPaths;
	}

	return keyPaths;
}

@dynamic coverImage;

@dynamic coverImageURL;

@dynamic favorite;

- (BOOL)favoriteValue {
	NSNumber *result = [self favorite];
	return [result boolValue];
}

- (void)setFavoriteValue:(BOOL)value_ {
	[self setFavorite:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitiveFavoriteValue {
	NSNumber *result = [self primitiveFavorite];
	return [result boolValue];
}

- (void)setPrimitiveFavoriteValue:(BOOL)value_ {
	[self setPrimitiveFavorite:[NSNumber numberWithBool:value_]];
}

@dynamic title;

@dynamic authors;

- (NSMutableSet*)authorsSet {
	[self willAccessValueForKey:@"authors"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"authors"];

	[self didAccessValueForKey:@"authors"];
	return result;
}

@dynamic notes;

- (NSMutableSet*)notesSet {
	[self willAccessValueForKey:@"notes"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"notes"];

	[self didAccessValueForKey:@"notes"];
	return result;
}

@dynamic pdf;

@dynamic tags;

- (NSMutableSet*)tagsSet {
	[self willAccessValueForKey:@"tags"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"tags"];

	[self didAccessValueForKey:@"tags"];
	return result;
}

@end

