//
//  registertion.m
//  
//
//  Created by a on 06/09/16.
//
//

#import "registertion.h"

@interface registertion ()<UITextFieldDelegate>{
    
  
    NSDictionary *respo;
}

@end

@implementation registertion

- (void)viewDidLoad {
    [super viewDidLoad];
  //  UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(dismisskeyboard1)];
    //hai
}
-(void)dismisskeyboard1{
    [self.email resignFirstResponder];
    [self.pass resignFirstResponder];
    [self.fname resignFirstResponder];
    [self.sname resignFirstResponder];
    
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGPoint scrollviewpoint=CGPointMake(0, textField.frame.origin.y);
    [self.scrollview setContentOffset:scrollviewpoint animated:YES];
    
    
}
-(void)textFieldDidEndEditing:(UITextField *)textField{

    [self.scrollview setContentOffset:CGPointZero animated:YES];
}

-(void)callApi{
        NSString *email=self.email.text;
        NSString *pass=self.pass.text;
        NSString *fname=self.fname.text;
        NSString *sname=self.sname.text;
        NSString *gender=self.gender.text;
        //NSLog(@"%@%@%@%@%@",email,pass,fname,sname,gender);
        
        NSString *str =[NSString stringWithFormat: @"http://kenby.me/kenby/index.php?tag=register&email=%@&password=%@&fname=%@&lname=%@&gender=%@",email,pass,fname,sname,gender];
        NSURL *url = [NSURL URLWithString:str];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
        [request setHTTPMethod:@"GET"];
        [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSURLSession *session = [NSURLSession sharedSession];
        NSURLSessionDataTask *task=[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSError *err;
        NSString *Str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",Str);
        respo=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        NSLog(@"%@",data);
        NSNumber *check=[respo objectForKey:@"error"];
                if ([check boolValue ]== 0){
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        

                        [self.navigationController popToRootViewControllerAnimated:YES];
                    });
                }else
                {
                    self.alert=[UIAlertController alertControllerWithTitle: @"Alert" message:@"Unsuccessfull Registation" preferredStyle:UIAlertControllerStyleAlert];
                    [self presentViewController:self.alert animated:YES completion:nil];
                    UIAlertAction *okaction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                        
                    }];
                    [self.alert addAction:okaction];
                }
                }];
        [task resume];
        }



- (IBAction)selectGender:(UIButton *)sender {
    self.alert=[UIAlertController alertControllerWithTitle:@"Select" message:@"Select Gender" preferredStyle:UIAlertControllerStyleAlert];
    [self presentViewController:self.alert animated:YES completion:nil];
 
    UIAlertAction *femaleaction =[UIAlertAction actionWithTitle:@"Female" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.gender.text=@"Female";
    }];
    UIAlertAction *maleaction =[UIAlertAction actionWithTitle:@"Male" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        self.gender.text=@"Male";
    }];
    
    
    [self.alert addAction:maleaction];
    [self.alert addAction:femaleaction];
}

- (IBAction)registerBtn:(UIButton *)sender {
    if (self.fname.text.length==0) {
        [self alert1];
    }
    else if (self.sname.text.length==0) {
        [self alert1];
    }
    else if (self.email.text.length==0) {
        [self alert1];
    }
    else if (self.pass.text.length==0) {
        [self alert1];
    }
    else if (self.gender.text.length==0) {
        [self alert1];
    }

        [self callApi];
    
}

-(void) alert1{
    self.alert = [UIAlertController alertControllerWithTitle:@"error" message:@"Fields Should Not Be Empty" preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:self.alert animated:YES completion:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * __nonnull action) {
    }];
    [self.alert addAction:okAction];
}



-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
 
 
 if (textField.tag==0)
 {
 
 if(self.email.text.length>0)
 {
 NSString *emailRe=@"[A-Z0-9a-z.#%$&_+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}";
 NSPredicate *emailTest= [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRe];
 if ([emailTest evaluateWithObject:self.email.text]==YES)
 {
 return  YES;
 }
 else
 {
 self.alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Email Should Be In Proper Format" preferredStyle:UIAlertControllerStyleAlert];
 [self presentViewController:self.alert animated:YES completion:nil];
 UIAlertAction *okaction =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
 
 }];
 [self.alert addAction:okaction];
 return NO;
 }
 }
  

 }
 else if(textField.tag==1)
 {
 NSString  *strr1= self.pass.text;
 if (strr1.length<8){
 self.alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Passwords Length Should Be Minimum 8 Charcters" preferredStyle:UIAlertControllerStyleAlert];
 [self presentViewController:self.alert animated:YES completion:nil];
 UIAlertAction *okaction =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
 
 }];
 [self.alert addAction:okaction];
 return NO;
 }
 
 }
 
 return YES;
 }


- (BOOL)textFieldShouldClear:(UITextField *)textField{
    return YES;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    NSInteger nextTag=textField.tag + 1;
    UIResponder *nextResponder=[textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        [nextResponder becomeFirstResponder];
    }
    else{
        [textField resignFirstResponder];
    }
    return NO;
}






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






