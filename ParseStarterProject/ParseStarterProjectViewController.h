#import <Parse/Parse.h>

@interface ParseStarterProjectViewController : UIViewController


@property PFObject *dopest1k;
@property PFQuery *query;
@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *displayImage;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *likeLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dislikeLabel;

@end
