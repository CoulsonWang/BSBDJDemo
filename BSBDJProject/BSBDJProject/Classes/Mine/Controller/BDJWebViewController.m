//
//  BDJWebViewController.m
//  BSBDJProject
//
//  Created by Coulson_Wang on 2017/6/27.
//  Copyright © 2017年 Coulson_Wang. All rights reserved.
//

#import "BDJWebViewController.h"
#import <WebKit/WebKit.h>

@interface BDJWebViewController ()
@property (weak, nonatomic) IBOutlet UIView *placeholderView;
@property (weak, nonatomic) WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *forwardBtn;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation BDJWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WKWebView *webView = [[WKWebView alloc] init];
    self.webView = webView;
    [self.placeholderView addSubview:webView];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:self.url];
    [webView loadRequest:request];
    
    [webView addObserver:self forKeyPath:@"canGoBack" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"canGoForward" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"title" options:NSKeyValueObservingOptionNew context:nil];
    [webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    _webView.frame = self.placeholderView.bounds;
}

- (void)dealloc {
    [self.webView removeObserver:self forKeyPath:@"canGoBack"];
    [self.webView removeObserver:self forKeyPath:@"canGoForward"];
    [self.webView removeObserver:self forKeyPath:@"title"];
    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

- (IBAction)goback:(UIBarButtonItem *)sender {
    [self.webView goBack];
}

- (IBAction)goForward:(UIBarButtonItem *)sender {
    [self.webView goForward];
}
- (IBAction)refresh:(UIBarButtonItem *)sender {
    [self.webView reload];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    self.backBtn.enabled = self.webView.canGoBack;
    self.forwardBtn.enabled = self.webView.canGoForward;
    self.title = self.webView.title;
    self.progressView.progress = self.webView.estimatedProgress;
    self.progressView.hidden = self.webView.estimatedProgress >= 1;
}

@end
