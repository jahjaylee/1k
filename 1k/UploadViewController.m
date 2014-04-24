//
//  UploadViewController.m
//  1k
//
//  Created by Chip Schaff on 4/10/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

#import "UploadViewController.h"
#import "FlatUIKit.h"

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
    [self.view setBackgroundColor:[UIColor wetAsphaltColor]];
    assetsAccessor = [[AssetsAccessor alloc] initWithDelegate:self];
    [self.linkTextView setTextColor:[UIColor cloudsColor]];
    [self.Title setTextColor:[UIColor cloudsColor]];
    self.titleTextField.delegate = self;

    
    FUIButton * select = [[FUIButton alloc]initWithFrame:CGRectMake(108, 461, 96, 30)];
    select.buttonColor = [UIColor carrotColor];
    select.shadowColor = [UIColor pumpkinColor];
    select.shadowHeight = 3.0f;
    select.cornerRadius = 6.0f;
    select.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [select setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [select setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [select setTitle:@"Select" forState:UIControlStateNormal];
    [select addTarget:self action:@selector(pressSelectImage:) forControlEvents:UIControlEventTouchUpInside];
    FUIButton * upload = [[FUIButton alloc]initWithFrame:CGRectMake(108, 499, 96, 30)];
    upload.buttonColor = [UIColor carrotColor];
    upload.shadowColor = [UIColor pumpkinColor];
    upload.shadowHeight = 3.0f;
    upload.cornerRadius = 6.0f;
    upload.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [upload setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [upload setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [upload setTitle:@"Upload" forState:UIControlStateNormal];
    [upload addTarget:self action:@selector(pressUploadButton:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:upload];
    [self.view addSubview:select];
    
    [self.imageView setBackgroundColor:[UIColor midnightBlueColor]];
    
    
}

#pragma mark - IBActions

- (IBAction)pressSelectImage:(id)sender {
    [assetsAccessor getAssetsGroupsWithTypes:ALAssetsGroupAll];
    
}
- (IBAction)pressUploadButton:(id)sender {
    
    NSString *clientID = @"a1200e4c3161c4d";
    
    NSString *title = [[self titleTextField] text];
    
    [assetsAccessor getAssetByURL:imageURL];
    
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    __weak UploadViewController *weakSelf = self;
    // Load the image data up in the background so we don't block the UI
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSData *imageData = UIImageJPEGRepresentation(_uploadImage, 1.0f);
        
        [MLIMGURUploader uploadPhoto:imageData title:title description:nil imgurClientID:clientID completionBlock:^(NSString *result) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [[weakSelf linkTextView] setText:result];
            });
        } failureBlock:^(NSURLResponse *response, NSError *error, NSInteger status) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
                [[[UIAlertView alloc] initWithTitle:@"Upload Failed"
                                            message:[NSString stringWithFormat:@"%@ (Status code %ld)", [error localizedDescription], (long)status]
                                           delegate:nil
                                  cancelButtonTitle:nil
                                  otherButtonTitles:@"OK", nil] show];
            });
        }];
        
    });
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
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
    [assetsAccessor getAssetByURL:imageURL];
}

#pragma mark - AssetsAccessorDelegate Methods

- (void)assetsGroupsDidLoad:(NSArray *)groups{
    [self performSegueWithIdentifier:@"ToTableView" sender:groups];
}

- (void)assetDidLoadByURL:(ALAsset *)asset{
    _uploadImage = [UIImage imageWithCGImage:[[asset defaultRepresentation] fullScreenImage]];
    self.imageView.image = _uploadImage;
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
