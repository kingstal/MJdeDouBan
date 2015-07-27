//
//  CWObjectCache.m
//
//
//  Created by WangMinjun on 15/7/27.
//
//

#import "CWObjectCache.h"
#import <UIKit/UIKit.h>
#import "NSString+CWAdditions.h"

static NSString* const CWDataCacheDirectoryName = @"com.MJdeDouBan.CWObjectCache";

static const NSInteger kDefaultCacheMaxCacheAge = 60 * 60 * 24 * 7; // 1 week
static const NSUInteger kDefaultCacheMaxCacheSize = 1024 * 1024 * 512; // 512MB

@interface CWObjectCache ()

@property (nonatomic, strong) NSCache* memCache;
@property (nonatomic, strong) dispatch_queue_t ioQueue;

@end

@implementation CWObjectCache

+ (instancetype)sharedCache
{
    static CWObjectCache* _cache = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _cache = [[CWObjectCache alloc] init];
    });
    return _cache;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (id)init
{
    self = [super init];
    if (self) {
        _memCache = [[NSCache alloc] init];
        _memCache.name = CWDataCacheDirectoryName;

        _maxCacheAge = kDefaultCacheMaxCacheAge;
        _maxCacheSize = kDefaultCacheMaxCacheSize;

        // Create IO serial queue
        _ioQueue = dispatch_queue_create("com.MJdeDouBan.CWObjectCache", DISPATCH_QUEUE_SERIAL);

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearMemory)
                                                     name:UIApplicationDidReceiveMemoryWarningNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(clearExpiredDiskCache)
                                                     name:UIApplicationWillTerminateNotification
                                                   object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(backgroundClearExpiredCache)
                                                     name:UIApplicationDidEnterBackgroundNotification
                                                   object:nil];
    }
    return self;
}

#pragma mark - API

- (void)storeObject:(id<NSCoding>)object forKey:(NSString*)key
{
    [self storeObject:object forKey:key toDisk:YES];
}

- (void)storeObject:(id<NSCoding>)object forKey:(NSString*)key toDisk:(BOOL)toDisk
{
    if (!object || !key) {
        return;
    }

    [self.memCache setObject:object forKey:key];

    if (!toDisk) {
        return;
    }

    dispatch_async(self.ioQueue, ^{
        NSData* data = [NSKeyedArchiver archivedDataWithRootObject:object];
        NSFileManager* fileManager = [NSFileManager defaultManager];
        if (![fileManager fileExistsAtPath:[self cachePath]]) {
            [fileManager createDirectoryAtPath:[self cachePath] withIntermediateDirectories:YES attributes:nil error:NULL];
        }

        if (![fileManager createFileAtPath:[self cachePathForKey:key] contents:data attributes:nil]) {
            NSLog(@"Failed save to disk.");
        }
    });
}

- (id)objectForKey:(NSString*)key
{
    id object = [self objectFromMemoryCacheForKey:key];
    if (object) {
        return object;
    }

    return [self objectFromDiskCacheForKey:key];
}

- (id)objectFromMemoryCacheForKey:(NSString*)key
{
    return [self.memCache objectForKey:key];
}

- (id)objectFromDiskCacheForKey:(NSString*)key
{
    NSString* path = [self cachePathForKey:key];
    NSData* data = [NSData dataWithContentsOfFile:path];
    if (data) {
        id object = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        if (object) {
            [self.memCache setObject:object forKey:key];
            return object;
        }
    }
    return nil;
}

- (unsigned long long)cacheSize
{
    unsigned long long size = 0;
    NSDirectoryEnumerator* fileEnumerator = [[NSFileManager defaultManager] enumeratorAtPath:[self cachePath]];
    for (NSString* fileName in fileEnumerator) {
        NSString* filePath = [[self cachePath] stringByAppendingPathComponent:fileName];
        NSDictionary* attrs = [[NSFileManager defaultManager] attributesOfItemAtPath:filePath error:nil];
        size += [attrs fileSize];
    }
    return size;
}

- (void)calculateCacheSize:(void (^)(unsigned long long))completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        unsigned long long size = [self cacheSize];

        if (!completion) {
            return;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            completion(size);
        });
    });
}

#pragma mark - CleanUp

- (void)clearMemory
{
    [self.memCache removeAllObjects];
}

- (void)clearDisk
{
    [self clearDiskOnCompletion:nil];
}

