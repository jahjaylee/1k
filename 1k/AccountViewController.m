//
//  AccountViewController.m
//  1k
//
//  Created by Chip Schaff on 4/10/14.
//  Copyright (c) 2014 Jay Lee. All rights reserved.
//

#import "AccountViewController.h"
#import "FlatUIKit.h"

@interface AccountViewController ()

@end

@implementation AccountViewController
@synthesize login;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)loginButtonPress:(id)sender {
    self.usernameLabel.hidden = YES;
    self.usernameTextField.hidden = YES;
    self.passwordLabel.hidden = YES;
    self.passwordTextField.hidden = YES;
    self.login.hidden = YES;
    self.profilePicImage.hidden = NO;
    self.memberSinceLabel.hidden = NO;
    self.memberSinceLabel2.hidden = NO;
    self.accountLabel.hidden = NO;
    self.emailLabel.hidden = NO;
    NSLog(@"button press");
    [self.view endEditing:YES];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor wetAsphaltColor]];
    
    [self.view setBackgroundColor:[UIColor wetAsphaltColor]];
    self.usernameLabel.font = [UIFont flatFontOfSize:16];
    self.usernameLabel.textColor = [UIColor cloudsColor];
    self.passwordLabel.font = [UIFont flatFontOfSize:16];
    self.usernameLabel.textColor = [UIColor cloudsColor];
    self.accountLabel.font = [UIFont flatFontOfSize:16];
    self.usernameLabel.textColor = [UIColor cloudsColor];
    self.emailLabel.font = [UIFont flatFontOfSize:16];
    self.usernameLabel.textColor = [UIColor cloudsColor];
    self.memberSinceLabel.font = [UIFont flatFontOfSize:16];
    self.usernameLabel.textColor = [UIColor cloudsColor];
    self.memberSinceLabel2.font = [UIFont flatFontOfSize:16];
    self.usernameLabel.textColor = [UIColor cloudsColor];
    
    self.login = [[FUIButton alloc]initWithFrame:CGRectMake(129, 295, 63, 50)];
    login.buttonColor = [UIColor carrotColor];
    login.shadowColor = [UIColor pumpkinColor];
    login.shadowHeight = 3.0f;
    login.cornerRadius = 6.0f;
    login.titleLabel.font = [UIFont boldFlatFontOfSize:16];
    [login setTitleColor:[UIColor cloudsColor] forState:UIControlStateNormal];
    [login setTitleColor:[UIColor cloudsColor] forState:UIControlStateHighlighted];
    [login setTitle:@"Log In" forState:UIControlStateNormal];
    [login addTarget:self action:@selector(loginButtonPress:) forControlEvents:UIControlEventTouchUpInside];
    login.tag = 1;
    [self.view addSubview:login];
    
    
    // Do any additional setup after loading the view.
    [self.navigationItem setTitle:@"Account"];
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
