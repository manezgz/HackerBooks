//
//  CRONoteCellView.m
//  practica
//
//  Created by Jose Manuel Franco on 20/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CRONoteCellView.h"

#import "CRONote.h"
#import "CROPhoto.h"

@interface CRONoteCellView ()
@property (strong, nonatomic) CRONote* note;
@end
@implementation CRONoteCellView

+(NSArray*) keys{
    return @[@"photo.photo", @"title", @"modificationDate"];
}
-(void) observeNote:(CRONote *) note{
    
    self.note = note;
    
    for (NSString *key in [CRONoteCellView keys]) {
        [self.note addObserver:self
                    forKeyPath:key
                       options:NSKeyValueObservingOptionNew
                       context:NULL];
    }
    
    [self syncWithNote];
    
}


-(void) prepareForReuse{
    
    for (NSString *key in [CRONoteCellView keys]) {
        [self.note removeObserver:self forKeyPath:key];
        
    }
    self.note = nil;
    [self syncWithNote];
}

-(void)observeValueForKeyPath:(NSString *)keyPath
                     ofObject:(id)object
                       change:(NSDictionary *)change
                      context:(void *)context{
    
    [self syncWithNote];
    
    
    
}

-(void) syncWithNote{
    self.titleView.text = self.note.title;
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateStyle = NSDateFormatterMediumStyle;
    self.modificationDateView.text = [fmt stringFromDate:self.note.modificationDate];
    self.photoView.image = [UIImage imageWithData:self.note.photo.photo];
    
}




@end
