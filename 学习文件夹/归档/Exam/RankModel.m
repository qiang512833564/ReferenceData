//
//  RankModel.m
//  Exam
//
//  Created by lizhongqiang on 15/12/31.
//  Copyright © 2015年 lizhongqiang. All rights reserved.
//

#import "RankModel.h"

@implementation RankModel
/*
 {
 desc = "\U5929\U5929\U52a8\U542c\U97f3\U4e50\U6743\U5a01\U97f3\U4e50\U6307\U6807\Uff0c\U6bcf\U5468\U5b9e\U65f6\U6570\U636e\U7edf\U8ba1\Uff0c\U6700\U597d\U542c\U6700\U6d41\U884c\U7684\U97f3\U4e50\U8ba9\U4f60\U4e00\U699c\U5728\U63e1\Uff01";

 name = "\U52a8\U542c\U70ed\U6b4c\U699c - \U6bcf\U5468\U4e00\U66f4\U65b0";
 songlist =             (
 {
 "singer_name" = "\U590f\U5a49\U5b89";
 "song_name" = "\U4e00\U4e2a\U4eba";
 },
 {
 "singer_name" = "\U9a6c\U9814";
 "song_name" = "\U5357\U5c71\U5357";
 },
 {
 "singer_name" = "\U9b4f\U65b0\U96e8";
 "song_name" = "\U604b\U4eba\U5fc3";
 },
 {
 "singer_name" = "S.H.E";
 "song_name" = "\U68a6\U7530";
 }
 );
 style = 2;
 time = "2015-06-16";
 type = 0;
 }
 */

- (instancetype)initWithDataDic:(NSDictionary *)dic
{
    self = [super init];
    if(self)
    {
        self.name = dic[@"name"];
        self.desc = dic[@"desc"];
        NSArray *list = dic[@"songlist"];
        self.songDict = [NSMutableDictionary new];
        for(int i=0; i<list.count;i++)
        {
            NSDictionary *listDic = list[i];
            [self.songDict setObject:[listDic objectForKey:@"singer_name"] forKey:[listDic objectForKey:@"song_name"]];
        }

    }
    return self;
}


- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.name forKey:@"name"];
    [aCoder encodeObject:self.desc forKey:@"desc"];
    [aCoder encodeObject:self.songDict forKey:@"songDict"];
}
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super init])
    {
        self.name = [aDecoder decodeObjectForKey:@"name"];
        self.desc = [aDecoder decodeObjectForKey:@"desc"];
        self.songDict = [aDecoder decodeObjectForKey:@"songDict"];
    }
    return self;
}

@end
