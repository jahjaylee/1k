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
#import "MLIMGURUploader.h"

@interface UploadViewController : UIViewController<AssetsAccessorDelegate, MyImagePickerControllerDelegate, UITextFieldDelegate> {
    AssetsAccessor *assetsAccessor;
    NSURL *imageURL;
}
@property (strong, nonatomic) IBOutlet UILabel *l1;
@property (strong, nonatomic) IBOutlet UIButton *l3;

@property (strong, nonatomic) IBOutlet UIButton *l2;

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionTextField;
@property (weak, nonatomic) IBOutlet UILabel *linkTextView;

@property UIImage *uploadImage;

@end
