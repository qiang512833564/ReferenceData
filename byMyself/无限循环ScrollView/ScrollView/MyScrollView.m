//
//  MyScrollView.m
//  ScrollView
//
//  Created by lizhongqiang on 15/7/8.
//  Copyright (c) 2015年 lqq. All rights reserved.
//

#import "MyScrollView.h"

@implementation MyScrollView

- (instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        NSArray *array = @[@"http://d.hiphotos.baidu.com/image/pic/item/8601a18b87d6277ffda1a8ed2c381f30e824fcb0.jpg",@"http://b.hiphotos.baidu.com/image/pic/item/9e3df8dcd100baa1dcabdd6e4310b912c9fc2e5b.jpg",@"http://a.hiphotos.baidu.com/image/pic/item/64380cd7912397dd199d02d15d82b2b7d1a2877b.jpg",@"http://f.hiphotos.baidu.com/image/pic/item/adaf2edda3cc7cd9480fb10c3d01213fb90e91c1.jpg",@"http://h.hiphotos.baidu.com/image/pic/item/a8773912b31bb051afa529fd327adab44bede066.jpg"];
        
        NSMutableArray *dataArr = [NSMutableArray array];
        
        [dataArr addObject:[array lastObject]];
        
        [dataArr addObjectsFromArray:array];
        
        [dataArr addObject:array[0]];
        
        for(int i=0; i<dataArr.count; i++)
        {
            UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
            
            [self addSubview:imageView];
        
            [NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:dataArr[i]]] queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError)
         {
             imageView.image = [UIImage imageWithData:data];
         }
         ];
        }
        
        [self setContentOffset:CGPointMake(self.frame.size.width, 0) animated:NO];
        
        self.contentSize = CGSizeMake(dataArr.count*frame.size.width, 0)
        ;    }
    return self;
}

@end
