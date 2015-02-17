//
//  RolePickerTVCell.h
//  StaffManager
//
//  Created by Dejan Kumric on 2/16/15.
//  Copyright (c) 2015 Dejan Kumric. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CoreDataTableViewCell.h"
#import "Role.h"

@class RolePickerTVCell;

@protocol RolePickerTVCellDelegate
- (void)roleWasSelectedOnPicker:(Role*)role;
@end

@interface RolePickerTVCell : CoreDataTableViewCell <UIPickerViewDataSource, UIPickerViewDelegate>

@property (nonatomic, weak) id <RolePickerTVCellDelegate> delegate;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) Role *selectedRole;

@end
