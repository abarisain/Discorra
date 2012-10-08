/*
 * Copyright (c) 2012 Arnaud Barisain Monrose. All rights reserved.
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions
 * are met:
 * 1. Redistributions of source code must retain the above copyright
 *    notice, this list of conditions and the following disclaimer.
 * 2. Redistributions in binary form must reproduce the above copyright
 *    notice, this list of conditions and the following disclaimer in the
 *    documentation and/or other materials provided with the distribution.
 * 3. The name of the author may not be used to endorse or promote products
 *    derived from this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
 * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
 * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
 * IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
 * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
 * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
 * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
 * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
 * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import "DiscorraEngine.h"

@implementation DiscorraEngine

//This is where the articles in .md format will go
static NSString* const articlesFolder = @"articles/";
//The output folder
static NSString* const buildFolder = @"build/";
//The ressources folder (content will be copied as-is to build/res/)
static NSString* const ressourcesFolder = @"res/";
//The template folder
static NSString* const templatesFolder = @"tpl/";
//Article template
static NSString* const templateArticle = @"article.mustache";
//Index (article list) template
static NSString* const templateIndex = @"index.mustache";
//Base template (can be overriden in any sub template by putting a <!-- Discorra:OverrideBaseTemplate -->
static NSString* const templateBase = @"base.mustache";

- (id)initWithPath:(NSString*)path {
    self = [super init];
    if(self != nil) {
        _targetPath = [NSString stringWithString:path];
    }
    return self;
}

- (bool)checkIfPathContainsBlog {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *foldersToCheck = [NSArray arrayWithObjects:articlesFolder,
                                                buildFolder,
                                                ressourcesFolder,
                                                templatesFolder,
                        nil];
    NSArray *templatesToCheck = [NSArray arrayWithObjects:templateArticle,
                                 templateIndex,
                                 templateBase,
                                 nil];
    BOOL isDirectory = NO;
    if(_targetPath == nil ||
       !([fileManager fileExistsAtPath:_targetPath isDirectory:&isDirectory] && isDirectory)) {
        return NO;
    }
    for(NSString* tmp in foldersToCheck) {
        if(!([fileManager fileExistsAtPath:[_targetPath stringByAppendingPathComponent:tmp] isDirectory:&isDirectory] && isDirectory)) {
            return NO;
        }
    }
    NSString *templateBasePath = [_targetPath stringByAppendingPathComponent:templatesFolder];
    for(NSString* tmp in templatesToCheck) {
        if(!([fileManager fileExistsAtPath:[templateBasePath stringByAppendingPathComponent:tmp] isDirectory:&isDirectory] && !isDirectory)) {
            return NO;
        }
    }
    return YES;
}

//Returns if the skeleton creation suceeded
- (bool)createSkeleton {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSArray *folders = [NSArray arrayWithObjects:articlesFolder,
                               buildFolder,
                               ressourcesFolder,
                               templatesFolder,
                               nil];
    NSArray *templates = [NSArray arrayWithObjects:templateArticle,
                                 templateIndex,
                                 templateBase,
                                 nil];
    NSError *error = nil;
    for(NSString* tmp in folders) {
        if(![fileManager createDirectoryAtPath:[_targetPath stringByAppendingPathComponent:tmp] withIntermediateDirectories:YES attributes:nil error:&error]) {
            //Todo : manage error
            NSLog(@"Error while creating skeleton %@ : %@", tmp, [error localizedDescription]);
            return false;
        }
    }
    //Todo : replace dummy files with real skeleton files
    NSString *templateBasePath = [_targetPath stringByAppendingPathComponent:templatesFolder];
    for(NSString* tmp in templates) {
        if(![fileManager createFileAtPath:[templateBasePath stringByAppendingPathComponent:tmp] contents:[NSData data] attributes:nil]) {
            NSLog(@"Error while creating template file : %@", tmp);
            return false;
        }
    }
    return true;
}

#pragma mark Article methods

- (NSString*)articleFolderPath {
    return [_targetPath stringByAppendingPathComponent:articlesFolder];
}

- (NSArray*)articles {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *baseDirectory = [self articleFolderPath];
    NSError *error = nil;
    NSArray *files = [fileManager contentsOfDirectoryAtPath:baseDirectory error:&error];
    NSMutableArray *articles = [[NSMutableArray alloc] init];
    NSString *fileContent;
    Article *article;
    BOOL isDir = false;
    for(__strong NSString *filePath in files) {
        filePath = [baseDirectory stringByAppendingPathComponent:filePath];
        if(![filePath hasSuffix:@".md" caseInsensitive:YES] || ![fileManager fileExistsAtPath:filePath isDirectory:&isDir] || isDir)
            continue;
        error = nil;
        fileContent = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:&error];
        if(error != nil) {
            NSLog(@"Error while reading article %@ : %@", filePath, [error localizedDescription]);
            continue;
        }
        if([fileContent length] == 0)
            continue;
        article = [[Article alloc] init];
        NSMutableArray *fileContentArray = [[fileContent componentsSeparatedByString:@"\n"] mutableCopy];
        article.date = [[fileManager attributesOfItemAtPath:filePath error:NULL] fileModificationDate];
        article.path = filePath;
        article.title = [fileContentArray objectAtIndex:0];
        [fileContentArray removeObjectAtIndex:0];
        if([fileContentArray count] > 0) {
            NSString *fullSummary = [fileContentArray componentsJoinedByString:@" "];
            article.content = [fileContentArray componentsJoinedByString:@"\n"];
            article.summary = [fullSummary substringToIndex:MIN(fullSummary.length, SUMMARY_CHARACTERS_LIMIT)];
        }
        [articles addObject:article];
    }
    return [NSArray arrayWithArray:articles];
}

#pragma mark Build methods

- (NSString*)ressourcesFolderPath {
    return [_targetPath stringByAppendingPathComponent:ressourcesFolder];
}

- (NSString*)buildFolderPath {
    return [_targetPath stringByAppendingPathComponent:buildFolder];
}

- (bool)build {
    if(![self cleanBuildFolder])
        return NO;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *buildFolder = [self buildFolderPath];
    if(![fileManager copyItemAtPath:[self ressourcesFolderPath] toPath:[buildFolder stringByAppendingPathComponent:ressourcesFolder] error:nil])
        return NO;
    return YES;
}

- (bool)cleanBuildFolder {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *buildFolder = [self buildFolderPath];
    if(![fileManager removeItemAtPath:buildFolder error:nil])
        return NO;
    if(![fileManager createDirectoryAtPath:buildFolder withIntermediateDirectories:YES attributes:nil error:nil])
        return NO;
    return YES;
}

@end
