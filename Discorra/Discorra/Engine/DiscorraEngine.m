//
//  DiscorraEngine.m
//  Discorra
//
//  Created by Arnaud Barisain Monrose on 08/10/12.
//  Copyright (c) 2012 Arnaud Barisain Monrose. All rights reserved.
//

#import "DiscorraEngine.h"

@implementation DiscorraEngine

static const NSString* articlesFolder = @"OldValue";

-(id) initWithPath:(NSString*)path {
    self = [super init];
    if(self != nil) {
        targetPath = [NSString stringWithString:path];
    }
    return self;
}

@end
