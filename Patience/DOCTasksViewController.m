//
//  DOCTasksViewController.m
//  Patience
//
//  Created by Angie Lal on 11/11/13.
//  Copyright (c) 2013 Angie Lal. All rights reserved.
//

#import "DOCTasksViewController.h"
#import "DOCTask.h"
#import <AFNetworking/AFNetworking.h>
#import "DOCTaskDetailViewController.h"

@interface DOCTasksViewController ()

@property (strong, nonatomic) NSMutableArray *tasks;

@end

@implementation DOCTasksViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.title = @"Tasks";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];

    if (!self.tasks) {
        self.tasks = [NSMutableArray array];
    }

    [self loadTasks:nil];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)loadTasks:(UIRefreshControl *)refreshControl
{
    // Load Tasks
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:@"http://localhost:5000/"
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             // remove any tasks if there were any
             [self.tasks removeAllObjects];
             for (NSDictionary *dict in responseObject[@"tasks"]) {
                 NSLog(@"%@", dict);
                 [_tasks addObject:[[DOCTask alloc] initWithJson:dict]];
             }

             /* Usually need to update the UI on the main thread, but for now let's not do this */
             //             dispatch_async(dispatch_get_main_queue(), ^{
             //                 ;
             //             });
             [self.tableView reloadData];
             //refresh control could be nil
             [refreshControl endRefreshing];
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             NSLog(@"This request failed: %@", error);
         }];
}

/* Very much like we do for buttons, we create an IBAction for our UIRefreshControl */
//this could be any name, we will wire up in IB
//the sender will always be a UIRefreshControl, since we control (via IB) when this method gets called
//I can explain this more later in person
- (IBAction)willRefresh:(UIRefreshControl *)refreshControl
{
    NSLog(@"Will refresh tasks");
    [self loadTasks:refreshControl];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    if (!self.tasks || [self.tasks count] == 0) {
        return 0;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.tasks count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    cell.textLabel.text = [(DOCTask *)self.tasks[indexPath.row] issue];
    //cell.accessoryType = UITableViewCellAccessoryCheckmark;
    // Configure the cell...
    
    return cell;
}

//- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  //  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
 //   cell.accessoryType = UITableViewCellAccessoryCheckmark;

    [self performSegueWithIdentifier:@"DOCTaskDetailsSegue" sender:self];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue destinationViewController] isKindOfClass:[DOCTaskDetailViewController class]]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        DOCTask *task = self.tasks[indexPath.row];
        ((DOCTaskDetailViewController *)[segue destinationViewController]).task = task;
    }
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}



@end
