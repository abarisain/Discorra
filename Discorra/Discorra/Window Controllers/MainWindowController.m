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

#import "MainWindowController.h"

@interface MainWindowController ()

@end

@implementation MainWindowController

- (id)init
{
    self = [super initWithWindowNibName:@"MainWindowController"];
    return self;
}

- (id)initWithBlogPath:(NSString *) path
{
    self = [super initWithWindowNibName:@"MainWindowController"];
    tableData = [self getFakeArticles];
    blogPath = [NSString stringWithString:path];
    return self;
}

- (IBAction)build:(id)sender {
}

- (IBAction)addArticle:(id)sender {
}

- (NSArray*) getFakeArticles {
    Article* a1 = [[Article alloc] init];
    a1.date = [NSDate dateWithString:@"2012-07-24 10:45:32 +0100"];
    a1.summary = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.";
    a1.title = @"Cher lorem";
    Article* a2 = [[Article alloc] init];
    a2.date = [NSDate date];
    a2.summary = @"Look, just because I don't be givin' no man a foot massage don't make it right for Marsellus to throw Antwone into a glass motherfuckin' house, fuckin' up the way the nigger talks. Motherfucker do that shit to me, he better paralyze my ass, 'cause I'll kill the motherfucker, know what I'm sayin'?";
    a2.title = @"Samuel L. ipsum";
    return [NSArray arrayWithObjects:a2, a1, nil];
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    //Apply some custom style to the text
    [[self.statusbarText cell] setBackgroundStyle:NSBackgroundStyleRaised];
    [self refreshData];
}

- (void)windowWillClose:(NSNotification *)notification
{
    [((AppDelegate*)[NSApp delegate]) removeWindowController:self];
}

#pragma mark NSTableViewDatasource

- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return tableData.count;
}

- (NSView *)tableView:(NSTableView *)tableView viewForTableColumn:(NSTableColumn *)tableColumn row:(NSInteger)row {
    ArticleSummaryTableCellView *result = [tableView makeViewWithIdentifier:@"Cell" owner:self];
    [result refreshWithArticle:[tableData objectAtIndex:row]];
    return result;
}

#pragma mark Helpers

- (void)refreshData {
    [[self tableView] reloadData];
    NSString *countFormat;
    if([tableData count] == 1) {
        countFormat = NSLocalizedString(@"%d article", @"Article count printf format");
    } else {
        countFormat = NSLocalizedString(@"%d articles", @"Articles count printf format (plural)");
    }
    [self statusbarText].stringValue = [NSString stringWithFormat:countFormat, [tableData count]];
}

@end
