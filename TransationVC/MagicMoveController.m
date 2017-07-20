//
//  MagicMoveController.m
//  TransationVC
//
//  Created by 雷祥 on 2017/7/19.
//  Copyright © 2017年 okdeer. All rights reserved.
//

#import "MagicMoveController.h"
#import "MagicCollectionViewCell.h"
#import "MagicPushedViewController.h"

@interface MagicMoveController ()
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation MagicMoveController

static NSString * const reuseIdentifier = @"cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:(UIBarButtonItemStylePlain) target:self action:@selector(backClick:)];
    // Register cell classes
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MagicCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:reuseIdentifier];
    // Do any additional setup after loading the view.
}

- (void)backClick:(id)sender {
    self.navigationController.delegate = nil;
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {

    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {

    return 100;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MagicCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];

    NSLog(@"delegate:%s=index:%ld",__func__,indexPath.item);
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(MagicCollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger index = indexPath.item % 14;
    cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",index]];
    cell.layer.transform = CATransform3DMakeScale(0.3, 0.3, 1);//缩放比例
    [UIView animateWithDuration:0.5 animations:^{
        cell.layer.transform = CATransform3DMakeScale(1, 1, 1);//还原为1
    }];
    NSLog(@"delegate:%s=index:%ld",__func__,indexPath.item);
}


#pragma mark <UICollectionViewDelegate>


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"magicPush"]) {
        MagicPushedViewController *pushedVC = segue.destinationViewController;
        self.navigationController.delegate = pushedVC;
        NSInteger index = _selectIndexPath.item % 14;
        pushedVC.image = [UIImage imageNamed:[NSString stringWithFormat:@"%ld",index]];
    }
    NSLog(@"prepareForSegue");
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    _selectIndexPath = indexPath;
    [self performSegueWithIdentifier:@"magicPush" sender:nil];
}

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;

}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {

	
}
*/

@end
