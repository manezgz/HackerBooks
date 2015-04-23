//
//  CROPhotoViewController.h
//  practica
//
//  Created by Jose Manuel Franco on 22/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CROPhoto.h"

@interface CROPhotoViewController : UIViewController<UINavigationControllerDelegate,UIImagePickerControllerDelegate>

-(instancetype) initWithPhoto:(CROPhoto*)photo;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;

@end
