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
}
@property (weak, nonatomic) IBOutlet UILabel *imgLabelBackground;
@property (weak, nonatomic) IBOutlet UILabel *imgLabel;
@property (strong, nonatomic) IBOutlet UILabel *buttonview;
@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;
@property UIImage *nextImage;
@property NSMutableArray* objectIDs;
@property bool firstImageLoaded;
@property NSString *currentImageID;
@property NSString *nextImageID;

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer;
@end
