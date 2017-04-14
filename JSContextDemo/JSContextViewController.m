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
#import "MLeaksFinder.h"

#define SCREENWIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREEN [UIScreen mainScreen].bounds

@interface JSContextViewController ()<UIWebViewDelegate>

@property (nonatomic ,weak) UIWebView *webView;
@property (nonatomic ,weak) JSObject *obj;
@property (nonatomic ,weak) JSContext *context;;
@end

@implementation JSContextViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"text"ofType:@"html"];
    
    UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
    webView.delegate = self;
    [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
    _webView = webView;
    [self.view addSubview:self.webView];
    
    [self createJSContext];
        
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
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    
    // 设置处理异常的block回调
    [context setExceptionHandler:^(JSContext *ctx, JSValue *value) {
        NSLog(@"error: %@", value);
    }];

    /**
    JSObject *obj = [[JSObject alloc] init];
    context[@"iOS"] = obj;
    */
    
    JSValue *js = context[@"iOS"];
    [js callWithArguments:@[@"这是token!!!!"]];
    
}

- (BOOL)willDealloc {
    if (![super willDealloc]) {
        return NO;
    }
    MLCheck(self.context);
    MLCheck(self.obj);
    MLCheck(self.webView);
    return YES;
}

-(void)dealloc{
    
    JSContext *context = [self.webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    context[@"iOS"] = nil;
    
    NSLog(@"我被释放了!!!");

}
/**
-(UIWebView *)webView
{
    if (_webView == nil) {
        NSString * htmlPath = [[NSBundle mainBundle] pathForResource:@"text"ofType:@"html"];
        
        UIWebView *webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, SCREENHEIGHT)];
        webView.delegate = self;
        [webView loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:htmlPath]]];
        _webView = webView;
    }
    return _webView;
}
*/
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
