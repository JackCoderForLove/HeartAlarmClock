//
//  BaseWebViewController.m
//  App
//
//  Created by weixhe on 16/4/27.
//  Copyright © 2016年 weixhe. All rights reserved.
//

#import "BaseWebViewController.h"

@interface BaseWebViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation BaseWebViewController


- (instancetype)initWithUrl:(NSString *)url navTitle:(NSString *)title
{
    if (self = [super init]) {
        self.navTitle = title;
        self.url = url;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView = [UIWebView createWebViewFrame:self.view.bounds delegate:self superView:self.view];
    //设置语言版本
    NSString *language = [ToolsHelper jcGetCurrentLanguage];
    NSMutableURLRequest *jcRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [jcRequest setValue:language forHTTPHeaderField:@"language"];
    [self.webView loadRequest:jcRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIWebViewDelegate
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSString *url = request.URL.absoluteString;
    if ([url hasPrefix:@"ios://"]) {
//        window.location.href
        // IOS与JS交互时，JS调用IOS方法，特有的url格式：ios://method//param1//param2//param3...
        
        NSArray *arr = [url componentsSeparatedByString:@"://"];
        
        if (arr.count == 1) {
            return YES;
        } else {
            NSArray *method_paramArr = [[arr lastObject] componentsSeparatedByString:@"//"];
            CLog(@"方法和参数，第一个是方法名，再往后都是JS传递过来的参数 \n %@", method_paramArr);
            
            NSString *method = [method_paramArr firstObject];
            NSMutableArray *paramsArr = [NSMutableArray arrayWithArray:method_paramArr];
            [paramsArr removeObjectAtIndex:0];
            
            // 只有方法名，没有参数(此处需要根据具体的情况自定义)
            if ([method isEqualToString:@"methodName"]) {
//                [self methodName];
            } else {
//                [self methodNameArr:parparamsArrams];
            }
        }
    }

    return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CLog(@"webViewDidFinishLoad");
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    CLog(@"didFailLoadWithError = %@", error);
}

@end
