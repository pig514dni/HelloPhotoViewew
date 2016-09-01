//
//  PhotosCollectionViewController.m
//  HelloPhotoViewew
//
//  Created by 張峻綸 on 2016/5/27.
//  Copyright © 2016年 張峻綸. All rights reserved.
//

#import "PhotosCollectionViewController.h"
#import "ImageCollectionViewCell.h"
#import "DataManager.h"
#import "DetailViewController.h"
@interface PhotosCollectionViewController ()
{
    DataManager *datas;
}
@end

@implementation PhotosCollectionViewController

static NSString * const reuseIdentifier = @"myCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Prepare datas
    datas=[DataManager sharedInstanse];
    // Uncomment the following line to preserve selection between presentations
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Register cell classes
//    [self.collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//     Get the new view controller using [segue destinationViewController].
//     Pass the selected object to the new view controller.
    //這層為NavigationViewcontroller
    UINavigationController *navigationVC=segue.
    destinationViewController;
    //這層為實際顯示的viewcontroller
    DetailViewController *targetVC=(DetailViewController*)[navigationVC topViewController];
    
    //因collectionView可以複選,但這裡只有選一個
    NSArray *selectedItems=self.collectionView.indexPathsForSelectedItems;
    //因只有一個所以永遠為第0個 
    NSIndexPath *indexPath=selectedItems[0];
    
    targetVC.currentIndex=indexPath.row;
    
    //Add the necessary support of Split-ViewController
    //因iPad打直時有按鈕,需增加
    targetVC.navigationItem.leftBarButtonItem = self.splitViewController.displayModeButtonItem;
    //假如navigationItem左邊有放東西,這樣Back會被蓋掉
    //設成YES就不會被蓋掉
    targetVC.navigationItem.leftItemsSupplementBackButton = YES;
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
//#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of items
    return [datas getTotal];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    cell.photoImageView.image=[datas getImageByIndex:indexPath.row];
    cell.fileNameLabel.text=[datas getFilenameByIndex:indexPath.row];
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

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
