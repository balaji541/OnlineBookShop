//
//  ViewController.m
//  OnLineBookShop
//
//  Created by a on 05/09/16.
//  Copyright (c) 2016 a. All rights reserved.
//

#import "ViewController.h"
#import "SWRevealViewController.h"

@interface ViewController ()<UITextFieldDelegate>{
     NSDictionary *respo;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
     // UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self  action:@selector(dismisskeyboard1)];
//     NSString *stringkey = [[NSUserDefaults standardUserDefaults] stringForKey:@"Emailidkey"];
//    NSLog(@"login sucess");
//    NSLog(@"%@",stringkey);
//   if (stringkey == nil)
//   {
//       NSLog(@"login plz");
//   }else
//    {
//      NSLog(@"login sucess");
////     [self performSegueWithIdentifier:@"hai" sender:nil];
//       SWRevealViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"SWReveal"];
//        [self.navigationController pushViewController:vc animated:YES];
//
//    
//   }
    
}
-(void)dismisskeyboard1{
    [self.EMail resignFirstResponder];
    [self.Password resignFirstResponder];
}
-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGPoint scrollviewpoint=CGPointMake(0, textField.frame.origin.y);
    [self.scrollview setContentOffset:scrollviewpoint animated:YES];
    self.EMail.keyboardAppearance=YES;
    self.Password.keyboardAppearance=YES;
    
}
//-(void)textFieldDidEndEditing:(UITextField *)textField{
    
//    [self.scrollview setContentOffset:CGPointZero animated:YES];
//}
-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
    
    if (textField.tag==0)
    {
       if(self.EMail.text.length>0)
        {
            NSString *emailRe=@"[A-Z0-9a-z.#%$&_+-]+@[A-Za-z0-9.-]+.[A-Za-z]{2,4}";
            NSPredicate *emailTest= [NSPredicate predicateWithFormat:@"SELF MATCHES %@",emailRe];
            if ([emailTest evaluateWithObject:self.EMail.text]==YES)
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
            }}
         [self.scrollview setContentOffset:CGPointZero animated:YES];
    }
    else if(textField.tag==1)
    {

        NSString  *strr1= self.Password.text;
        if (strr1.length<8){
            self.alert=[UIAlertController alertControllerWithTitle:@"Error" message:@"Passwords Length Should Be Minimum 8 Charcters" preferredStyle:UIAlertControllerStyleAlert];
            [self presentViewController:self.alert animated:YES completion:nil];
            UIAlertAction *okaction =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                
            }];
            [self.alert addAction:okaction];
            return NO;
        }
        [self.scrollview setContentOffset:CGPointZero animated:YES];
    }
    
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


-(IBAction)login:(id)sender
{
    if (self.EMail.text.length==0) {
        [self alert1];
    } else if (self.Password.text.length==0) {
        [self alert1];
    }else{
   
     //self.Password.enabled=NO;
    
    NSString *str = [NSString stringWithFormat:@"http://kenby.me/kenby/index.php?tag=login&email=%@&password=%@",self.EMail.text,self.Password.text];
    NSURL *url = [NSURL URLWithString:str];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    
    [request setHTTPMethod:@"GET"];
    [request addValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task =[session dataTaskWithRequest:request completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
        NSString *str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",str);
        NSError *err ;
        
        
        NSString *Str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
        NSLog(@"%@",Str);
        respo=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&err];
        NSLog(@"%@",data);
        NSLog(@"%@",respo);
       
        dispatch_async(dispatch_get_main_queue(), ^{
            
            NSNumber *check=[respo objectForKey:@"error"];
            
            if ([check boolValue ]== 0){
                NSDictionary *emailuser=[respo objectForKey:@"user"];
                NSString *Emailkey=[emailuser objectForKey:@"email"];
                NSLog(@"%@",Emailkey);
               
                [[NSUserDefaults standardUserDefaults]setObject:Emailkey forKey:@"Emailidkey"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [self performSegueWithIdentifier:@"SWRevealViewController" sender:nil];
            }else
            {
                self.alert=[UIAlertController alertControllerWithTitle: @"Alert" message:@"Unsuccessfull Registation" preferredStyle:UIAlertControllerStyleAlert];
                [self presentViewController:self.alert animated:YES completion:nil];
                UIAlertAction *okaction=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                    
                }];
                [self.alert addAction:okaction];
            }
            
            
        });

    }];
    [task resume];
}
}
-(void) alert1{
    self.alert = [UIAlertController alertControllerWithTitle:@"error" message:@"Fields Should Not Be Empty" preferredStyle:UIAlertControllerStyleAlert];
    
    [self presentViewController:self.alert animated:YES completion:nil];
    
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * __nonnull action) {
    }];
    [self.alert addAction:okAction];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
