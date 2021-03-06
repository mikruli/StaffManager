//
//  AddRoleTVC.m
//  StaffManager
//
//  Created by Dejan Kumric on 1/31/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import "AddRoleTVC.h"
#import "Role.h"

@interface AddRoleTVC () <UITextFieldDelegate>

@end

@implementation AddRoleTVC

@synthesize managedObjectContext= _managedObjectContext;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

#pragma mark - IBAction metode

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddRoleTVC Delegate that Save was tapped on the AddRoleTVC");
    
    Role *role= [NSEntityDescription insertNewObjectForEntityForName:@"Role"
                                              inManagedObjectContext:self.managedObjectContext];
    
    role.name= self.roleNameTextField.text;
    
    [self.managedObjectContext save:nil];
    
    [self.delegate theSaveButtonOnTheAddRoleTVCWasTapped:self];
}

#pragma mark - UITextFieldDelegate metode

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
