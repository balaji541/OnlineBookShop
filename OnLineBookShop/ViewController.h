//
//  ViewController.h
//  OnLineBookShop
//
//  Created by a on 05/09/16.
//  Copyright (c) 2016 a. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *Title;
@property (weak, nonatomic) IBOutlet UITextField *EMail;
@property (weak, nonatomic) IBOutlet UITextField *Password;
//@property (weak, nonatomic) IBOutlet UIButton *signin;
@property(nonatomic,strong)UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end

