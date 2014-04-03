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
}
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
@end
