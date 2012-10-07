//
//  MainWindowController.m
//  Discorra
//
//  Created by Arnaud Barisain Monrose on 07/10/12.
//  Copyright (c) 2012 Arnaud Barisain Monrose. All rights reserved.
//

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
    tableData = [[NSArray alloc] initWithObjects:@"foo",@"bar", nil];
    blogPath = [NSString stringWithString:path];
    return self;
}

- (IBAction)build:(id)sender {
}

- (IBAction)addArticle:(id)sender {
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
    NSTableCellView *result = [tableView makeViewWithIdentifier:@"Cell" owner:self];
    result.textField.stringValue = [tableData objectAtIndex:row];
    return result;
}

@end
