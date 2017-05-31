//
//  ViewController.m
//  CalendarSign
//
//  Created by WYN on 2017/5/31.
//  Copyright © 2017年 WYN. All rights reserved.
//

#import "ViewController.h"
#import "QianDaoViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton*btn=[[UIButton alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    [btn setTitle:@"去签到" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    
}

-(void)click
{
    QianDaoViewController*qiandaoVC=[[QianDaoViewController alloc]init];
    qiandaoVC.title=@"签到";
    [self presentViewController:qiandaoVC animated:YES completion:nil];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
