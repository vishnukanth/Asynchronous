

#import "AsynchImageDemoViewController.h"

@implementation AsynchImageDemoViewController
@synthesize imageView, asynchronousImage;


// Implement viewDidLoad to do additional setup after loading the view.
- (void)viewDidLoad {
    [super viewDidLoad];
    indicatorView=[[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indicatorView.center=CGPointMake(160.0f, 130.0f);
    indicatorView.hidesWhenStopped=YES;
    indicatorView.backgroundColor=[UIColor clearColor];
    
    counter = 0;
    
    
    [self.view addSubview:indicatorView];
	UIButton *button=(UIButton*)[self.view viewWithTag:1];
    [button addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];

	UIButton *button1=(UIButton*)[self.view viewWithTag:2];
    [button1 addTarget:self action:@selector(removeButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *button2=(UIButton*)[self.view viewWithTag:3];
    [button2 addTarget:self action:@selector(increaseCounterClicked) forControlEvents:UIControlEventTouchUpInside];
}
-(void)buttonClicked
{
    [indicatorView startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=YES;
    
    
    //go to apple image
    [self downloadImageFromInternet:@"http://www.macdaddynews.com/wp-content/uploads/2010/07/Apple3.jpg"];
}

- (void) downloadImageFromInternet:(NSString*) urlToImage
{
	
	asynchronousImage = [[InternetImage alloc] initWithUrl:urlToImage];
	
	
	[asynchronousImage downloadImage:self];
}


-(void) internetImageReady:(InternetImage*)internetImage
{	
	// The image has been downloaded. Put the image into the UIImageView
    [indicatorView stopAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible=NO;
    if(internetImage)
    {
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Downloading is" message:@"completed" delegate:self cancelButtonTitle:@"ok" otherButtonTitles: nil];
        [alertView show];
        NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
        
        // If you go to the folder below, you will find those pictures
        NSLog(@"%@",docDir);
        
        NSLog(@"saving Image");
        NSString *pngFilePath = [NSString stringWithFormat:@"%@/Apple.jpg",docDir];
        NSData *data1 = [NSData dataWithData:UIImagePNGRepresentation(internetImage.Image)];
        [data1 writeToFile:pngFilePath atomically:YES];

	 [imageView setImage:internetImage.Image];
    }
    else
    {
        ////
    }
}
-(void)removeButtonClicked
{
    NSFileManager *fileManager = [NSFileManager defaultManager]; 
    NSString *docDir = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *fullPath =   [NSString stringWithFormat:@"%@/Apple.jpg",docDir];
    
    NSLog(@"Removing Image");
    [fileManager removeItemAtPath: fullPath error:NULL];
    imageView.image=nil;
    
}
-(void)increaseCounterClicked
{
    counter++;
    UIButton *mybutton = (UIButton *)[self.view viewWithTag:3];;
    [mybutton setTitle:[NSString stringWithFormat:@"Counter = %d", counter] forState:UIControlStateNormal];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
	// Abort the download. Doesn't do anything if the image has been downloaded already.
	[asynchronousImage abortDownload];
	// Then release.
	[asynchronousImage release];
	[imageView release];
    [indicatorView release];
    [super dealloc];
}

@end
