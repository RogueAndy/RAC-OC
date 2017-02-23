//
//  OneViewController.m
//  RAC
//
//  Created by rogue on 2017/2/15.
//  Copyright © 2017年 RogueAndy. All rights reserved.
//

#import "OneViewController.h"
#import "Masonry.h"
#import "ReactiveCocoa.h"
#import "TwoViewController.h"

@interface OneViewController ()

@property (nonatomic, strong) UIButton *r_one;

@property (nonatomic, strong) UILabel *r_one_label;

@property (nonatomic, strong) RACCommand *command;

@end

@implementation OneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor orangeColor];
    
    self.r_one = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.r_one_label = [[UILabel alloc] initWithFrame:CGRectZero];
    self.r_one_label.frame = CGRectMake(20, 200, 100, 40);
    self.r_one_label.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.r_one_label];
    self.r_one_label.center = CGPointMake(70, 220);
    
    [[self.r_one_label rac_valuesAndChangesForKeyPath:@"center" options:NSKeyValueObservingOptionNew observer:nil] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];
    
    UIButton *sender = [UIButton buttonWithType:UIButtonTypeCustom];
    sender.frame = CGRectMake(20, 100, self.view.frame.size.width - 40, 40);
    sender.backgroundColor = [UIColor yellowColor];
//    [sender addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    @weakify(self);
    [[sender rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        @strongify(self);
        [self method4];
    }];
    [self.view addSubview:sender];

    [self method5];
    
}

- (void)btnClick:(UIButton *)sender {

    self.r_one_label.center = CGPointMake(170, 220);
    return;
    
    TwoViewController *twoVc = [[TwoViewController alloc] init];
    twoVc.delegateSignal = [RACSubject subject];
    [twoVc.delegateSignal subscribeNext:^(id x) {
        NSLog(@"点击了通知按钮%@", x);
    }];
    
    [self presentViewController:twoVc animated:YES completion:nil];
    
}

/**
 RACSignal 的使用
 */
- (void)method1 {

    RACSignal *signal = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@15];
        [subscriber sendCompleted];
        return [RACDisposable disposableWithBlock:^{
            NSLog(@"信号被销毁");
        }];
    }];
    
    NSLog(@"111111");
    
    [signal subscribeNext:^(id x) {
        NSLog(@"接收到数据:%@", x);
    }];
    
    NSLog(@"哈哈哈");

}

/**
 RACSubject 和其子类的使用
 */
- (void)method2 {

    RACSubject *subject = [RACSubject subject];
    [subject subscribeNext:^(id x) {
        NSLog(@"第一个订阅者%@", x);
    }];
    
    [subject subscribeNext:^(id x) {
        NSLog(@"第二个订阅者%@", x);
    }];
    [subject sendNext:@3];
    
    NSLog(@"----------");
    
    RACReplaySubject *replay = [RACReplaySubject subject];
    
    [replay sendNext:@1];
    [replay sendNext:@2];
    [replay subscribeNext:^(id x) {
        NSLog(@"replay第一个订阅者%@", x);
    }];
    
    [replay subscribeNext:^(id x) {
        NSLog(@"replay第二个订阅者%@", x);
    }];
    

}

/**
 RACCommand 的使用
 */
- (void)method3 {

    RACCommand *command = [[RACCommand alloc] initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"执行命令");
        
        // 如果是要创建空信号，则使用 [RACSignal empty];
        return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            [subscriber sendNext:@"请求数据"];
            [subscriber sendCompleted];
            return nil;
        }];
    }];
    
    // RACCommand 命令必须使用强引用，否则，对象被销毁，则无法接受数据
    _command = command;
    
    [command.executionSignals subscribeNext:^(id x) {
        [x subscribeNext:^(id x) {
            NSLog(@"1-----%@", x);
        }];
    }];
    
    [command.executionSignals.switchToLatest subscribeNext:^(id x) {
        NSLog(@"2-----%@", x);
    }];
    
    [[command.executing skip:1] subscribeNext:^(id x) {
        NSLog(@"3-----%@", x);
        if([x boolValue] == YES) {
        
            NSLog(@"正在执行");
        
        } else {
        
            NSLog(@"执行完成");
        
        }
    }];
    
    [self.command execute:@1];

}

/**
 处理多个请求，例如网络请求，当都返回结果的时候，作统一的处理
 */
- (void)method4 {

    RACSignal *request1 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"发送请求一"];
        return nil;
    }];
    
    RACSignal *request2 = [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@"发送请求二"];
        return nil;
    }];
    
    [self rac_liftSelector:@selector(updateUIWithR1:r2:) withSignalsFromArray:@[request1, request2]];
    
}

- (void)updateUIWithR1:(id)data1 r2:(id)data2 {

    NSLog(@"请求网络数据:请求一 %@, 请求二 %@", data1, data2);

}

/**
 RACSignal 执行链式结构
 */
- (void)method5 {

    [[[[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        [subscriber sendNext:@1];
        [subscriber sendCompleted];
        return nil;
    }] doNext:^(id x) {
        NSLog(@"doNext");
    }] doCompleted:^{
        NSLog(@"doCompleted");
    }] subscribeNext:^(id x) {
        NSLog(@"%@", x);
    }];

}

@end
