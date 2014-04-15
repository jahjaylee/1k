//
//  UploadViewController.h
//  1k
//
//  Created by Chip Schaff on 4/10/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AssetsAccessor.h"
#import "TableViewController.h"
#import "CollectionViewController.h"

@interface UploadViewController : UIViewController<AssetsAccessorDelegate, MyImagePickerControllerDelegate> {
    AssetsAccessor *assetsAccessor;
    NSURL *imageURL;
}


@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;

@end
