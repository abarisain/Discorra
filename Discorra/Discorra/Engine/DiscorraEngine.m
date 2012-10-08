//
//  DiscorraEngine.m
//  Discorra
//
//  Created by Arnaud Barisain Monrose on 08/10/12.
//  Copyright (c) 2012 Arnaud Barisain Monrose. All rights reserved.
//

#import "DiscorraEngine.h"

@implementation DiscorraEngine

static const NSString* articlesFolder = @"articles/";
static const NSString* buildFolder = @"build/";
static const NSString* stylesheetsFolder = @"css/";
static const NSString* imagesFolder = @"img/";
static const NSString* scriptsFolder = @"scripts/";
static const NSString* templatesFolder = @"tpl/";
static const NSString* templateArticle = @"article.mustache";
static const NSString* templateIndex = @"index.mustache";
static const NSString* templateBase = @"base.mustache";

-(id) initWithPath:(NSString*)path {
    self = [super init];
    if(self != nil) {
        targetPath = [NSString stringWithString:path];
    }
    return self;
}

@end
