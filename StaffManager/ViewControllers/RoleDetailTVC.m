//
//  RoleDetailTVC.m
//  StaffManager
//
//  Created by Dejan Kumric on 2/1/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import "RoleDetailTVC.h"
#import "Role.h"

@interface RoleDetailTVC () <UITextFieldDelegate>
@end

@implementation RoleDetailTVC

@synthesize role= _role;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    NSLog(@"Setting the value of fields in this static table to that of the passed Role");
    self.roleNameTextField.text= self.role.name;
    
}

- (void)viewDidDisappear:(BOOL)animated
{
    [self setRoleNameTextField:nil];
    [super viewDidDisappear:animated];
}

- (IBAction)save:(id)sender
{
    NSLog(@"Telling the AddRoleTVC Delegate that Save was tapped on the AddRoleTVC");
    
    [self.role setName:self.roleNameTextField.text];
    
    [self.managedObjectContext save:nil]; // write to database
    
    [self.delegate theSaveButtonOnTheAddRoleTVCWasTapped:self];
}

#pragma mark - UITextFieldDelegate metode

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
