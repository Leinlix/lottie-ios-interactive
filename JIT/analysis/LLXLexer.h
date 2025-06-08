typedef NS_ENUM(NSInteger, KEY_TOKENS){
    VAR_TOKEN = -1,
    IF_TOKEN = -2,
    THEN_TOKEN = -3,
    ELSE_TOKEN = -4,
    FOR_TOKEN =-5,
    IN_TOKEN = -6,
    NUMER_TOKEN = -7,
    STRING_TOKEN = -8,
    BOOL_TOKEN = -9,
    ID_TOKEN = -10,
    DEFAULT_TOKEN = -11,
    DEF_TOKEN = -12,
    RET_TOKEN = -13,
    FUNCRET_TOEKN = -14
};

#import <Foundation/Foundation.h>

@interface LLXLexer: NSObject

+ (NSArray*)tokenize:(NSString*)code;

@end