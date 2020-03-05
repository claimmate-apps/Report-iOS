#import <Foundation/Foundation.h>

typedef void(^ImageCacheDownloadCompletionHandler)(UIImage *image);

@interface ImageCache : NSObject
{
    
}

#pragma mark - UI Methods
+ (id)sharedInstance;
- (UIImage*)imageForKey:(NSString*)key;
- (void)setImage:(UIImage*)image forKey:(NSString*)key;
- (void)downloadImageAtURL:(NSURL*)url completionHandler:(ImageCacheDownloadCompletionHandler)completion;

@end
