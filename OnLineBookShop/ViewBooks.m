//
//  ViewBooks.m
//  
//
//  Created by a on 11/09/16.
//
//

#import "ViewBooks.h"

@interface ViewBooks ()

@end

@implementation ViewBooks

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *bookname=self.data;
    NSString *path=[[NSBundle  mainBundle]pathForResource:bookname ofType:@"pdf"];
    NSURL *url=[NSURL fileURLWithPath:path];
    NSURLRequest* request=[NSURLRequest requestWithURL:url];
    [self.webview loadRequest:request];
    self.webview.paginationMode= UIWebPaginationModeLeftToRight;
    self.webview.scalesPageToFit=YES;
}
//- (IBAction)popViewController:(id)sender
//{
//    [self.navigationController popViewControllerAnimated:YES];
//}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
