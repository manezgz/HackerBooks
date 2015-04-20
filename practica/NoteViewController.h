//
//  NoteViewController.h
//  practica
//
//  Created by Jose Manuel Franco on 18/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import<MapKit/MapKit.h>
#import "CROBook.h"
#import "CRONote.h"
#import "CROPhoto.h"

@interface NoteViewController : UIViewController

@property(weak,nonatomic) IBOutlet UITextField *noteTitleView;
@property(weak,nonatomic) IBOutlet UITextView *noteView;
@property (weak, nonatomic) IBOutlet UILabel *modificationDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(strong,nonatomic) CRONote *note;

-(instancetype) initForNewNoteInBook:(CROBook*)book;
-(instancetype) initWithNote:(CRONote*)note;

@end
