//
//  ViewController.m
//  1k
//
//  Created by Jay Lee on 4/2/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

/**
 Notes:
 Think about orientation changes.
 Online swiping libraries?
 Examine reddit and imgur API's
 
 
 **/
#import <Parse/Parse.h>
#import "ViewController.h"
#import "FUIAlertView.h"
#import "FUIButton.h"
#import "UIColor+FlatUI.h"
#import "UIFont+FlatUI.h"
#import <QuartzCore/QuartzCore.h>
#import "FlatUIKit.h"

@interface ViewController ()

@end

@implementation ViewController
@synthesize firstImageLoaded;
@synthesize nextTitle;

bool xSwipe = false;
bool ySwipe = false;
bool alertShown = false;

- (void)viewDidLoad
{
    _imgLabel.hidden = false;
    _imgLabelBackground.hidden = false;
    _imgLabel.alpha = 0;
    _imgLabelBackground.alpha = 0;
    [super viewDidLoad];
    self.objectIDs = [NSMutableArray array];
    [self updateObjectIDs];
    firstImageLoaded = NO;
    self.view.backgroundColor = [UIColor wetAsphaltColor];
    [UIBarButtonItem configureFlatButtonsWithColor:[UIColor carrotColor]
                                  highlightedColor:[UIColor midnightBlueColor]
                                      cornerRadius:3];
    
    images = [[NSMutableArray alloc] init];
    count = 0;
    [self.navigationController setNavigationBarHidden:YES];
    
    //    UIImage *temp = [UIImage imageNamed:@"GSjvDeN.jpg"];
    //    [images addObject:temp];
    //    temp = [UIImage imageNamed:@"corgi-puppy-on-a-couch.jpg"];
    //    [images addObject:temp];
    //    self.mainImage.image = temp;
    
    _imgLabel.hidden = YES;
    _imgLabelBackground.hidden = YES;
    [self.buttonview setBackgroundColor:[UIColor peterRiverColor]];
    
    centered = self.mainImage.frame;
}

- (void) updateObjectIDs{
    PFQuery *query1 = [PFQuery queryWithClassName:@"dopest1k"];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            //NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSString *tempString = object.objectId;
                NSLog(@"a: %@", tempString);
                [self.objectIDs addObject:tempString];
            }
            //if ([self.objectIDs count] > 0) {
            for (int i = 0; i < [self.objectIDs count]; i++){
                NSLog(@"b: %@", [self.objectIDs objectAtIndex:i]);
            }
            
            
            //[self loadNextImage];
            if (!firstImageLoaded){
                PFQuery *tempQuery = [PFQuery queryWithClassName:@"dopest1k"];
                [tempQuery getObjectInBackgroundWithId:[self.objectIDs objectAtIndex:0] block:^(PFObject *temp, NSError *error) {
                    // Do something with the returned PFObject in the gameScore variable.
                    
                    for (int i = 0; i < [self.objectIDs count]; i++){
                        NSLog(@"c: %@", [self.objectIDs objectAtIndex:i]);
                    }
                    
                    NSString *URL = temp[@"URL"];
                    self.imgLabel.text = temp[@"title"];
                    NSLog(@"Current Title: %@", self.imgLabel.text);
                    
                    [self downloadImageWithURL:[NSURL URLWithString:URL] completionBlock:^(BOOL succeeded, UIImage *image) {
                        if (succeeded) {
                            
                            // self.currentImageID = [self.objectIDs objectAtIndex:0];
                            self.mainImage.image = image;
                        }
                    }];
                }];
                firstImageLoaded = YES;
                [self.objectIDs removeObjectAtIndex:0];
            }
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void) loadNextImage{
    NSLog(@"loadNextImage");
    
    PFQuery *tempQuery = [PFQuery queryWithClassName:@"dopest1k"];
    [tempQuery getObjectInBackgroundWithId:[self.objectIDs objectAtIndex:0] block:^(PFObject *temp, NSError *error) {
        NSString *URL = temp[@"URL"];
        self.nextTitle = temp[@"title"];
        //self.nextImageLikes = [temp[@"likes"] intValue];
        //self.nextImageDislikes = [temp[@"dislikes"] intValue];
        
        [self downloadImageWithURL:[NSURL URLWithString:URL] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                //self.nextImageID = [self.objectIDs objectAtIndex:0];
                self.nextImage = image;
                NSLog(@"nextImage finished loading in the background");
            }
        }];
    }];
    [self.objectIDs removeObjectAtIndex:0];
    if ([self.objectIDs count] == 0){
        [self updateObjectIDs];
    }
}
- (void)viewDidAppear:(BOOL)animated{
    if (!alertShown) {
        [self alertViewShow];
        alertShown = true;
    }
    
}

