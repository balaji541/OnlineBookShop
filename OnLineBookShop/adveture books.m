//
//  adveture books.m
//  
//
//  Created by a on 12/09/16.
//
//

#import "adveture books.h"
#import "SWRevealViewController.h"
#import "advcustomcell.h"
#import "ViewBooks.h"
@interface adveture_books ()<UITableViewDataSource,UITableViewDelegate>{
    NSMutableArray *cbooks  ;
    NSMutableArray *mbooks;
    NSMutableArray *ebooks;

}

@end

@implementation adveture_books

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    cbooks=[NSMutableArray arrayWithObjects:@"Java",@"Database",@"Objective c",@"Networking", nil];
    ebooks=[NSMutableArray arrayWithObjects:@"Electronics",@"DigitalSystems",@ "MicroComputers",@"PowerSystems",nil];
    mbooks=[NSMutableArray arrayWithObjects:@"EngineeringDrawing",@"AutoCad",@ "Drawing",@"Mechines",nil];
    
    self.barButton.target=self.revealViewController;
    self.barButton.action=@selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    //self.view.backgroundColor=[UIColor blueColor];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSInteger val;
    if(section==0){
        val= cbooks.count;
    }else if (section==1){
        val= ebooks.count;
    }else{
        val=mbooks.count;
    }
    return val;
}




-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    advcustomcell *cell=[tableView dequeueReusableCellWithIdentifier:@"Books"];
    if (indexPath.section==0) {
        NSString *bname=[cbooks objectAtIndex:indexPath.row];
        cell.self.name.text=bname;
    }else if (indexPath.section==1){
        NSString *bname=[ebooks objectAtIndex:indexPath.row];
        cell.self.name.text=bname;
    }else   {
        NSString *bname=[mbooks objectAtIndex:indexPath.row];
        cell.self.name.text=bname;
    }
    
    
    
    return  cell;
    
}
/*- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
 {
 UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
 cell.textLabel.text=@"hello";
 
 return cell;
 
 }*/
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString * name;
    if(section==0){
        name= @"Computer Science Books";
    }else if (section==1){
        name=@"Electrical & Electronic Books ";
    }else {
        name= @"Mechnical Engineering Books";
    }
    return name;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        NSString *bname=[cbooks objectAtIndex:indexPath.row];
        NSString *title=bname;
        [self performSegueWithIdentifier:@"viewbooks"sender:title];
    }else if (indexPath.section==1){
        NSString *bname=[ebooks objectAtIndex:indexPath.row];
        NSString *title=bname;
        [self performSegueWithIdentifier:@"viewbooks"sender:title];
    }else  {
        NSString *bname=[mbooks objectAtIndex:indexPath.row];
        NSString *title=bname;
        [self performSegueWithIdentifier:@"viewbooks"sender:title];
    }
    
    
    
}
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"viewbooks"]) {
        ViewBooks *sec=segue.destinationViewController;
        sec.self.data=sender;
    }
    
}

@end
