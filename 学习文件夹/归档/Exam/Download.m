//
//  Download.m
//  Exam
//
//  Created by lizhongqiang on 15/12/31.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "Download.h"
@interface Download()
@property (nonatomic, copy)NSString *mypath;
@end
@implementation Download
- (void)downloadData:(NSString *)urlString{
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    NSError *error = nil;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSDictionary *dataDic = (NSDictionary *)result;
    NSArray *dataArray = [dataDic objectForKey:@"data"];
    _modelArray = [NSMutableArray new];
    for (int i = 0; i < dataArray.count; i++)
    {
        NSDictionary *eachDataDic = dataArray[i];
        RankModel *model = [[RankModel alloc]initWithDataDic:eachDataDic];
        [_modelArray addObject:model];
    }
    [NSKeyedArchiver archiveRootObject:_modelArray toFile:self.mypath];
//    for(int i=0; i<_modelArray.count; i++){
//        RankModel *model = _modelArray[i];
//        NSString *path = [NSString stringWithFormat:@"%@%d",self.mypath,i];
//        [NSKeyedArchiver archiveRootObject:model toFile:path];
//    }
    
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:self.mypath];
    NSLog(@"%@---%@",array,[array[0]name]);
}
- (NSString *)mypath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
    NSString *docDir = [paths objectAtIndex:0];
    NSLog(@"%@",docDir);
    _mypath = [NSString stringWithFormat:@"%@/test",docDir];
    return _mypath;
    //NSLog(@"dic ============ %@",self.songDict);
}
@end
