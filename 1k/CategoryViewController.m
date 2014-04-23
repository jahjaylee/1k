//
//  CategoryViewController.m
//  1k
//
//  Created by Chip Schaff on 4/10/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

#import "CategoryViewController.h"
#import "FlatUIKit.h"

@interface CategoryViewController ()

@end

@implementation CategoryViewController
@synthesize categories;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor wetAsphaltColor]];
    [self.picker setBackgroundColor:[UIColor wetAsphaltColor]];
    [self.picker setTintColor:[UIColor cloudsColor]];
    // Do any additional setup after loading the view.
    self.categories = [[NSArray alloc]initWithObjects:@"dogs",@"cats",@"humor",@"scenic",@"Todd Sproull",@"all", nil];
    [self.navigationItem setTitle:@"Categories"];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSUInteger numTaps = [[touches anyObject] tapCount];
    if(numTaps >= 2) {
        [self performSegueWithIdentifier:@"menuToMain" sender:nil];
    }
}

#pragma mark -
#pragma mark PickerView DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [categories count];
}
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [categories objectAtIndex:row];
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
    label.backgroundColor = [UIColor wetAsphaltColor];
    label.textColor = [UIColor cloudsColor];
    label.font = [UIFont flatFontOfSize:24];
    label.text = [categories objectAtIndex:row];
    [label setTextAlignment:NSTextAlignmentCenter];
    return label;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
