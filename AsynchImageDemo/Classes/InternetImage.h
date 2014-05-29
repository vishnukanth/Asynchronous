
#import <UIKit/UIKit.h>

@interface InternetImage : NSObject {
	@private NSMutableData *imageRequestData;
	@private id mDelegate;
	@private NSURLConnection *imageConnection;
	@public NSString* imageUrl;
	@public UIImage* image;
	bool workInProgress;
}


@property (nonatomic, retain) NSString* ImageUrl;
@property (nonatomic, retain) UIImage* Image;
@property (nonatomic, assign) bool workInProgress;

-(void)setDelegate:(id)newDelegate;
-(id)initWithUrl:(NSString*)urlToImage;
-(void)downloadImage:(id)delegate;
-(void)abortDownload;

@end


@interface NSObject (InternetImageDelegate)
- (void)internetImageReady:(InternetImage*)internetImage;
@end
