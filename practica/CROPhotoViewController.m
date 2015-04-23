//
//  CROPhotoViewController.m
//  practica
//
//  Created by Jose Manuel Franco on 22/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import "CROPhotoViewController.h"

@interface CROPhotoViewController ()

@property (nonatomic, strong) CROPhoto *photo;

@end

@implementation CROPhotoViewController

-(instancetype) initWithPhoto:(CROPhoto*)photo{
    if(self==[super initWithNibName:nil
                             bundle:nil]){
        
        _photo=photo;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.photoImageView.image=[UIImage imageWithData:self.photo.photo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)takePicture:(id)sender {
    UIImagePickerController *picker = [UIImagePickerController new];
    
    // configurar
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        // Crear uipicker
        UIImagePickerController *picker = [UIImagePickerController new];
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.delegate = self;
        
        // mostrar
        [self presentViewController:picker
                           animated:YES
                         completion:^{
                             //
                         }];
    }else{
        NSLog(@"Camara no disponible");
    }
}

- (IBAction)getImageFromDevice:(id)sender {
    
    // Crear uipicker
    UIImagePickerController *picker = [UIImagePickerController new];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    
    // mostrar
    [self presentViewController:picker
                       animated:YES
                     completion:^{
                         //
                     }];
}

- (IBAction)deleteImage:(id)sender {
    UIImage *image=[UIImage imageNamed:@"noImage"];
    self.photo.photo=UIImageJPEGRepresentation(image,0.9);
    self.photoImageView.image=image;
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    NSData *data=UIImageJPEGRepresentation([info objectForKey:UIImagePickerControllerOriginalImage],0.9);
    self.photo.photo =data;
    [self dismissViewControllerAnimated:YES
                             completion:^{
                                 NSLog(@"Imagen desechada");
                             }];
    
    
}
@end
