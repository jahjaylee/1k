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

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    images = [[NSMutableArray alloc] init];
    count = 0;
    [super viewDidLoad];
    UISwipeGestureRecognizer *rightSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    UIImage *temp = [UIImage imageNamed:@"GSjvDeN.jpg"];
    [images addObject:temp];
    temp = [UIImage imageNamed:@"corgi-puppy-on-a-couch.jpg"];
    [images addObject:temp];
    self.mainImage.image = temp;
    centered = self.mainImage.frame;
    rightSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    
    [self.view addGestureRecognizer:leftSwipe];
    [self.view addGestureRecognizer:rightSwipe];
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)handleSwipe:(id)sender{
  /*  NSLog(@"Hello?");
    _mainImage.image = [images objectAtIndex:count];
    count++;
    count%=2;*/
}

- (IBAction)leftPress:(id)sender {
    [self animateImage:YES];
}

- (IBAction)rightPress:(id)sender {
    [self animateImage:NO];
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
        [self doBackgroundColorAnimation:isLeft ? [UIColor redColor] : [UIColor greenColor]];
        
    }completion:^(BOOL finished){
        //self.mainImage.frame = CGRectMake(175, 300, 0, 0);
        self.mainImage.image = [images objectAtIndex:(count+1)%2];
        self.mainImage.frame = centered;
        self.mainImage.alpha = 0.0f;
        [UIView animateWithDuration:0.5 animations:^{
            
            self.view.backgroundColor = [UIColor whiteColor];
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
        self.view.backgroundColor = isDown ? [UIColor blueColor] : [UIColor yellowColor];
    }completion:^(BOOL finished){
        self.mainImage.image = [images objectAtIndex:(count+1)%2];
        self.mainImage.frame = centered;
        self.view.backgroundColor = [UIColor blackColor];
    }];
    //self.mainImage.image = [images objectAtIndex:count];
    count++;
    count%=2;
    
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    if(abs(translation.x)>abs(translation.y)){
        NSLog(@"X swipe");
        recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                             self.view.center.y-33.5);
    }
    else if(abs(translation.x)==abs(translation.y)){
        //I don't know why this works but you must have this if statement
        //For some reason if you don't handle the middle case where translation.x = translation.y it doesnt work
    }
    else{
        NSLog(@"Y swipe");
        recognizer.view.center = CGPointMake(self.view.center.x,
                                             recognizer.view.center.y + translation.y);
    }
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        NSLog(@"%f",recognizer.view.center.x + translation.x);
        if(recognizer.view.center.x + translation.x > 350){
            NSLog(@"1");
            [self animateImage:NO];
            //_mainImage.image = [self colorShit:temp whatColor:[UIColor greenColor]];
        }
        else if(recognizer.view.center.x + translation.x < 0){
            NSLog(@"2");
            [self animateImage:YES];
            //_mainImage.image = [self colorShit:temp whatColor:[UIColor redColor]];
        }
        else if(recognizer.view.center.y + translation.y > 300){
            NSLog(@"3");
            [self animateUpImage:NO];
            //_mainImage.image = [self colorShit:temp whatColor:[UIColor redColor]];
        }
        else if(recognizer.view.center.y + translation.y < 0){
            NSLog(@"4");
            [self animateUpImage:YES];
            //_mainImage.image = [self colorShit:temp whatColor:[UIColor redColor]];
        }
        else{
            NSLog(@"5");
            [UIView animateWithDuration:.5 animations:^{[self.mainImage setFrame:centered];}];
        }
    }
}

-(UIImage*)colorShit:(UIImage*) image whatColor:(UIColor*)color{
    UIImage *img = image;
    
    // begin a new image context, to draw our colored image onto
    UIGraphicsBeginImageContext(img.size);
    
    // get a reference to that context we created
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // set the fill color
    [color setFill];
    
    // translate/flip the graphics context (for transforming from CG* coords to UI* coords
    CGContextTranslateCTM(context, 0, img.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // set the blend mode to color burn, and the original image
    CGContextSetBlendMode(context, kCGBlendModeColorBurn);
    CGRect rect = CGRectMake(0, 0, img.size.width, img.size.height);
    CGContextDrawImage(context, rect, img.CGImage);
    
    // set a mask that matches the shape of the image, then draw (color burn) a colored rectangle
    CGContextClipToMask(context, rect, img.CGImage);
    CGContextAddRect(context, rect);
    CGContextDrawPath(context,kCGPathFill);
    
    // generate a new UIImage from the graphics context we drew onto
    UIImage *coloredImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //return the color-burned image
    return coloredImg;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
