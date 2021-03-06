//
//  AddPersonTVC.h
//  StaffManager
//
//  Created by Dejan Kumric on 2/2/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RolePickerTVCell.h"

@class AddPersonTVC;
@protocol AddPersonTVCDelegate
- (void)theSaveButtonOnTheAddPersonTVCWasTapped:(AddPersonTVC *)controller;
@end

@interface AddPersonTVC : UITableViewController <RolePickerTVCellDelegate>
// @property (strong, nonatomic) IBOutlet UITextField *personNameTextField;
@property (weak, nonatomic) id <AddPersonTVCDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *personFirstnameTextField;
@property (strong, nonatomic) IBOutlet UITextField *personSurnameTextField;
@property (strong, nonatomic) IBOutlet RolePickerTVCell *personRoleTVCell;
@property (strong, nonatomic) Role *selectedRole;
- (IBAction)save:(id)sender;
@end
