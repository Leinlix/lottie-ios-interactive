#import <Foundation/Foundation.h>

@interface LOTContext : NSObject

@property (nonatomic, strong) NSMutableDictionary *registedMethod;

+ (instancetype)sharedInstance;

- (void)registerMethod:(Class)clz andFunction:(SEL)selector andName:(NSString*)name;

- (id)callMethod:(NSString*)functionName params:(NSArray*)params;

- (void)analysisText:(NSString*)text;

@end