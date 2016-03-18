//
//  ProtocolViewController.m
//  WeCanPay
//
//  Created by wecan－mac on 16/3/18.
//  Copyright © 2016年 wecan. All rights reserved.
//

#import "BaseWKWebViewController.h"
@import WebKit;

@interface BaseWKWebViewController ()
@property(nonatomic,strong) WKWebView *webView;

@end

@implementation BaseWKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.webView=[[WKWebView alloc]init];
    [self.view addSubview:self.webView];
    [self.webView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
    }];
//    if (_htmlPath) {
//        [self showHtmlWithPath:self.htmlPath];
//    }
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (_htmlPath) {
        [self showHtmlWithPath:self.htmlPath];
    }
    if (_request) {
        [self showUrlWithPath:self.request];
    }

}
-(void)showHtmlWithPath:(NSString *)path{
    NSString *htmlString=[NSString stringWithContentsOfFile:path  encoding:NSUTF8StringEncoding error:nil];
    
    [self.webView loadHTMLString:htmlString baseURL:[NSURL URLWithString:path]];
}

-(void)showUrlWithPath:(NSString *)path{
    
   NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:path]];
    [self.webView loadRequest:request];
}

@end
