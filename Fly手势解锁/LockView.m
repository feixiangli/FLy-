//
//  LockView.m
//  Fly手势解锁
//
//  Created by 李飞翔 on 16/3/28.
//  Copyright © 2016年 Fly. All rights reserved.
//

#import "LockView.h"
@interface LockView()
@property(nonatomic,retain)NSMutableArray *selectedArray;
@property(nonatomic,assign)CGPoint curP;
@property(nonatomic,assign)int  strSwitch;
@end
@implementation LockView
-(NSMutableArray*)selectedArray
{
    if (_selectedArray == nil) {
        _selectedArray=[NSMutableArray array];
        
//        UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height-50,[UIScreen mainScreen].bounds.size.width , 40)];
//        [switchButton setOn:YES];
//        [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
//        [self addSubview:switchButton];
        
        
    }
    return _selectedArray;
}
-(void)pan:(UIPanGestureRecognizer*)pan
{
    
    // 获取触摸点
    _curP = [pan locationInView:self];
    
    // 判断触摸点在不在按钮上
    for (UIButton *btn in self.subviews) {
        // 点在不在某个范围内,并且按钮没有被选中
        if (CGRectContainsPoint(btn.frame, _curP) && btn.selected == NO) {
            // 点在按钮上
            btn.selected = YES;
            // 保存到数组中
            [self.selectedArray addObject:btn];
            
        }
        
    }
    
    // 重绘
    [self setNeedsDisplay];
    

    if (pan.state == UIGestureRecognizerStateEnded) {
        

        
        // 创建可变字符串
        NSMutableString *strM = [NSMutableString string];
        // 保存输入密码
        for (UIButton *btn in self.selectedArray) {
            
            [strM appendFormat:@"%ld",btn.tag];
            
        }
        
        // 还原界面r
        // 取消所有按钮的选中
        
        for (UIButton *buton  in  self.selectedArray) {
            buton.selected=NO;
        }
        
        // 清除画线,把选中按钮清空
        [self.selectedArray removeAllObjects];
        
        UIAlertView * alv=[[UIAlertView alloc] initWithTitle:@"提示" message:[NSString stringWithFormat:@"Fly密码设置完成"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alv show];

    }
}

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame ]) {
        for (int i = 0 ; i<9; i++) {
            UIPanGestureRecognizer * pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
            [self addGestureRecognizer:pan];
            
            
            UIButton * button = [[UIButton alloc] init];
            [button setImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
            [button setImage:[UIImage imageNamed:@"xielunyan222"] forState:UIControlStateSelected];
            button.tag=i;
            [self addSubview:button];
        }
        
        NSUInteger count = self.subviews.count;
        int cols = 3;
        CGFloat x = 0;
        CGFloat y = 0;
        CGFloat w = 65;
        CGFloat h = 65;
        CGFloat margin = ([UIScreen mainScreen].bounds.size.width - cols * w) / (cols + 1);
        
        CGFloat col = 0;
        CGFloat row = 0;
        for (NSUInteger i = 0; i < count; i++) {
            UIButton *btn = self.subviews[i];
            // 获取当前按钮的列数
            col = i % cols;
            row = i / cols;
            x = margin + col * (margin + w);
            y = row * (margin + w)+160;
            btn.frame = CGRectMake(x, y, w, h);
        }
        
    }
    return self;
}


-(void)click
{
    NSLog(@"23");
}


- (void)drawRect:(CGRect)rect {
    UIImage * image = [UIImage imageNamed:@"b2985f669474af551a27bb24ce1a3aa6.jpeg"];
    [image drawInRect:rect];
    
    if (self.selectedArray.count==0) {
        return;
    }
    UIBezierPath *path = [UIBezierPath bezierPath];
    NSUInteger count = self.selectedArray.count;
    for (int i =0; i<count; i++) {
        UIButton *button =self.selectedArray[i];
        if (i==0) {
            [path moveToPoint:button.center];
        }else{
            [path addLineToPoint:button.center];
        }
    }
    
    [path addLineToPoint:_curP];
    
    [[UIColor colorWithWhite:0.9 alpha:0.8] set];
    path.lineWidth=8;
    path.lineJoinStyle=kCGLineCapRound;
    [path stroke];
    
}
//-(void)switchAction:(id)sender
//{
//    UISwitch *switchButton = (UISwitch*)sender;
//    BOOL isButtonOn = [switchButton isOn];
//    
//    if (isButtonOn) {
//        self.strSwitch=5;
//        NSLog(@"123");
//    }else {
//        self.strSwitch=6;
//
//    }
//    
//    
//}


@end
