//
//  MenuViewController.m
//  1k
//
//  Created by Chip Schaff on 4/10/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

#import "MenuViewController.h"
#import "FlatUIKit.h"

@interface MenuViewController ()

@end

@implementation MenuViewController
@synthesize b1;
@synthesize b2;
@synthesize b3;
@synthesize b4;
//- (id)initWithStyle:(UITableViewStyle)style
//{
//    self = [super initWithStyle:style];
//    if (self) {
//        // Custom initialization
//    }
//    return self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:NO];
    [self.navigationController.navigationBar configureFlatNavigationBarWithColor:[UIColor peterRiverColor]];
    [self.navigationItem setTitle:@"Menu"];
    [self initbuttons];
    [self.view setBackgroundColor:[UIColor wetAsphaltColor]];
    [self.navigationController.navigationBar setTintColor:[UIColor cloudsColor]];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor cloudsColor], NSFontAttributeName : [UIFont flatFontOfSize:24]}];
    
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

-(void)initbuttons
{

    b1 = [[FUIButton alloc]initWithFrame:CGRectMake(110, 175, 100, 56)];
    b1.buttonColor = [UIColor carrotColor];
    b1.shadowColor = [UIColor pumpkinColor];
    b1.shadowHeight = 3.0f;
    b1.cornerRadius = 6.0f;
    b1.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [b1 setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [b1 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [b1 setTitle:@"Categories" forState:UIControlStateNormal];
    [b1 addTarget:self action:@selector(segue:) forControlEvents:UIControlEventTouchUpInside];
    b1.tag = 1;
    [self.view addSubview:b1];
    
    b2 = [[FUIButton alloc]initWithFrame:CGRectMake(110, 239, 100, 56)];
    b2.buttonColor = [UIColor carrotColor];
    b2.shadowColor = [UIColor pumpkinColor];
    b2.shadowHeight = 3.0f;
    b2.cornerRadius = 6.0f;
    b2.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [b2 setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [b2 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [b2 setTitle:@"Account" forState:UIControlStateNormal];
    [b2 addTarget:self action:@selector(segue:) forControlEvents:UIControlEventTouchUpInside];
    b2.tag = 2;
    [self.view addSubview:b2];
    
    b3 = [[FUIButton alloc]initWithFrame:CGRectMake(110, 303, 100, 56)];
    b3.buttonColor = [UIColor carrotColor];
    b3.shadowColor = [UIColor pumpkinColor];
    b3.shadowHeight = 3.0f;
    b3.cornerRadius = 6.0f;
    b3.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [b3 setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [b3 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [b3 setTitle:@"History" forState:UIControlStateNormal];
    [b3 addTarget:self action:@selector(segue:) forControlEvents:UIControlEventTouchUpInside];
    b3.tag = 3;
    [self.view addSubview:b3];
    
    b4 = [[FUIButton alloc]initWithFrame:CGRectMake(110, 367, 100, 56)];
    b4.buttonColor = [UIColor carrotColor];
    b4.shadowColor = [UIColor pumpkinColor];
    b4.shadowHeight = 3.0f;
    b4.cornerRadius = 6.0f;
    b4.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [b4 setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [b4 setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [b4 setTitle:@"Upload" forState:UIControlStateNormal];
    [b4 addTarget:self action:@selector(segue:) forControlEvents:UIControlEventTouchUpInside];
    b4.tag = 4;
    [self.view addSubview:b4];
}

-(void)segue:(id)sender
{
    if ([sender tag] == 1)
        [self performSegueWithIdentifier:@"categorySegue" sender:nil];
    if ([sender tag] == 2)
        [self performSegueWithIdentifier:@"accountSegue" sender:nil];
    if ([sender tag] == 3)
        [self performSegueWithIdentifier:@"historySegue" sender:nil];
    if ([sender tag] == 4)
        [self performSegueWithIdentifier:@"uploadSegue" sender:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
//{
//    // Return the number of sections.
//    return 1;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//    // Return the number of rows in the section.
//    return [menuItems count];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 504.0f / [menuItems count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    static NSString *CellIdentifier = @"Cell";
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
//    
//    // Configure the cell...
//    [cell configureFlatCellWithColor:[UIColor greenSeaColor]
//                       selectedColor:[UIColor cloudsColor]];
//    
//    [cell setCornerRadius: 10.0f];
//    [cell setSeparatorHeight: 1.0f];
//
//    cell.textLabel.text = [menuItems objectAtIndex:indexPath.row];
//    [cell.textLabel setFont:[UIFont flatFontOfSize:16]];
//    cell.textLabel.textAlignment = UITextAlignmentCenter;
//    return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Navigation logic may go here, for example:
//    // Create the next view controller.
//    //<#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
//    
//    // Pass the selected object to the new view controller.
//    if ([menuItems[indexPath.row]  isEqual: @"Categories"]) {
//        [self performSegueWithIdentifier:@"toCategories" sender:nil];
//    }
//    else if ([menuItems[indexPath.row]  isEqual: @"Upload"]) {
//        [self performSegueWithIdentifier:@"toUpload" sender:nil];
//    }
//    else if ([menuItems[indexPath.row]  isEqual: @"Account"]) {
//        [self performSegueWithIdentifier:@"toAccount" sender:nil];
//    }
//    else if ([menuItems[indexPath.row]  isEqual: @"History"]) {
//        [self performSegueWithIdentifier:@"toHistory" sender:nil];
//    }
//    // Push the view controller.
//    //[self.navigationController pushViewController:detailViewController animated:YES];
//}
//
//
///*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//*/
//
///*
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}
//*/
//
///*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
//{
//}
//*/
//
///*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//*/
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/

@end
