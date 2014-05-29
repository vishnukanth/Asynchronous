

#import <UIKit/UIKit.h>
#import "InternetImage.h"

@interface AsynchImageDemoViewController : UIViewController {

	IBOutlet UIImageView *imageView;
	InternetImage *asynchronousImage;
    UIActivityIndicatorView *indicatorView;
    int counter;
}

@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) InternetImage *asynchronousImage;

-(void) downloadImageFromInternet:(NSString*) urlToImage;
-(void) internetImageReady:(InternetImage*)internetImage;
@end

