

#import "InternetImage.h"


@implementation InternetImage

@synthesize ImageUrl, Image, workInProgress;

-(id) initWithUrl:(NSString*)urlToImage
{
	self = [super init];
	
	if(self)
	{
		self.ImageUrl = urlToImage;
	}
	
	return self;
}


- (void)setDelegate:(id)newDelegate
{
    mDelegate = newDelegate;
}	

-(void)downloadImage:(id)delegate
{
	mDelegate = delegate;
	
	NSURLRequest *imageRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:ImageUrl] 
											   cachePolicy:NSURLRequestReturnCacheDataElseLoad timeoutInterval:400.0];
	imageConnection = [[NSURLConnection alloc] initWithRequest:imageRequest delegate:self];
	
	if(imageConnection)
	{
        
		workInProgress = YES;
		imageRequestData = [[NSMutableData data] retain];
        	}
}

-(void)abortDownload
{
	if(workInProgress == YES)
	{
		[imageConnection cancel];
		[imageRequestData release];
		workInProgress = NO;
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
	
   
    [imageRequestData setLength:0];
	
}
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    
    [imageRequestData appendData:data];	
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
   
    

    NSLog(@"Connection failed! Error - %@ %@", [error localizedDescription], [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
	workInProgress = NO;
    [imageRequestData release];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
	if(workInProgress == YES)
	{
		workInProgress = NO;
		
		UIImage* downloadedImage = [[UIImage alloc] initWithData:imageRequestData];
	
		self.Image = downloadedImage;
	
		
		[downloadedImage release];
		[imageRequestData release];
    
		
		
		if ([mDelegate respondsToSelector:@selector(internetImageReady:)])
		{
			// Call the delegate method and pass ourselves along.
			[mDelegate internetImageReady:self];
		}
	}	
}


- (void)dealloc 
{
    [imageConnection release];
	[ImageUrl release];
	[Image release];
	[super dealloc];
}


@end
