//
//  DOCNewPatientViewController.m
//  Patience
//
//  Created by Angie Lal on 11/25/13.
//  Copyright (c) 2013 Angie Lal. All rights reserved.
//

#import "DOCNewPatientViewController.h"
#import <AFNetworking/AFNetworking.h>

@interface DOCNewPatientViewController ()

@property (strong, nonatomic) IBOutlet UIImageView *photo;
@property (strong, nonatomic) IBOutlet UITextField *name;
@property (strong, nonatomic) IBOutlet UITextField *phoneNumber;

@end

@implementation DOCNewPatientViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

#pragma mark - UIResponder

- (IBAction)willCreatePatient:(UIBarButtonItem *)createButton
{
    createButton.enabled = NO;
//    [[AFHTTPRequestOperationManager manager] POST:@"/patients/create"
//                                       parameters:<#(NSDictionary *)#>
//                                          success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#>
//                                          failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>];
}

- (IBAction)willCancel:(UIBarButtonItem *)cancelButton
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}



@end
