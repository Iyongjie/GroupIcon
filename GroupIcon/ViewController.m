//
//  ViewController.m
//  GroupIcon
//
//  Created by 李永杰 on 2019/6/13.
//  Copyright © 2019 liyongjie. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+Combine.h"

static NSInteger    value = 0;

@interface ViewController ()

@property (nonatomic, strong) NSTimer           *timer;
@property (nonatomic, strong) UIImageView       *imageView;
@property (nonatomic, strong) NSMutableArray    *array;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < 9; i++) {
        NSMutableArray *tmp = [NSMutableArray array];
        for (int j = 0; j <= i; j++) {
            [tmp addObject:[UIImage imageNamed:[NSString stringWithFormat:@"%d.jpg",j + 1]]];
        }
        [array addObject:tmp];
    }
    _array = array;

    
    UIImageView *imageView0 = [[UIImageView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
    imageView0.layer.cornerRadius = 5;
    imageView0.layer.masksToBounds = YES;
    [self.view addSubview:imageView0];
    _imageView = imageView0;
    
    [self.timer fire];
    
}
-(void)changeImage {
    NSArray *array = _array[value%9];
    _imageView.image = [UIImage combineWithWidth:100 images:array bgColor:[UIColor colorWithRed:0.5 green:0.5 blue:0.5 alpha:1]];
    value ++;

}

-(NSTimer *)timer {
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(changeImage) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop]addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    return _timer;
}

@end
