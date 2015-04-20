//
//  CRONoteCellView.h
//  practica
//
//  Created by Jose Manuel Franco on 20/4/15.
//  Copyright (c) 2015 Jose Manuel Franco. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CRONote;

@interface CRONoteCellView : UICollectionViewCell

@property (weak,nonatomic) IBOutlet UIImageView *photoView;
@property (weak,nonatomic) IBOutlet UILabel *modificationDateView;
@property (weak,nonatomic) IBOutlet UILabel *titleView;

-(void) observeNote:(CRONote *) note;

@end
