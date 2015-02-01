//
//  RolesTVC.m
//  StaffManager
//
//  Created by Dejan Kumric on 1/31/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import "RolesTVC.h"
#import "AddRoleTVC.h"
#import "Role.h"

@interface RolesTVC () <AddRoleTVCDelegate>

@end

@implementation RolesTVC

#pragma mark - ViewController postavke

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self setupFetchedResultsController];
}

#pragma mark - Povlacenje podataka iz baze

- (void)setupFetchedResultsController
{
    // 1 - Decide what entity you want
    NSString *entityName= @"Role"; // Put your entity name here
    NSLog(@"Setting up a Fetched Results Controller for the Entity named %@", entityName);
    
    // 2 - Request the Entity
    NSFetchRequest *request= [NSFetchRequest fetchRequestWithEntityName:entityName];
    
    // 3 - Filter if you want
    // request.predicate= [NSPredicate predicateWithFormat:@"Role.name= Blah"];
    
    // 4 - Sort if you want
    request.sortDescriptors= [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                                                    ascending:YES
                                                                                     selector:@selector(localizedCaseInsensitiveCompare:)]];
    // 5 - Fetch it
    self.fetchedResultsController= [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                       managedObjectContext:self.managedObjectContext
                                                                         sectionNameKeyPath:nil
                                                                                  cacheName:nil];
    [self performFetch];
    
}

#pragma mark - TableView Data Source metode

/*
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}
 */

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    static NSString *cellIdentifier= @"Roles Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if ( cell == nil ) {
        cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    // Configure the cell...
    
    Role *role= [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text= role.name;
    
    return cell;
}

#pragma mark - Prepare for segue i delagate protokol metoda

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ( [segue.identifier isEqualToString:@"Add Role Segue"] ) {
        NSLog(@"Setting RolesTVC as a delegate of AddRoleTVC");
        AddRoleTVC *addRoleTVC= segue.destinationViewController;
        addRoleTVC.delegate= self;
        addRoleTVC.managedObjectContext= self.managedObjectContext;
    }
}

- (void)theSaveButtonOnTheAddRoleTVCWasTapped:(AddRoleTVC *)controller
{
    // do something here like refreshing the table or whatever
    
    // close the delegated view
    [controller.navigationController popViewControllerAnimated:YES];
}

@end
