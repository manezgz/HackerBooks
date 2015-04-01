//
//  AppDelegate.h
//  practica
//
//  Created by Jose Manuel Franco on 29/3/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CROLibraryModel.h"

#define JSON_DOWNLOADED @"JSON_DOWNLOADED"
#define IMAGES_DOWNLOADED @"IMAGES_DOWNLOADED"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) CROLibraryModel *model;


@end

