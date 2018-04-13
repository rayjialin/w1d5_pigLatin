//
//  main.m
//  w1d5_pigLatin
//
//  Created by ruijia lin on 4/13/18.
//  Copyright © 2018 ruijia lin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PigLatin)

-(NSString *)stringByPigLatinization;

@end

@implementation NSString (PigLatin)

-(NSString *)stringByPigLatinization{
    //    NSArray *vowelArray = @[@"a", @"A", @"e",@"E",@"i",@"I",@"o",@"O",@"u",@"U"];
    NSString *vowelArray = @"aeiou";
    NSString *alphabet = @"abcdefghijklmnopqrstuvwxyz";
    NSMutableArray *mutableArr = [NSMutableArray arrayWithArray:[self componentsSeparatedByString:@" "]];
    NSInteger wordCount = 0;
    NSMutableString *pigString = [NSMutableString string];
    NSMutableArray *pigArray = [NSMutableArray array];
    NSString *puncutation = [NSString new];
    
    for (NSMutableString *words in mutableArr){
        BOOL vowelFound = NO;
        wordCount = words.length;
        pigString = words;
        NSRange lastIndexRange = NSMakeRange(wordCount - 1, 1);
        
        // remove the punctuation if there is one and put it back after being pigLatin
        if (![alphabet containsString:[words substringFromIndex:wordCount - 1]]){
            
            puncutation = [pigString substringFromIndex:wordCount - 1];
            pigString = [NSMutableString stringWithString:[pigString stringByReplacingCharactersInRange:lastIndexRange withString:@""]];
        }
        
        for (NSInteger i = 0; i < wordCount; i++){
            NSRange charRange = NSMakeRange(i, 1);
            if (!vowelFound){
                // check if the character is in the vowel array
                if ([vowelArray containsString:[words substringWithRange:charRange]]){
                    pigString = [NSMutableString stringWithFormat:@"%@ay%@", pigString, puncutation];
                    vowelFound = YES;
                }
            }
            
            if (!vowelFound){
                pigString = [NSMutableString stringWithString:[pigString stringByAppendingString:[pigString substringWithRange:charRange]]];
                pigString = [NSMutableString stringWithString:[pigString stringByReplacingCharactersInRange:charRange withString:@""]];
            }
        }
        
        [pigArray addObject:pigString];
    }
    
    
    
    return [pigArray componentsJoinedByString:@" "];
}
@end

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        NSLog([@"hello? world!" stringByPigLatinization]);
    }
    return 0;
}
