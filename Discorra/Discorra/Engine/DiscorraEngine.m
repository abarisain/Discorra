//
//  DiscorraEngine.m
//  Discorra
//
//  Created by Arnaud Barisain Monrose on 08/10/12.
//  Copyright (c) 2012 Arnaud Barisain Monrose. All rights reserved.
//

#import "DiscorraEngine.h"

@implementation DiscorraEngine

//This is where the articles in .md format will go
static const NSString* articlesFolder = @"articles/";
//The output folder
static const NSString* buildFolder = @"build/";
//The ressources folder (content will be copied as-is to build/res/)
static const NSString* ressourcesFolder = @"res/";
//The template folder
static const NSString* templatesFolder = @"tpl/";
//Article template
static const NSString* templateArticle = @"article.mustache";
//Index (article list) template
static const NSString* templateIndex = @"index.mustache";
//Base template (can be overriden in any sub template by putting a <!-- Discorra:OverrideBaseTemplate -->
static const NSString* templateBase = @"base.mustache";

-(id) initWithPath:(NSString*)path {
    self = [super init];
    if(self != nil) {
        targetPath = [NSString stringWithString:path];
    }
    return self;
}

@end
