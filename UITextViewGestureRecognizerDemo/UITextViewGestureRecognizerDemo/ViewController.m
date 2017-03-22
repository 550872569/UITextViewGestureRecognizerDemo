//
//  ViewController.m
//  UITextViewGestureRecognizerDemo
//
//  Created by sogou-Yan on 17/3/22.
//  Copyright © 2017年 sogou. All rights reserved.
//

#import "ViewController.h"
#import <Masonry.h>

#define VGScreenW [UIScreen mainScreen].bounds.size.width
#define VGScreenH [UIScreen mainScreen].bounds.size.height
#define kShareImageTextForDebug  @"从前在北平读书的时候，老在城圈儿里呆着。四年中虽也游过三五回西山，却从没来过清华；说起清华，只觉得很远很远而已。那时也不认识清华人，有一回北大和清华学生在青年会举行英语辩论，我也去听。清华的英语确是流利得多，他们胜了。那回的题目和内容，已忘记干净；只记得复辩时，清华那位领袖很神气，引着孔子的什么话。北大答辩时，开头就用了fｕｒｉｏｕｓｌｙ一个字叙述这位领袖的态度。这个字也许太过，但也道着一点儿。那天清华学生是坐大汽车进城的，车便停在青年会前头；那时大汽车还很少。那是冬末春初，天很冷。一位清华学生在屋里只穿单大褂，将出门却套上厚厚的皮大氅。这种“行”和“衣”的路数，在当时却透着一股标劲儿。初来清华，在十四年夏天。刚从南方来北平，住在朝阳门边一个朋友家。那时教务长是张仲述先生，我们没见面。我写信给他，约定第三天上午去看他。写信时也和那位朋友商量过，十点赶得到清华么，从朝阳门哪儿？他那时已经来过一次，但似乎只记得“长林碧草”，"

@interface ViewController ()<UITextViewDelegate,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UITextView *textView;
@end

@implementation ViewController

#pragma mark - view cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self initUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

#pragma mark - Action
#pragma mark Action ------------

#pragma mark - INIT
#pragma mark INIT ------------ initUI
- (void)initUI {
    [self.view addSubview:self.textView];
    [self.textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.equalTo(self.view);
    }];
    
    UITapGestureRecognizer *tapOnceTextGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleClickTextGestureRecognizerAction:)];
    tapOnceTextGestureRecognizer.numberOfTapsRequired = 1;
    [self.textView addGestureRecognizer:tapOnceTextGestureRecognizer];
    tapOnceTextGestureRecognizer.delegate = self;
    
    UITapGestureRecognizer *tapTwiceGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleClickTextGestureRecognizerAction:)];
    tapTwiceGestureRecognizer.numberOfTapsRequired = 2;
    [self.textView addGestureRecognizer:tapTwiceGestureRecognizer];
    tapTwiceGestureRecognizer.delegate = self;
    
    UILongPressGestureRecognizer *longPressTextGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressTextGestureRecognizerAction:)];
    [self.textView addGestureRecognizer:longPressTextGestureRecognizer];
    longPressTextGestureRecognizer.delegate = self;
}
#pragma mark ActionTextview ------------ 单击
- (void)singleClickTextGestureRecognizerAction:(UITapGestureRecognizer *)sender {
    NSLog(@"单击 %ld",self.textView.selectedRange.location);
        [self editTextRecognizerTabbed:sender];
    
}

#pragma mark ActionTextview ------------ 双击
- (void)doubleClickTextGestureRecognizerAction:(UITapGestureRecognizer *)sender {
    NSLog(@"双 %ld",self.textView.selectedRange.location);
        [self editTextRecognizerTabbed:sender];
    
}

#pragma mark ActionTextview ------------ 长按
- (void)longPressTextGestureRecognizerAction:(UILongPressGestureRecognizer *)sender {
    NSLog(@"按 %ld",self.textView.selectedRange.location);
    
}
- (void)textViewDidBeginEditing:(UITextView *)textView {
    NSLog(@"begin %ld",textView.selectedRange.location);
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    NSLog(@"end %ld",textView.selectedRange.location);
}

- (void)textViewDidChangeSelection:(UITextView *)textView {
    NSLog(@"change %ld",textView.selectedRange.location);
}
/** 
 由于手势和代理冲突导致同时使用手势和代理会出问题
 核心代码 使用手势获取点击location
 */
- (BOOL)editTextRecognizerTabbed:(UITapGestureRecognizer *)aRecognizer {
    if (aRecognizer.state==UIGestureRecognizerStateEnded) {
        self.textView.editable = YES;
        self.textView.dataDetectorTypes = UIDataDetectorTypeNone;
        CGPoint point = [aRecognizer locationInView:self.view];
        UITextPosition * position=[self.textView closestPositionToPoint:point];
        [self.textView setSelectedTextRange:[self.textView textRangeFromPosition:position toPosition:position]];
    }
    return YES;
}
#pragma mark - SET
#pragma mark SET ------------

#pragma mark - LAZY
#pragma mark LAZY ------------
- (UITextView *)textView {
    if (!_textView) {
        _textView = [[UITextView alloc]init];
        _textView.text = kShareImageTextForDebug;
        _textView.textColor = [UIColor grayColor];
        [_textView setShowsVerticalScrollIndicator:NO];
        [_textView setShowsHorizontalScrollIndicator:NO];
        //        _textView.delegate = self;
    }
    return _textView;
}
@end