- (void)clearDiskOnCompletion:(void (^)())completion
{
    dispatch_async(self.ioQueue, ^{
        [[NSFileManager defaultManager] removeItemAtPath:[self cachePath] error:nil];
        [[NSFileManager defaultManager] createDirectoryAtPath:[self cachePath]
                                  withIntermediateDirectories:YES
                                                   attributes:nil
                                                        error:NULL];
        if (!completion) {
            return;
        }

        dispatch_async(dispatch_get_main_queue(), ^{
            completion();
        });
    });
}

- (void)clearExpiredDiskCache
{
    dispatch_async(self.ioQueue, ^{
        NSFileManager* fileManager = [NSFileManager defaultManager];
        NSURL* diskCacheURL = [NSURL fileURLWithPath:[self cachePath] isDirectory:YES];
        NSArray* resourceKeys = @[ NSURLIsDirectoryKey, NSURLContentModificationDateKey, NSURLTotalFileAllocatedSizeKey ];

        // This enumerator prefetches useful properties for our cache files.
        NSDirectoryEnumerator* fileEnumerator = [fileManager enumeratorAtURL:diskCacheURL
                                                  includingPropertiesForKeys:resourceKeys
                                                                     options:NSDirectoryEnumerationSkipsHiddenFiles
                                                                errorHandler:NULL];

        NSDate* expirationDate = [NSDate dateWithTimeIntervalSinceNow:-self.maxCacheAge];
        NSMutableDictionary* cacheFiles = [NSMutableDictionary dictionary];
        NSUInteger currentCacheSize = 0;

        // Enumerate all of the files in the cache directory.  This loop has two purposes:
        //
        //  1. Removing files that are older than the expiration date.
        //  2. Storing file attributes for the size-based cleanup pass.
        for (NSURL* fileURL in fileEnumerator) {
            NSDictionary* resourceValues = [fileURL resourceValuesForKeys:resourceKeys error:NULL];

            // Skip directories.
            if ([resourceValues[NSURLIsDirectoryKey] boolValue]) {
                continue;
            }

            // Remove files that are older than the expiration date;
            NSDate* modificationDate = resourceValues[NSURLContentModificationDateKey];
            if ([[modificationDate laterDate:expirationDate] isEqualToDate:expirationDate]) {
                [fileManager removeItemAtURL:fileURL error:nil];
                continue;
            }

            // Store a reference to this file and account for its total size.
            NSNumber* totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
            currentCacheSize += [totalAllocatedSize unsignedIntegerValue];
            [cacheFiles setObject:resourceValues forKey:fileURL];
        }

        // If our remaining disk cache exceeds a configured maximum size, perform a second
        // size-based cleanup pass.  We delete the oldest files first.
        if (self.maxCacheSize > 0 && currentCacheSize > self.maxCacheSize) {
            // Target half of our maximum cache size for this cleanup pass.
            const NSUInteger desiredCacheSize = self.maxCacheSize / 2;

            // Sort the remaining cache files by their last modification time (oldest first).
            NSArray* sortedFiles = [cacheFiles keysSortedByValueWithOptions:NSSortConcurrent
                                                            usingComparator:^NSComparisonResult(id obj1, id obj2) {
                                                                return [obj1[NSURLContentModificationDateKey] compare:obj2[NSURLContentModificationDateKey]];
                                                            }];

            // Delete files until we fall below our desired cache size.
            for (NSURL* fileURL in sortedFiles) {
                if ([fileManager removeItemAtURL:fileURL error:nil]) {
                    NSDictionary* resourceValues = cacheFiles[fileURL];
                    NSNumber* totalAllocatedSize = resourceValues[NSURLTotalFileAllocatedSizeKey];
                    currentCacheSize -= [totalAllocatedSize unsignedIntegerValue];

                    if (currentCacheSize < desiredCacheSize) {
                        break;
                    }
                }
            }
        }
    });
}

- (void)backgroundClearExpiredCache
{
    UIApplication* application = [UIApplication sharedApplication];
    __block UIBackgroundTaskIdentifier bgTask = [application beginBackgroundTaskWithExpirationHandler:^{
        // Clean up any unfinished task business by marking where you
        // stopped or ending the task outright.
        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    }];

    // Start the long-running task and return immediately.
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Do the work associated with the task, preferably in chunks.
        [self clearExpiredDiskCache];

        [application endBackgroundTask:bgTask];
        bgTask = UIBackgroundTaskInvalid;
    });
}

#pragma mark - Private

- (NSString*)cachePath
{
    static NSString* cachePath = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        cachePath = [[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:CWDataCacheDirectoryName];
    });
    return cachePath;
}

- (NSString*)cachePathForKey:(NSString*)key
{
    NSString* md5FileName = [key cw_md5];
    NSString* path = [[self cachePath] stringByAppendingPathComponent:md5FileName];
    return path;
}

@end