- (void)alertViewShow {
    FUIAlertView *alertView = [[FUIAlertView alloc] initWithTitle:@"1k User Manual"
                                                          message:@"Swipe Left = Downvote. \n Swipe Right = Upvote. \n Swipe Down = Save."
                                                         delegate:nil cancelButtonTitle:@"Start Swipin\'"
                                                otherButtonTitles: nil];
    alertView.titleLabel.textColor = [UIColor cloudsColor];
    alertView.titleLabel.font = [UIFont boldFlatFontOfSize:20];
    alertView.messageLabel.textColor = [UIColor cloudsColor];
    alertView.messageLabel.font = [UIFont flatFontOfSize:20];
    alertView.backgroundOverlay.backgroundColor = [[UIColor cloudsColor] colorWithAlphaComponent:0.8];
    alertView.alertContainer.backgroundColor = [UIColor peterRiverColor];
    alertView.defaultButtonColor = [UIColor carrotColor];
    alertView.defaultButtonShadowColor = [UIColor asbestosColor];
    alertView.defaultButtonFont = [UIFont boldFlatFontOfSize:16];
    alertView.defaultButtonTitleColor = [UIColor cloudsColor];
    [alertView show];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.navigationController setNavigationBarHidden:YES];
}



- (IBAction)leftPress:(id)sender {
    [self animateImage:YES];
    [self loadNextImage];
}

- (IBAction)rightPress:(id)sender {
    [self animateImage:NO];
    [self loadNextImage];
}

- (void) doBackgroundColorAnimation: (UIColor*) color {
    [UIView animateWithDuration:.5f animations:^{
        self.view.backgroundColor = color;
    } completion:^(BOOL finished) {
        //[UIView animateWithDuration:.25f animations:^{
        //   self.view.backgroundColor = [UIColor whiteColor];
        //}];
    }];
    
}


- (void) animateImage:(bool) isLeft {
    //NSLog(@"Hello?");
    CGRect end = CGRectMake(isLeft ? -500 : 500, self.mainImage.frame.origin.y, self.mainImage.frame.size.width, self.mainImage.frame.size.height);
    [UIView animateWithDuration:.5 animations:^{
        [self.mainImage setFrame:end];
        [self doBackgroundColorAnimation:isLeft ? [UIColor pomegranateColor] : [UIColor emerlandColor]];
        
    }completion:^(BOOL finished){
        //self.mainImage.frame = CGRectMake(175, 300, 0, 0);
        self.mainImage.image = self.nextImage;
        self.imgLabel.text = nextTitle;
        NSLog(@"Current Title: %@", self.imgLabel.text);
        //self.currentImageID = self.nextImageID;
        self.mainImage.frame = centered;
        self.mainImage.alpha = 0.0f;
        [UIView animateWithDuration:0.5 animations:^{
            self.view.backgroundColor = [UIColor wetAsphaltColor];
            self.mainImage.alpha = 1.0f;
        }];
    }];
    //self.mainImage.image = [images objectAtIndex:count];
    count++;
    count%=2;
    
}

