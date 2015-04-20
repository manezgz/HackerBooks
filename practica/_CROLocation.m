// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CROLocation.m instead.

#import "_CROLocation.h"

const struct CROLocationAttributes CROLocationAttributes = {
	.address = @"address",
	.latitude = @"latitude",
	.longitude = @"longitude",
};

const struct CROLocationRelationships CROLocationRelationships = {
	.notes = @"notes",
};

@implementation CROLocationID
@end

@implementation _CROLocation

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Location" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Location";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Location" inManagedObjectContext:moc_];
}

- (CROLocationID*)objectID {
	return (CROLocationID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic address;

@dynamic latitude;

@dynamic longitude;

@dynamic notes;

- (NSMutableSet*)notesSet {
	[self willAccessValueForKey:@"notes"];

	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"notes"];

	[self didAccessValueForKey:@"notes"];
	return result;
}

@end

