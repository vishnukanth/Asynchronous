

#import <UIKit/UIKit.h>

@class AsynchImageDemoViewController;

@interface AsynchImageDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AsynchImageDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AsynchImageDemoViewController *viewController;

@end

