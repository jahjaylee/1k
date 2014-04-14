#import <Parse/Parse.h>

@interface ParseStarterProjectViewController : UIViewController


@property (unsafe_unretained, nonatomic) IBOutlet UIButton *likeButton;
@property (unsafe_unretained, nonatomic) IBOutlet UIButton *dislikeButton;
@property PFObject *dopest1k;
@property PFQuery *query;
@property NSMutableArray* objectIDs;
@property UIImageView *iv;
@property UIImage *nextImage;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *likeLabel;
@property (unsafe_unretained, nonatomic) IBOutlet UILabel *dislikeLabel;
@property bool firstImageLoaded;
@property int nextImageLikes;
@property int nextImageDislikes;

@end
