//
//  ViewController.m
//  JSContextDemo
//
//  Created by Mjwon on 2017/1/3.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "ViewController.h"
#import "JSContextViewController.h"
#import "JSObject.h"

@interface ViewController ()<UIWebViewDelegate>


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self createItem];
    
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://59.37.42.4:8090/headPortraitDownload?path=D:\\im\\img\\headPortrait\100517036101.png"]];
    UIImage *image = [UIImage imageWithData:data];
    
    UIImageView *imageV = [[UIImageView alloc] initWithImage:image];
    imageV.frame = CGRectMake(0, 100, image.size.width, image.size.width*667/375);
    [self.view addSubview:imageV];
}

-(void)createItem{
    
    UIButton *rightbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    rightbtn.frame = CGRectMake(0, 0, 130, 23);
    [rightbtn setTitle:@"跳转到下个界面" forState:UIControlStateNormal];
    [rightbtn addTarget:self action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:rightbtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    /**
    UIButton *leftbtn = [UIButton buttonWithType:UIButtonTypeSystem];
    leftbtn.frame = CGRectMake(0, 0, 50, 23);
    [leftbtn setTitle:@"左点击" forState:UIControlStateNormal];
    [leftbtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftbtn];
    self.navigationItem.leftBarButtonItem = leftItem;
     */
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self action];
}
-(void)backAction{

    NSLog(@"%s",__func__);
}

-(void)action{
    
    JSContextViewController *vc = [[JSContextViewController alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
