//
//  CategoryViewController.h
//  1k
//
//  Created by Chip Schaff on 4/10/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CategoryViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property NSArray *categories;
@end