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
    // Do any additional setup after loading the view.
    self.categories = [[NSArray alloc]initWithObjects:@"Dogs",@"Cats",@"Humor",@"Scenic",@"Todd Sproull",@"all", nil];
    [self.navigationItem setTitle:@"Categories"];
    self.tableView.separatorInset = UIEdgeInsetsZero;
    self.tableView.backgroundColor = [UIColor wetAsphaltColor];
    self.tableView.separatorColor = [UIColor carrotColor];
}

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
    NSLog(@"selected %@", [categories objectAtIndex:indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark TableView DataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [categories count];
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    // The header for the section is the region name -- get this from the region at the section index.
    return nil;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
    cell.textLabel.text = [categories objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont flatFontOfSize:16];
    cell.textLabel.textColor = [UIColor cloudsColor];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor wetAsphaltColor];
    return cell;
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
