//
//  DOCProvidersViewController.h
//  Patience
//
//  Created by Angie Lal on 11/14/13.
//  Copyright (c) 2013 Angie Lal. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DOCProvider.h"

@interface DOCProvidersViewController : UITableViewController
@property (nonatomic, strong) NSIndexPath* checkedIndexPath;
@property (nonatomic, strong) DOCProvider *provider;
@end
