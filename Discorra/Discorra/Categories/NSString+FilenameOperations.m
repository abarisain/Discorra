//
//  NSString+FilenameOperations.m
//  Discorra
//
//  Created by Arnaud Barisain Monrose on 13/10/12.
//  Copyright (c) 2012 Arnaud Barisain Monrose. All rights reserved.
//

#import "NSString+FilenameOperations.h"

@implementation NSString (FilenameOperations)

- (NSString *)sanitizedFileNameString {
    //The only forbidden filename characters in Mac OS X are / and :
    NSCharacterSet* illegalFileNameCharacters = [NSCharacterSet characterSetWithCharactersInString:@"/:"];
    return [[self componentsSeparatedByCharactersInSet:illegalFileNameCharacters] componentsJoinedByString:@"_"];
}

@end
