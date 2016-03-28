//
//  ViewController.m
//  Fly手势解锁
//
//  Created by 李飞翔 on 16/3/28.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "ViewController.h"
#import "LockView.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];


    LockView*lv=[[LockView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    [self.view addSubview:lv];
    
    
    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
