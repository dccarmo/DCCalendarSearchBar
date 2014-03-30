//
//  DCViewController.m
//  CalendarSearchBar
//
//  Created by Diogo do Carmo on 29/03/14.
//  Copyright (c) 2014 Diogo do Carmo. All rights reserved.
//

#import "DCViewController.h"

//View Controllers
#import "DCCalendarSearchBarViewController.h"

@interface DCViewController () <UISearchDisplayDelegate>

@property (nonatomic) NSArray *dataSource;
@property (nonatomic) NSArray *searchDataSource;
@property (nonatomic) DCCalendarSearchBarViewController *searchController;

@end

@implementation DCViewController

- (instancetype)init
{
    self = [super initWithStyle:UITableViewStyleGrouped];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIBarButtonItem *pesquisar = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSearch target:self action:@selector(openSearch)];
    
    self.navigationItem.rightBarButtonItem = pesquisar;
    
	self.searchController = [[DCCalendarSearchBarViewController alloc] initWithDataSourceViewController:self];
    
    [self setUpDataSource];
}

- (void)setUpDataSource
{
    self.dataSource = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"fakeNames" ofType:@"json"]] options:NSJSONReadingAllowFragments error:nil];
}

- (void)openSearch
{
    [self presentViewController:self.searchController animated:YES completion:nil];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSUInteger numberOfRows;
    
    if (tableView == self.tableView) {
        numberOfRows = [self.dataSource count];
    } else {
        numberOfRows = [self.searchDataSource count];
    }
    
    return numberOfRows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSDictionary *info;
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    }
    
    if (tableView == self.tableView) {
        info = self.dataSource[indexPath.row];
    } else {
        info = self.searchDataSource[indexPath.row];
    }
    
    cell.textLabel.text = info[@"name"];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *info;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (tableView == self.tableView) {
        info = self.dataSource[indexPath.row];
    } else {
        info = self.searchDataSource[indexPath.row];
    }
    
    NSLog(@"%@ was selected",info[@"name"]);
}

#pragma mark - UISearchDisplayController

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    self.searchDataSource = [self.dataSource filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"name contains[cd] %@",searchString]];
    
    return YES;
}

@end
