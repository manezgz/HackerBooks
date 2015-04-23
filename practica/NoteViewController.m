//
//  NoteViewController.m
//  practica
//
//  Created by Jose Manuel Franco on 18/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "NoteViewController.h"
#import "CROPhotoViewController.h"

@interface NoteViewController ()
@property (nonatomic) BOOL new;
@property (nonatomic) BOOL deleteNote;

@end

@implementation NoteViewController

-(instancetype) initWithNote:(CRONote*)note{
    
    if (self = [super initWithNibName:nil
                               bundle:nil]) {
        self.note=note;
    }
    return self;
}

-(instancetype) initForNewNoteInBook:(CROBook*)book{
    
    CRONote *note = [CRONote noteWithTitle:@"Insert Title"
                                  withText:@"Insert Text"
                              inPageNumber:nil
                                   context:book.managedObjectContext];
    
    [book addNotesObject:note];
    
    return [self initWithNote:note];
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.noteView.layer setBorderColor:[[[UIColor grayColor] colorWithAlphaComponent:0.5] CGColor]];
    [self.noteView.layer setBorderWidth:2.0];
    
    //The rounded corner part, where you specify your view's corner radius:
    self.noteView.layer.cornerRadius=5;
    self.noteView.clipsToBounds = YES;
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //Sync modelo y vista
    NSDateFormatter *fmt=[NSDateFormatter new];
    fmt.dateStyle=NSDateFormatterLongStyle;
    self.modificationDateLabel.text=[fmt stringFromDate:self.note.modificationDate];
    self.noteTitleView.text=self.note.title;
    self.noteView.text=self.note.noteText;
    
    NSData *imgData=self.note.photo.photo;
    if(imgData!=nil){
        UIImage *img=[UIImage imageWithData:imgData];
        self.imageView.image=img;
    }
    
    if (self.new) {
        // Add the cancel button
        UIBarButtonItem *cancel = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                                                target:self
                                                                                action:@selector(cancel:)];
        self.navigationItem.rightBarButtonItem = cancel;
    }
    
    // Añadimos un gesture recognizer a la foto
    self.imageView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(displayDetailPhoto:)];
    [self.imageView addGestureRecognizer:tap];
    
    
}

-(void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    
    if (self.deleteNote) {
        [self.note.managedObjectContext deleteObject:self.note];
    }else{
        // vista -> modelo
        self.note.noteText = self.noteView.text;
        self.note.title=self.noteTitleView.text;
        NSData *data=UIImageJPEGRepresentation(self.imageView.image, 0.9);
        self.note.photo.photo = data;
        self.note.modificationDate =[NSDate date];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Utils
-(void) cancel:(id)sender{
    self.deleteNote = YES;
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Actions
-(void)displayDetailPhoto:(id) sender{
    
    NSLog(@"Tap in Image");
    CROPhotoViewController *pVC = [[CROPhotoViewController alloc] initWithPhoto:self.note.photo];
    
    [self.navigationController pushViewController:pVC
                                         animated:YES];
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
