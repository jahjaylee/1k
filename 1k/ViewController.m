//
//  ViewController.m
//  1k
//
//  Created by Jay Lee on 4/2/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

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
    _mainImage.image = temp;
    centered = _mainImage.frame;
    rightSwipe.direction=UISwipeGestureRecognizerDirectionRight;
    
    UISwipeGestureRecognizer *leftSwipe=[[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    leftSwipe.direction=UISwipeGestureRecognizerDirectionLeft;
    
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

-(void)fuckYo{
    NSLog(@"Hello?");
    _mainImage.image = [images objectAtIndex:count];
    count++;
    count%=2;
    self.mainImage.frame = centered;
    
}

- (IBAction)handlePan:(UIPanGestureRecognizer *)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];

    if(recognizer.state == UIGestureRecognizerStateEnded)
    {
        if(recognizer.view.center.x + translation.x>350 || recognizer.view.center.x + translation.x<50){
            [self fuckYo];
        }
        else{
            self.mainImage.frame = centered;
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
