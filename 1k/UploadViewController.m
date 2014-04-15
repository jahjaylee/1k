//
//  UploadViewController.m
//  1k
//
//  Created by Chip Schaff on 4/10/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

#import "UploadViewController.h"

@interface UploadViewController ()

@end

@implementation UploadViewController

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
    
    assetsAccessor = [[AssetsAccessor alloc] initWithDelegate:self];
}

#pragma mark - IBActions

- (IBAction)pressSelectImage:(id)sender {
    [assetsAccessor getAssetsGroupsWithTypes:ALAssetsGroupAll];
    
}

- (IBAction)pressGetImage:(id)sender {
    //[assetsAccessor getAssetByURL:imageURL];
}

#pragma mark - Methods for Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ToTableView"]) {
        UINavigationController *navigationController = [segue destinationViewController];
        TableViewController *tableViewController = navigationController.viewControllers[0];
        tableViewController.parent = self;
        tableViewController.groups = (NSArray *)sender;
    }
}

#pragma mark - MyImagePickerControllerDelegate Methods

- (void)didFinishPickingAsset:(ALAsset *)asset{
    [self dismissViewControllerAnimated:YES completion:nil];
    imageURL = [[asset defaultRepresentation] url];
    self.urlLabel.text = imageURL.absoluteString;
    self.urlLabel.textColor = [UIColor redColor];
    //self.getButton.enabled = YES;
    [assetsAccessor getAssetByURL:imageURL];
}

#pragma mark - AssetsAccessorDelegate Methods

- (void)assetsGroupsDidLoad:(NSArray *)groups{
    [self performSegueWithIdentifier:@"ToTableView" sender:groups];
}

- (void)assetDidLoadByURL:(ALAsset *)asset{
    UIImage *image = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
    self.imageView.image = image;
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
