#import "ImageCache.h"

@interface ImageCache () {
    NSMutableDictionary *_cache;
}
@end

@implementation ImageCache

#pragma mark - Init Method
- (id)init {
    if ((self = [super init])) {
        _cache = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - UI Methods
+ (id)sharedInstance {
    static ImageCache *sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[[self class] alloc] init];
    });
    return sharedInstance;
}

- (UIImage*)imageForKey:(NSString*)key {
    if (![key isEqualToString:@""] && key != nil) {
        return [_cache objectForKey:key];
    }else {
        return nil;
    }
}

- (void)setImage:(UIImage*)image forKey:(NSString*)key {
    if (![key isEqualToString:@""] && key != nil && image != nil) {
        [_cache setObject:image forKey:key];
    }
}

- (void)downloadImageAtURL:(NSURL*)url completionHandler:(ImageCacheDownloadCompletionHandler)completion {
    UIImage *cachedImage = [self imageForKey:[url absoluteString]];
    
    if (cachedImage) {
        completion(cachedImage);
    }else {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData:data];
            [self setImage:image forKey:[url absoluteString]];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(image);
            });
        });
    }
}

@end
