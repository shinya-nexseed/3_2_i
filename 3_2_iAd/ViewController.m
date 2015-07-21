//
//  ViewController.m
//  3_2_iAd
//
//  Created by Shinya Hirai on 2015/07/21.
//  Copyright (c) 2015年 Shinya Hirai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () {
    ADBannerView *_adView; // バナー表示用のview
    BOOL _isVisible; // バナーの表示状態を判定するためのフラグ
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    // 注意点
    // adViewのサイズには決まりがある
    // 上とか下にでてくるような帯状の横長の広告
    // 画面のどこにでもおけるような正方形のアイコン広告
    
    // 初期化
    _adView = [[ADBannerView alloc] init];
    
    // 場所を決定
    _adView.frame = CGRectMake(0, -_adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
    // frameプロパティは、いろんなパーツを使う上でよく使用します。
    // CGRectMake
    // 指定する４つの要素(x,y,w,h);
    
    // まずは透明でセット
    // 広告の読み込みが終わるまで
    _adView.alpha = 0.0;
    
    _adView.delegate = self;
    
    // self.viewに追加 (addSubView)
    [self.view addSubview:_adView];
    // コードで自作したパーツは、addSubViewがないと表示されない
    // これもよく忘れてハマるポイント
    
    // バナーはまだ表示されていないので、フラグを下ろす
    _isVisible = NO;
}

// バナーが正常に読み込まれた際の処理
- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!_isVisible) {
        [UIView beginAnimations:@"animateAdBannerOn" context:nil];
        [UIView setAnimationDuration:0.3];
        
        banner.frame = CGRectOffset(banner.frame, 0, CGRectGetHeight(banner.frame));
        banner.alpha = 1.0;
        [UIView commitAnimations];
        
        _isVisible = YES;
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error {
    if (_isVisible) {
        
        [UIView beginAnimations:@"animateAdBannerOff" context:nil];
        [UIView setAnimationDuration:0.3];
        
        _adView.frame = CGRectMake(0, -_adView.frame.size.height, _adView.frame.size.width, _adView.frame.size.height);
        
        banner.alpha = 0.0;
        [UIView commitAnimations];
        
        _isVisible = NO;
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
