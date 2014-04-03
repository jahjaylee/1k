#import "ParseStarterProjectViewController.h"
#import <Parse/Parse.h>
#import "AsyncImageView.h"

@implementation ParseStarterProjectViewController

@synthesize dopest1k;
@synthesize query;

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    //UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://cse.wustl.edu/ContentImages/News%20Images/ToddSproull_lg.JPG"]]];
   // UIImageView *iv = [[UIImageView alloc] initWithFrame:CGRectMake(40, 95, 240, 217)];
   // iv.contentMode = UIViewContentModeScaleAspectFit;
   // [iv setImage:image];
   // [self.view addSubview:iv];
    
    dopest1k = [PFObject objectWithClassName:@"dopest1k"];
    NSLog(@"viewDidLoad");
    
    query = [PFQuery queryWithClassName:@"dopest1k"];
    [query getObjectInBackgroundWithId:@"vE1eRFiKd6" block:^(PFObject *temp, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        
        self.likeLabel.text = [NSString stringWithFormat:@"Likes: %@", temp[@"likes"]];
        self.dislikeLabel.text = [NSString stringWithFormat:@"Dislikes: %@", temp[@"dislikes"]];
        
    }];
}

- (IBAction)likePress:(id)sender {
    NSLog(@"likepress");
    
    [query getObjectInBackgroundWithId:@"vE1eRFiKd6" block:^(PFObject *temp, NSError *error) {
        NSNumber *likes = [NSNumber numberWithInt:[temp[@"likes"] intValue] + 1];
        //temp[@"likes"] = likes;
        [temp incrementKey:@"likes"];
        self.likeLabel.text = [NSString stringWithFormat:@"Likes: %@", likes];
        [temp saveInBackground];
        
    }];
    
   // dopest1k[@"likes"]=@1;
    //[dopest1k saveInBackground];
}

- (IBAction)dislikePress:(id)sender {
    
    NSLog(@"dislikepress");
    
    [query getObjectInBackgroundWithId:@"vE1eRFiKd6" block:^(PFObject *temp, NSError *error) {
        NSNumber *dislikes = [NSNumber numberWithInt:[temp[@"dislikes"] intValue] + 1];
        //temp[@"dislikes"] = dislikes;
        [temp incrementKey:@"dislikes"];
        self.dislikeLabel.text = [NSString stringWithFormat:@"Dislikes: %@", dislikes];
        [temp saveInBackground];
        
    }];
    
    //dopest1k[@"dislikes"]=@1;
    //[dopest1k saveInBackground];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
