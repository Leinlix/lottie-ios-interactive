#import <Foundation/Foundation.h>

#import "LLXLexer.h"

@implementation LLXLexer

+ (BOOL)isSpace:(unichar)x {
    return  x == ' ';
}

+ (BOOL)isNumberic:(unichar)x{
    return ((x-'0') > -1 && (x - '9')<1);
}

+ (BOOL)isAlphabetic:(unichar)x{
    return ((x - 'A') > -1  && (x - 'z') < 1);
}

+ (BOOL)isVariablic:(unichar)x{
    return [self isNumberic:x] || [self isAlphabetic:x] || x == '_';
}

// 兼容中文
+ (NSString*)unicharToCharactor:(unichar)c{
    if(0x4E00 <= c && c <= 0x9FA5){
        return [NSString stringWithFormat:@"%C", c];
    }
    return [NSString stringWithFormat@"%c",c];
}

+ (id)tokenize:(id)code {
    NSMutableArray * tokens = [[NSMutableArray alloc] init];
    // loop text 
    for(int i = 0 ; i < code.length; i++){
        unichar x = [code characterAtIndex: i];
        while ([self isSpace:x]){
            i++;
            x = [code characterAtIndex:i];
            continue;
        }

        NSMutableDictionary *ret = [[NSMutableDictionary alloc] init];
        NSString *str = @"";

        // variable
        if([self isVariablic:x]){
            unichar t = x;
            while([self isVariablic:t]){
                NSString *chr = [self unicharToCharactor:t];
                str = [str stringByAppendingString:chr];
                i++;
                t = [code characterAtIndex:i];
            }
            // back 
            i--;
            // check keyword
            if ([str isEqualToString:@"var"]){
                [ret setObject:[NSNumber numberWithInt:VAR_TOKEN] forKey:@"var"];
                [tokens addObject: ret];
                continue;
            }else if ([str isEqualToString@"if"]){
                [ret setObject:[NSNumber numberWithInt:IF_TOKEN] forKey:@"if"];
                [tokens addObject: ret];
                continue;
            }else if ([str isEqualToString@"then"]){
                [ret setObject:[NSNumber numberWithInt:THEN_TOKEN] forKey:@"then"];
                [tokens addObject: ret];
                continue;
            }else if([str isEqualToString:@"else"]){
                [ret setObject:[NSNumber numberWithInt:ELSE_TOKEN] forKey:@"else"];
                [tokens addObject: ret];
                continue;
            }else if([str isEqualToString:@"for"]){
                [ret setObject:[NSNumber numberWithInt:FOR_TOKEN] forKey:@"for"];
                [tokens addObject: ret];
                continue;
            }else if([str isEqualToString:@"in"]){
                [ret setObject:[NSNumber numberWithInt:IN_TOKEN] forKey:@"in"];
                [tokens addObject: ret];
                continue;
            }else if([str isEqualToString:@"def"]){
                [ret setObject:[NSNumber numberWithInt:DEF_TOKEN] forKey:@"def"];
                [tokens addObject: ret];
                continue;
            }else if([str isEqualToString:@"return"]){
                [ret setObject:[NSNumber numberWithInt:RET_TOKEN] forKey:@"return"];
                [tokens addObject: ret];
                continue;
            }else if([str isEqualToString:@"void"]||[str isEqualToString:@"value"]){
                [ret setObject:[NSNumber numberWithInt:FUNCRET_TOKEN] forKey:str];
                [tokens addObject: ret];
                continue;
            }

            if([str length] > 0){
                [ret setObject:[NSNumber numberWithInt:ID_TOKEN] forKey:str];
                [tokens addObject: ret];
                continue;
            }
        }

        // number check
        if([self isNumberic:x]){
            unichar n = x;
            while([self isNumberic:n] || n == '.'){
                str = [str stringByAppendingString:[self unicharToCharactor:n]];
                i++;
                n = [code characterAtIndex:i];
            }
            [ret setObject:[NSNumber numberWithInt:NUMBER_TOKEN] forKey:str];
            [tokens addObject: ret];
            i--;
            continue;
        }

        // string check
        if(x == '\''){
            unichar s = [code characterAtIndex:(++i)];
            while(s != '\''){
                str = [str stringByAppendingString:[self unicharToCharactor:s]];
                i++;
                s = [code characterAtIndex:i];
            }
            [ret setObject:[NSNumber numberWithInt:STRING_TOKEN] forKey:str];
            [tokens addObject: ret];
            continue;
        }

        // special for ==
        if (x == '='){
            int j = i + i;
            if([code characterAtIndex:j] ==  '='){
                i++;
                [ret setObject:[NSNumber numberWithInt:DEFAULT_TOKEN] forKey:@"=="];
                [tokens addObject: ret];
                continue;
            }
        }

        // normal caculator
        [ret setObject:[NSNumber numberWithInt:DEFAULT_TOKEN] forKey:[self unicharToCharactor:x]];
        [tokens addObject:ret];
    }
    return tokens;
}

@end