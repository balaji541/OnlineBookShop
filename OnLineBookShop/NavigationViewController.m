//
//  NavigationViewController.m
//  
//
//  Created by a on 07/09/16.
//
//

#import "NavigationViewController.h"
#import "SWRevealViewController.h"

@interface NavigationViewController ()

@end

@implementation NavigationViewController{
    NSArray *menu;
    UITableViewCell *cell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    menu=@[@"first",@"second",@"third",@"four",@"five"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    return menu.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *Cellidentifier=[menu objectAtIndex:indexPath.row];
    
  cell = [tableView dequeueReusableCellWithIdentifier:Cellidentifier forIndexPath:indexPath];
    
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
  
    
        NSString * data=cell.textLabel.text;
        NSLog(@"%@",data);
    if ([data isEqual:@"Logout"]) {
        
                [[NSUserDefaults standardUserDefaults]setObject:nil forKey:@"Emailidkey"];
                NSString *stringkey = [[NSUserDefaults standardUserDefaults] stringForKey:@"Emailidkey"];
                NSLog(@"%@",stringkey);
                [[NSUserDefaults standardUserDefaults]synchronize];
        

    }
    
}


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue isKindOfClass:[SWRevealViewControllerSeguePushController class]]) {
        SWRevealViewControllerSeguePushController *swsegue=(SWRevealViewControllerSeguePushController *)segue;
        [swsegue perform];/*=^(SWRevealViewControllerSegueSetController* rvc_segue,UIViewController *svc,UIViewController *dvc){
            UINavigationController *navcontroller=(UINavigationController *)
            self.revealViewController.frontViewController;
            [navcontroller setViewControllers:@[dvc] animated:YES];
        };*/
        }
}



@end
