#import "ParseStarterProjectViewController.h"
#import <Parse/Parse.h>

@implementation ParseStarterProjectViewController

@synthesize dopest1k;
@synthesize query;
@synthesize iv;
@synthesize nextImage;
@synthesize firstImageLoaded;

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


#pragma mark - UIViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    
    [super viewDidLoad];
    firstImageLoaded = NO;
    self.dislikeButton.enabled = NO;
    self.likeButton.enabled = NO;
    self.objectIDs = [NSMutableArray array];
    
    dopest1k = [PFObject objectWithClassName:@"dopest1k"];
    NSLog(@"viewDidLoad");
    
    query = [PFQuery queryWithClassName:@"dopest1k"];
    [query getObjectInBackgroundWithId:@"vE1eRFiKd6" block:^(PFObject *temp, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        
        self.likeLabel.text = [NSString stringWithFormat:@"Likes: %@", temp[@"likes"]];
        self.dislikeLabel.text = [NSString stringWithFormat:@"Dislikes: %@", temp[@"dislikes"]];
        
    }];
    
    [self updateObjectIDs];
}



- (void) showNextImage{
    [iv removeFromSuperview];
    NSLog(@"showNextImage");
    
    PFQuery *tempQuery = [PFQuery queryWithClassName:@"dopest1k"];
    [tempQuery getObjectInBackgroundWithId:[self.objectIDs objectAtIndex:0] block:^(PFObject *temp, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        iv = [[UIImageView alloc] initWithFrame:CGRectMake(40, 95, 240, 217)];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        [iv setImage:nextImage];
        [self.view addSubview:iv];
        self.likeLabel.text = [NSString stringWithFormat:@"Likes: %d", self.nextImageLikes];
        self.dislikeLabel.text = [NSString stringWithFormat:@"Dislikes: %d", self.nextImageDislikes];
        self.dislikeButton.enabled = YES;
        self.likeButton.enabled = YES;
        
        NSString *URL = temp[@"URL"];
        self.nextImageLikes = [temp[@"likes"] intValue];
        self.nextImageDislikes = [temp[@"dislikes"] intValue];
        
        [self downloadImageWithURL:[NSURL URLWithString:URL] completionBlock:^(BOOL succeeded, UIImage *image) {
            if (succeeded) {
                // change the image in the cell
                nextImage = image;
                NSLog(@"nextImage finished loading in the background");
            }
        }];
        
        
        
        
        //nextImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:URL]]];
        
    }];
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



- (void) showFirstImage{
    NSLog(@"showFirstImage");
    PFQuery *query1a = [PFQuery queryWithClassName:@"dopest1k"];
    [query1a getObjectInBackgroundWithId:[self.objectIDs objectAtIndex:0] block:^(PFObject *temp, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSLog(@"this better show a url: %@", temp[@"URL"]);
        NSString *URL = temp[@"URL"];
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:URL]]];
        iv = [[UIImageView alloc] initWithFrame:CGRectMake(40, 95, 240, 217)];
        iv.contentMode = UIViewContentModeScaleAspectFit;
        [iv setImage:image];
        [self.view addSubview:iv];
        self.likeLabel.text = [NSString stringWithFormat:@"Likes: %@", temp[@"likes"]];
        self.dislikeLabel.text = [NSString stringWithFormat:@"Dislikes: %@", temp[@"dislikes"]];
        self.dislikeButton.enabled = YES;
        self.likeButton.enabled = YES;
        NSLog(@"hello");
    }];
    
    NSLog(@"second part");
    PFQuery *query2 = [PFQuery queryWithClassName:@"dopest1k"];
    [query2 getObjectInBackgroundWithId:[self.objectIDs objectAtIndex:1] block:^(PFObject *temp, NSError *error) {
        // Do something with the returned PFObject in the gameScore variable.
        NSString *URL = temp[@"URL"];
        nextImage = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:URL]]];
        self.nextImageLikes = [temp[@"likes"] intValue];
        self.nextImageDislikes = [temp[@"dislikes"] intValue];
    }];
    
    firstImageLoaded = YES;
    [self.objectIDs removeObjectAtIndex:0];
}


- (void) updateObjectIDs{
    PFQuery *query1 = [PFQuery queryWithClassName:@"dopest1k"];
    //[query1 whereKey:@"playerName" equalTo:@"Dan Stemkoski"];
    [query1 findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            // The find succeeded.
            NSLog(@"Successfully retrieved %d scores.", objects.count);
            // Do something with the found objects
            for (PFObject *object in objects) {
                NSString *tempString = object.objectId;
                [self.objectIDs addObject:tempString];
            }
            if (!firstImageLoaded)
                [self showFirstImage];
            else
                [self showNextImage];
            
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (IBAction)likePress:(id)sender {
    NSLog(@"likepress");
    self.dislikeButton.enabled = NO;
    self.likeButton.enabled = NO;
    PFQuery *tempQuery = [PFQuery queryWithClassName:@"dopest1k"];
    [tempQuery getObjectInBackgroundWithId:[self.objectIDs objectAtIndex:0] block:^(PFObject *temp, NSError *error) {
        //NSNumber *likes = [NSNumber numberWithInt:[temp[@"likes"] intValue] + 1];
        //temp[@"likes"] = likes;
        [temp incrementKey:@"likes"];
        //self.likeLabel.text = [NSString stringWithFormat:@"Likes: %@", likes];
        [temp saveInBackground];
        [self.objectIDs removeObjectAtIndex:0];
        if (self.objectIDs.count == 0)
            [self updateObjectIDs];
        else
            [self showNextImage];
        
    }];
    
    // dopest1k[@"likes"]=@1;
    //[dopest1k saveInBackground];
}

- (IBAction)dislikePress:(id)sender {
    
    NSLog(@"dislikepress");
    self.dislikeButton.enabled = NO;
    self.likeButton.enabled = NO;
    PFQuery *tempQuery = [PFQuery queryWithClassName:@"dopest1k"];
    [tempQuery getObjectInBackgroundWithId:[self.objectIDs objectAtIndex:0] block:^(PFObject *temp, NSError *error) {
        //NSNumber *dislikes = [NSNumber numberWithInt:[temp[@"dislikes"] intValue] + 1];
        //temp[@"dislikes"] = dislikes;
        [temp incrementKey:@"dislikes"];
        //self.dislikeLabel.text = [NSString stringWithFormat:@"Dislikes: %@", dislikes];
        [temp saveInBackground];
        [self.objectIDs removeObjectAtIndex:0];
        if (self.objectIDs.count == 0)
            [self updateObjectIDs];
        else
            [self showNextImage];
        
    }];
    
    //dopest1k[@"dislikes"]=@1;
    //[dopest1k saveInBackground];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
