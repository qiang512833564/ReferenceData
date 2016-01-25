//
//  ViewController.m
//  UICollectionView
//
//  Created by lizhongqiang on 16/1/23.
//  Copyright © 2016年 lizhongqiang. All rights reserved.
//

#import "ViewController.h"
#import "My_CollectionViewCell.h"
@interface ViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,My_CollectionViewCellDelegate>
@property (nonatomic, assign)BOOL editing;
@property (nonatomic, strong)UICollectionView *collectionView;
@property (nonatomic, assign)int number;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.number = 10;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"编辑" style:UIBarButtonItemStyleDone target:self action:@selector(action)];
    
    [self.view addSubview:self.collectionView];
}
- (void)action{
    self.editing = !self.editing;
    [self.collectionView reloadData];
}
- (UICollectionView *)collectionView{
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.minimumInteritemSpacing = 10;
        flowlayout.minimumLineSpacing = 20;
        flowlayout.itemSize = CGSizeMake(100, 100);
        flowlayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:flowlayout];
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        [_collectionView registerClass:[My_CollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    }
    return _collectionView;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.number;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    My_CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.editing = self.editing;
    cell.delegate = self;
    cell.indexPath = indexPath;
    cell.textLabel.text = [NSString stringWithFormat:@"我是第%ld个",indexPath.row+1];
    cell.backgroundColor = [UIColor purpleColor];
    return cell;
}
- (void)deleteAction_IndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%ld",indexPath.row);
    self.number --;
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    [self.collectionView reloadData];
}
//直接通过传值的方式，来获取到的indexPath是有问题的，因为调用reloadData与deleteItemsAtIndexPaths并不会刷新重新调用代理方法，因此，indexPath是不会变化的，但是事实上cell总个数和单个cell的位置是在变化的，因此需要根据cell来动态算取indexPath
-(void)deleteAction_Cell:(My_CollectionViewCell *)cell{
    self.number --;
    
    NSIndexPath *indexPath = [_collectionView indexPathForCell:cell];
    NSLog(@"%ld",indexPath.row);
    [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    [self.collectionView reloadData];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
