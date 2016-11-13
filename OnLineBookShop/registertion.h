//
//  registertion.h
//  
//
//  Created by a on 06/09/16.
//
//

#import <UIKit/UIKit.h>

@interface registertion : UIViewController
@property(nonatomic,weak)IBOutlet UITextField *email;
@property(nonatomic,weak)IBOutlet UITextField *pass;
@property(nonatomic,weak)IBOutlet UITextField *fname;
@property(nonatomic,weak)IBOutlet UITextField *sname;
@property(nonatomic,weak)IBOutlet UITextField *gender;
@property(nonatomic,strong)UIAlertController *alert;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollview;

@end