- (void) animateUpImage:(bool) isDown {
    //NSLog(@"Hello?");
    CGRect end = CGRectMake(self.mainImage.frame.origin.x, isDown ? -800 : 800, self.mainImage.frame.size.width, self.mainImage.frame.size.height);
    [UIView animateWithDuration:.5 animations:^{
        [self.mainImage setFrame:end];
        self.view.backgroundColor = isDown ? [UIColor sunflowerColor] : [UIColor belizeHoleColor];
    }completion:^(BOOL finished){
        self.mainImage.image = self.nextImage;
        self.imgLabel.text = nextTitle;
        NSLog(@"Current Title: %@", self.imgLabel.text);
        //self.currentImageID = self.nextImageID;
        self.mainImage.frame = centered;
        self.mainImage.alpha = 0.0f;
        [UIView animateWithDuration:0.5 animations:^{
            self.view.backgroundColor = [UIColor wetAsphaltColor];
            self.mainImage.alpha = 1.0f;
        }];
    }];
    //self.mainImage.image = [images objectAtIndex:count];
    count++;
    count%=2;
    
}
- (IBAction)handleTap:(id)sender {
    NSString *currentTitle = @"Temp";
    [UIView animateWithDuration:.25 animations:^{
        NSLog(@"hello");
        _imgLabel.hidden = false;
        _imgLabelBackground.hidden = false;
        if(_imgLabel.alpha ==0){
            _imgLabel.alpha = 1;
            _imgLabelBackground.alpha = .3;
        }
        else{
            _imgLabel.alpha = 0;
            _imgLabelBackground.alpha = 0;
        }
    }];
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    if (!ySwipe && abs(translation.x)>abs(translation.y)){
        NSLog(@"X swipe");
        xSwipe = true;
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                             self.view.center.y-33.5);
    }
    else if(abs(translation.x)==abs(translation.y)){
        //I don't know why this works but you must have this if statement
        //For some reason if you don't handle the middle case where translation.x = translation.y it doesnt work
    }
    else if (!xSwipe) {
        NSLog(@"Y swipe");
        ySwipe = true;
        recognizer.view.center = CGPointMake(self.view.center.x,
                                             recognizer.view.center.y + translation.y);
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
    
    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"%f",recognizer.view.center.x + translation.x);
        if(recognizer.view.center.x + translation.x > 350){
            NSLog(@"1");//like
            
            //            PFQuery *tempQuery = [PFQuery queryWithClassName:@"dopest1k"];
            //            [tempQuery getObjectInBackgroundWithId:self.currentImageID block:^(PFObject *temp, NSError *error) {
            //                [temp incrementKey:@"likes"];
            //                [temp saveInBackground];
            //            }];
            
            [self animateImage:NO];
            [self loadNextImage];
            //_mainImage.image = [self colorShit:temp whatColor:[UIColor greenColor]];
        }
        else if(recognizer.view.center.x + translation.x < 0){
            NSLog(@"2");//dislike
            
            //            PFQuery *tempQuery = [PFQuery queryWithClassName:@"dopest1k"];
            //            [tempQuery getObjectInBackgroundWithId:self.currentImageID block:^(PFObject *temp, NSError *error) {
            //                [temp incrementKey:@"dislikes"];
            //                [temp saveInBackground];
            //            }];
            
            [self animateImage:YES];
            [self loadNextImage];
            //_mainImage.image = [self colorShit:temp whatColor:[UIColor redColor]];
        }
        else if(recognizer.view.center.y + translation.y > 300){
            NSLog(@"3");
            [self animateUpImage:NO];
            [self loadNextImage];
            //_mainImage.image = [self colorShit:temp whatColor:[UIColor redColor]];
        }
        //        else if(recognizer.view.center.y + translation.y < 0){
        //            NSLog(@"4");
        //            [self animateUpImage:YES];
        //            //_mainImage.image = [self colorShit:temp whatColor:[UIColor redColor]];
        //        }
        else{
            NSLog(@"5");
            [UIView animateWithDuration:.5 animations:^{[self.mainImage setFrame:centered];}];
        }
        xSwipe = false;
        ySwipe = false;
    }
}

- (void)downloadImageWithURL:(NSURL *)url completionBlock:(void (^)(BOOL succeeded, UIImage *image))completionBlock
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               if ( !error )
                               {
                                   UIImage *image = [[UIImage alloc] initWithData:data];
                                   completionBlock(YES,image);
                               } else{
                                   completionBlock(NO,nil);
                               }
                           }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end