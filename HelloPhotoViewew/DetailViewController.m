//
//  DetailViewController.m
//  HelloPhotoViewew
//
//  Created by 張峻綸 on 2016/5/27.
//  Copyright © 2016年 張峻綸. All rights reserved.
//

#import "DetailViewController.h"
#import "DataManager.h"
#import "QuartzCore/QuartzCore.h"
@interface DetailViewController ()<UIScrollViewDelegate>
{
    DataManager *datas;
    
    NSTimer * slideShowTimer;
}
@property (weak, nonatomic) IBOutlet UISlider *timeIntervalSlider;
@property (weak, nonatomic) IBOutlet UIImageView *photoImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *mainScrollView;
@end

@implementation DetailViewController



//因在Ipad上會預設選取第0張,所以讓_currentIndex=-1;
//只有從storeboard出來的才有initWithCoder,其它的沒有
-(instancetype)initWithCoder:(NSCoder *)aDecoder{
    
    //因不能憑空產生,要讓父類別產生後丟回來給自己,才能做下面的事情
    self=[super initWithCoder:aDecoder];
    _currentIndex=-1;
    return self;
}

#pragma mark - Managing the detail item
- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    /* 不支援scroller view寫法
    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
     */
    
    if(datas==nil || _currentIndex==-1){
        self.navigationItem.rightBarButtonItem=nil;
        return;
    }
    //拿到照片
    UIImage *targetImage=[datas getImageByIndex:_currentIndex];
    
    _photoImageView.image=targetImage;
    _photoImageView.contentMode=UIViewContentModeScaleAspectFit;
    
    //contentSize內容大小為targetImage.size;
    _mainScrollView.contentSize=targetImage.size;
    _mainScrollView.maximumZoomScale=5.0;
    _mainScrollView.minimumZoomScale=1.0;
    //縮放預設值為1倍
    _mainScrollView.zoomScale=1.0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //有scrollview時,預設畫面會往下調整,照片看起來會偏低,把預設關掉即可正常
    self.automaticallyAdjustsScrollViewInsets=false;
    
    datas = [DataManager sharedInstanse];
    
    [self configureView];
    
    //不輪播時_timeIntervalSlider隱藏起來
    _timeIntervalSlider.hidden=true;
}

//dealloc是解構式,當被解構時會跑這個函式
-(void) dealloc{
    NSLog(@"ViewCoontroller dealloc.");
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    if(slideShowTimer!=nil){
        //Simulate to press the stop button
        //模擬按下playStopBtnPressed,但因為沒有實體所以打上nil
        [self playStopBtnPressed:nil];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UIScrollViewDelegate Method
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return _photoImageView;
}
- (IBAction)toLeft:(UISwipeGestureRecognizer *)sender {
    
    //Add Animation
    CATransition *transition=[CATransition animation];
    //動畫幾秒時間
    transition.duration=0.5;
    //EaseIn是動畫一開始慢越來越快
    transition.timingFunction=[CAMediaTimingFunction
        functionWithName:kCAMediaTimingFunctionEaseIn];
    //push是新照片把舊照片擠出去
    transition.type=kCATransitionPush;
    //照片從右邊進來
    transition.subtype=kCATransitionFromRight;
    [_photoImageView.layer addAnimation:transition forKey:nil];
    
    
    _currentIndex+=1;
    if(_currentIndex==[datas getTotal]){
        _currentIndex=0;
    }
    [self configureView];
}
- (IBAction)toRight:(UISwipeGestureRecognizer *)sender {
    
    //Add Animation
    CATransition *transition=[CATransition animation];
    //動畫幾秒時間
    transition.duration=0.5;
    //EaseIn是動畫一開始慢越來越快
    transition.timingFunction=[CAMediaTimingFunction
                               functionWithName:kCAMediaTimingFunctionEaseIn];
    //push是新照片把舊照片擠出去
    transition.type=kCATransitionPush;
    //照片從右邊進來
    transition.subtype=kCATransitionFromLeft;
    [_photoImageView.layer addAnimation:transition forKey:nil];
    
    _currentIndex-=1;
    if (_currentIndex<0) {
        _currentIndex=[datas getTotal]-1;
    }
    [self configureView];
}


- (IBAction)timeIntervalValueChanged:(UISlider *)sender {
    //Stop Timer
    //不要使用Timer一定要下invalidate
    [slideShowTimer invalidate];
    slideShowTimer=nil;
    
    slideShowTimer=[NSTimer scheduledTimerWithTimeInterval:
        _timeIntervalSlider.value target:self
        selector:@selector(toLeft:) userInfo:nil repeats:true];
}

- (IBAction)playStopBtnPressed:(UIBarButtonItem *)sender {
    if(_timeIntervalSlider.hidden){
        //Will Start slide show
        
        UIBarButtonItem *stopBtn = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemStop
            target:self action:@selector(playStopBtnPressed:)];
        self.navigationItem.rightBarButtonItem=stopBtn;
        _timeIntervalSlider.hidden=false;
        
        //Start Timer
        slideShowTimer=[NSTimer scheduledTimerWithTimeInterval:
            _timeIntervalSlider.value target:self
            selector:@selector(toLeft:) userInfo:nil repeats:true];
        
    }else{
        //Will stop slide show
        UIBarButtonItem *playBtn = [[UIBarButtonItem alloc]
            initWithBarButtonSystemItem:UIBarButtonSystemItemPlay
            target:self action:@selector(playStopBtnPressed:)];
        self.navigationItem.rightBarButtonItem=playBtn;
        _timeIntervalSlider.hidden=true;
        
        //Stop Timer
        //不要使用Timer一定要下invalidate
        [slideShowTimer invalidate];
        slideShowTimer=nil;
    }
}


@end
