//
//  DOCSplashViewController.m
//  Patience
//
//  Created by Angie Lal on 11/26/13.
//  Copyright (c) 2013 Angie Lal. All rights reserved.
//

#import "DOCSplashViewController.h"
#import "DOCAccount.h"
#import <AFNetworking/AFNetworking.h>

@interface DOCSplashViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UITextField *emailField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *logInButton;

@end

@implementation DOCSplashViewController

# pragma mark - View Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationController setNavigationBarHidden:YES];
    
	// Do any additional setup after loading the view
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc addObserver:self selector:@selector(moveKeyboard:) name:UIKeyboardWillShowNotification object:nil];
    [nc addObserver:self selector:@selector(moveKeyboard:) name:UIKeyboardWillHideNotification object:nil];
}

-(void)viewWillDisappear:(BOOL)animated
{
    NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
    [nc removeObserver:self];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    // Need to check if the user is logged in
    if ([[DOCAccount account] isLoggedIn]) {
        //look up provider for token
        [self.indicator startAnimating];
        [[AFHTTPRequestOperationManager manager] GET:API_URL(@"/providers/current")
                                          parameters:@{@"token" : [[DOCAccount account] authToken]}
                                             success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                                 //already logged in , found current provider, transition to tasks
                                                 [self.indicator stopAnimating];
                                                 [self setCurrentProviderAndSegue:responseObject[@"provider"]];
                                             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                                 [self.indicator stopAnimating];
                                                 [self showFields];
                                             }];
    } else {
        [self showFields];
    }
}

# pragma mark - misc

- (void)showFields
{
    self.emailField.alpha = self.passwordField.alpha = self.logInButton.alpha = 0;
    self.emailField.hidden = self.passwordField.hidden = self.logInButton.hidden = NO;
    [UIView animateWithDuration:0.25f animations:^{
        self.emailField.alpha = self.passwordField.alpha = self.logInButton.alpha = 1;
    }];
}

- (IBAction)willLogIn
{
    // try to auth the user with email and password
    self.logInButton.enabled = NO;
    [[AFHTTPRequestOperationManager manager] POST:API_URL(@"/providers/log_in")
                                       parameters:@{
                                                    @"email": self.emailField.text,
                                                    @"password": self.passwordField.text
                                                    }
                                          success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                              //authenticated
                                              //from json:
                                              //set token
                                              //set current provider
                                              [[DOCAccount account] logInWithToken:responseObject[@"token"]];
                                              [self setCurrentProviderAndSegue:responseObject[@"provider"]];
                                          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                              self.logInButton.enabled = YES;
                                              HUDWithErrorInView(self.view, @"Bad login.");

                                              NSLog(@"Could not authenticate, do something here to let the user know");
                                          }];
}

- (void)setCurrentProviderAndSegue:(id)currentProviderJson
{
    [[DOCAccount account] setCurrentProvider:[[DOCProvider alloc] initWithJson:currentProviderJson]];
    [self performSegueWithIdentifier:@"DOCProviderLoggedInSegue" sender:self];
}

- (void)moveKeyboard:(NSNotification*)notification
{
    NSValue *value = notification.userInfo [UIKeyboardFrameBeginUserInfoKey];
    CGRect frame;
    [value getValue:&frame];

//    [UIView animateWithDuration:duration delay:0 options:(curve << 16) animations:^{
//        CGRect frame = textField.frame;
//        frame.origin.y -= 50;
//        textField.frame = frame;
//    } completion:nil]
}
# pragma mark - UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if ([string isEqualToString:@"\n"]) {
        [textField resignFirstResponder];
        return NO;
    }
    return YES;
}

@end
