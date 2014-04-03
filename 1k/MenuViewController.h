//
//  MenuViewController.h
//  1k
//
//  Created by Chip Schaff on 4/2/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIPickerView *picker;
@property NSArray *catagories;

@end
