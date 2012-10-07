//
//  MainWindowController.h
//  Discorra
//
//  Created by Arnaud Barisain Monrose on 07/10/12.
//  Copyright (c) 2012 Arnaud Barisain Monrose. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "AppDelegate.h"

@interface MainWindowController : NSWindowController <NSWindowDelegate, NSTableViewDataSource> {
    NSString *blogPath;
    NSArray *tableData;
}

- (id)initWithBlogPath:(NSString *) path;
- (IBAction)build:(id)sender;
- (IBAction)addArticle:(id)sender;

@end
