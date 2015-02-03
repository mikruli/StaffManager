//
//  PersonDetailTVC.h
//  StaffManager
//
//  Created by Dejan Kumric on 2/2/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonRoleTVC.h"

@class Person;
@class Role;

@class PersonDetailTVC;
@protocol PersonDetailTVCDelegate <NSObject>
- (void)theSaveButtonOnTheAddPersonTVCWasTapped:(PersonDetailTVC *)controller;
@end

@interface PersonDetailTVC : UITableViewController <PersonRoleTVCDelegate>
@property (strong, nonatomic) Role *selectedRole;
@property (weak, nonatomic) id <PersonDetailTVCDelegate> delegate;
// @property (strong, nonatomic) IBOutlet UITextField *personNameTextField;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *personFirstnameTextField;
@property (strong, nonatomic) IBOutlet UITextField *personSurnameTextField;
@property (strong, nonatomic) IBOutlet UITableViewCell *personRoleTableViewCell;
@property (strong, nonatomic) Person *person;
- (IBAction)save:(id)sender;
@end
