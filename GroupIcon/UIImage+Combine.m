//
//  UIImage+Combine.m
//  GroupIcon
//
//  Created by 李永杰 on 2019/6/13.
//  Copyright © 2019 liyongjie. All rights reserved.
//

#import "UIImage+Combine.h"

@implementation UIImage (Combine)

+(UIImage *)combineWithWidth:(CGFloat)width images:(NSArray<UIImage *> *)images bgColor:(UIColor *)bgColor {
    CGSize finalSize = CGSizeMake(width, width);
    CGRect rect      = CGRectZero;
    rect.size        = finalSize;
    
    // 开始图片处理
    UIGraphicsBeginImageContextWithOptions(finalSize, NO, 0);
    
    // 绘制背景
    if (bgColor != nil) {
        CGContextRef context = UIGraphicsGetCurrentContext();
        CGContextAddRect(context, rect);
        CGContextSetFillColorWithColor(context, bgColor.CGColor);
        CGContextDrawPath(context, kCGPathFill);
    }
    // 绘制图片
    
    if (images.count >= 1) {
        // 获取每个小图片的位置
        NSArray *rects = [self getRectsInGroupIconWithWidth:width count:(int)images.count];
        for (int count = 0; count < rects.count; count ++) {
            UIImage *image = images[count];
            [image drawInRect:[rects[count] CGRectValue]];
        }
    }
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}

+(NSArray *)getRectsInGroupIconWithWidth:(CGFloat)width count:(int )count {
    if (count == 1) {
        NSValue *value = [NSValue valueWithCGRect:CGRectMake(0, 0, width, width)];
        return @[value];
    }
    // 存放rect数组
    NSMutableArray *array = [NSMutableArray array];
    // 图片间距
    CGFloat padding = 10;
    // 小图片尺寸
    CGFloat cellWH;
    // 用于计算单元格数量(小于4张算4格单元格，大于4张算9格单元格)
    int cellCount;
    if (count <= 4) {
        cellWH = (width - padding*3)/2;
        cellCount = 4;
    }else {
        padding /= 2;
        cellWH = (width - padding*4)/3;
        cellCount = 9;
    }
    
    // 总行数
    int rowCount = (int)sqrt((double)cellCount);
    for (int i = 0; i < cellCount; i ++) {
        // 当前行
        int row = i / rowCount;
        // 当前列
        int column = i % rowCount;
        
        CGRect rect = CGRectMake(padding*(column + 1) + cellWH*column, padding*(row + 1) + cellWH*row, cellWH, cellWH);
        [array addObject:[NSValue valueWithCGRect:rect]];
    }
    
    // 以下操作，如果rects多余images数量，删除前面的rect，然后调整rect
    if (count == 2) {
        [array removeObjectsInRange:NSMakeRange(0, 2)]; // 只有两个，调整y
        for (int i = 0; i < array.count; i ++) {
            CGRect rect = [array[i] CGRectValue];
            rect.origin.y = rect.origin.y - (padding + cellWH)/2;
            [array replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:rect]];
        }
    }else if(count == 3) {
        [array removeObjectAtIndex:0];
        CGRect rect = [array[0] CGRectValue]; // 只有3个，调整第一行的，以下同理
        rect.origin.x = (width - cellWH)/2;
        [array replaceObjectAtIndex:0 withObject:[NSValue valueWithCGRect:rect]];

    }else if (count == 5) {
        [array removeObjectsInRange:NSMakeRange(0, 4)];
        for (int i = 0; i < array.count; i ++) {
            CGRect rect = [array[i] CGRectValue];
            if (i < 2) {
                rect.origin.x = rect.origin.x - (padding + cellWH)/2;
            }
            rect.origin.y = rect.origin.y - (padding + cellWH)/2;
            [array replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:rect]];
        }
    }else if (count == 6) {
        [array removeObjectsInRange:NSMakeRange(0, 3)];
        for (int i = 0; i < array.count; i ++) {
            CGRect rect = [array[i] CGRectValue];
            rect.origin.y = rect.origin.y - (padding + cellWH)/2;
            [array replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:rect]];
        }
    }else if (count == 7) {
        [array removeObjectsInRange:NSMakeRange(0, 2)];
        CGRect rect = [array[0] CGRectValue];
        rect.origin.x = (width - cellWH)/2;
        [array replaceObjectAtIndex:0 withObject:[NSValue valueWithCGRect:rect]];
    }else if (count == 8) {
        [array removeObjectAtIndex:0];
        for (int i = 0; i < 2; i++) {
            CGRect rect = [array[i] CGRectValue];
            rect.origin.x = rect.origin.x - (padding + cellWH)/2;
            [array replaceObjectAtIndex:i withObject:[NSValue valueWithCGRect:rect]];
        }
    }
    return array;
}
@end
