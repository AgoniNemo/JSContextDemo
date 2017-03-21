//
//  JSContextViewController.m
//  JSContextDemo
//
//  Created by Mjwon on 2017/1/12.
//  Copyright © 2017年 Nemo. All rights reserved.
//

#import "JSContextViewController.h"
#import <WebKit/WKScriptMessageHandler.h>
#import <WebKit/WebKit.h>
#import <JavaScriptCore/JavaScriptCore.h>
#import "JSExportDelegate.h"
#import "JSObject.h"

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN [UIScreen mainScreen].bounds

@interface JSContextViewController ()<UIWebViewDelegate,JSExportDelegate>

@property (nonatomic ,strong) UIWebView *webView;

@end

@implementation JSContextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"text"ofType:@"html"];
    NSURL *rul = [NSURL fileURLWithPath:htmlPath];
    NSURLRequest *request = [NSURLRequest requestWithURL:rul];
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    _webView.delegate = self;
    [_webView loadRequest:request];
    [self.view addSubview:_webView];
    
    [self createJSContext];
        
}
-(NSString *)getAccessToken
{
    return @"这就是VC的token";
}
#pragma mark - UIWebView

-(void)webViewDidStartLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
    
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    NSLog(@"%s",__func__);
}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{
    
    NSString * address = request.URL.absoluteString;
    NSLog(@"jScript:%@",address);
    
    return YES;
}

-(void)createJSContext{
    
    // 通过UIWebView获得网页中的JavaScript执行环境
    JSContext *context = [_webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 设置处理异常的block回调
    [context setExceptionHandler:^(JSContext *ctx, JSValue *value) {
        NSLog(@"error: %@", value);
    }];
    
    JSObject *obj = [[JSObject alloc] init];
    context[@"iOS"] = obj;
    
}
-(void)dealloc{
    NSLog(@"我被释放了!!!");

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
