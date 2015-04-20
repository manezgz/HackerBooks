// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to CROPdf.m instead.

#import "_CROPdf.h"

const struct CROPdfAttributes CROPdfAttributes = {
	.binData = @"binData",
	.url = @"url",
};

const struct CROPdfRelationships CROPdfRelationships = {
	.book = @"book",
};

@implementation CROPdfID
@end

@implementation _CROPdf

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pdf" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pdf";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pdf" inManagedObjectContext:moc_];
}

- (CROPdfID*)objectID {
	return (CROPdfID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];

	return keyPaths;
}

@dynamic binData;

@dynamic url;

@dynamic book;

@end

