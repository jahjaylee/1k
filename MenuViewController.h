//
//  MenuViewController.h
//  1k
//
//  Created by Chip Schaff on 4/10/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FlatUIKit.h"

@interface MenuViewController : UIViewController
@property FUIButton* b1;
@property FUIButton* b2;
@property FUIButton* b3;
@property FUIButton* b4;
-(void)segue:(id)sender;
@end
