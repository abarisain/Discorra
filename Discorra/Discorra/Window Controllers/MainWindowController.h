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

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>
#import "AppDelegate.h"
#import "ArticleSummaryTableCellView.h"
#import "DiscorraEngine.h"

@interface MainWindowController : NSWindowController <NSWindowDelegate, NSTableViewDataSource> {
    NSString *blogPath;
    NSArray *tableData;
    DiscorraEngine *engine;
}

- (NSArray*) getFakeArticles;
- (id)initWithBlogPath:(NSString *) path;
- (IBAction)build:(id)sender;
- (IBAction)addArticle:(id)sender;
- (IBAction)refreshButtonPressed:(id)sender;
- (IBAction)editMenuPressed:(id)sender;
- (IBAction)deleteMenuPressed:(id)sender;
- (IBAction)globalArticleEdit:(id)sender;
- (IBAction)globalArticleDelete:(id)sender;
- (void)tableViewSelectionDidChange:(NSNotification *)aNotification;
- (void)pathDoesNotContainBlog;
- (void)alertDidEnd:(NSAlert*)alert returnCode:(int)button contextInfo:(void*)context;
- (void)buildSuccessAlertDidEnd:(NSAlert*)alert returnCode:(int)button contextInfo:(void*)context;
- (void)refreshData;
- (void)build;
- (void)editArticle:(Article*)article;
- (void)deleteArticle:(Article*)article;

@property (weak) IBOutlet NSTextField *statusbarText;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSProgressIndicator *inderterminateProgress;
@property (weak) IBOutlet NSButton *buildButton;
@property (weak) IBOutlet WebView *webView;
@property (weak) IBOutlet NSTextField *previewText;


@end
