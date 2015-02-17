//
//  RolesTVC.h
//  StaffManager
//
//  Created by Dejan Kumric on 1/31/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewController.h"
#import "AddRoleTVC.h"
#import "RoleDetailTVC.h"

@class Role;

@interface RolesTVC : CoreDataTableViewController <AddRoleTVCDelegate, RoleDetailTVCDelegate, UISearchDisplayDelegate, UISearchBarDelegate>
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Role *selectedRole;
@property (retain, nonatomic) NSMutableArray *searchResults;
@end
