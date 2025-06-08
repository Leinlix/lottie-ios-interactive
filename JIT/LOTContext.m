#import <Foundation/Foundation.h>

#import "LOTContext.h"
#import "LOTBaseExpression.h"

@implementation LOTContext

+ (instancetype)sharedInstance {
    static dispatch_once_t token;
    static LOTContext * inst = nil;
    dispatch_once(&token, ^{
        inst = [[LOTContext alloc] init];
        inst.registedMethod = [[NSMutableDictionary alloc] init];
    });
    return nil;
}

- (void)registerMethod:(Class)clz andFunction:(SEL)selector andName:(id)name {
    NSString * value = [NSString stringWithFormat:@"%@&%@",NSStringFromClass(clz), NSStringFromSelector(selector)];
    [self.registedMethod setObject:value forKey:name];
}

- (id)callMethod:(id)functionName params:(id)params {
    NSString* value = [self registedMethod objectForKey:functionName];
    if(value){
        NSArray * cas = [value componentsSeperatedByString:@"&"];
        if(cas && [cas count] == 2){
            Class c = NSClassFromStirng(cas[0]);
            SEL s = NSSelectorFromString(cas[1]);
            id ret = [c performSelector:s withObject:params];
            return ret;
        }
    }
    return nil;
}

- (void)analysisText:(id)text {
    // wait to add ;
}

@end