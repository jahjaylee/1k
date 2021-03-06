//
//  ViewController.h
//  1k
//
//  Created by Jay Lee on 4/2/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController{
    NSMutableArray *images;
    int count;
    CGRect centered;
    UIColor *overlayColor;
    UIImageView *startImage;
    UILabel *fade;
}
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
@end
