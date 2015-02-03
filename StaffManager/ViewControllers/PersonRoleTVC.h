//
//  PersonRoleTVC.h
//  StaffManager
//
//  Created by Dejan Kumric on 2/2/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import "CoreDataTableViewController.h" // so we can fetch
#import "Role.h"

@class PersonRoleTVC;
@protocol PersonRoleTVCDelegate
- (void)roleWasSelectedOnPersonRoleTVC:(PersonRoleTVC *)controller;
@end

@interface PersonRoleTVC : CoreDataTableViewController
@property (weak, nonatomic) id <PersonRoleTVCDelegate> delegate;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) Role *selectedRole;
@end
