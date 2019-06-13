//
//  UIImage+Combine.h
//  GroupIcon
//
//  Created by 李永杰 on 2019/6/13.
//  Copyright © 2019 liyongjie. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Combine)

+(UIImage *)combineWithWidth:(CGFloat)width images:(NSArray <UIImage *>*)images bgColor:(UIColor *)bgColor;

@end

