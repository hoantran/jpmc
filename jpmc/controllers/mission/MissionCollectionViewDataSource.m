//
//  MissionCollectionViewDataSource.m
//  jpmc
//
//  Created by Hoan Tran on 8/14/18.
//  Copyright © 2018 Hoan Tran. All rights reserved.
//

#import "MissionCollectionViewDataSource.h"

@implementation MissionCollectionViewDataSource

- (nonnull __kindof UICollectionViewCell *)collectionView:(nonnull UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath { 
    NSString *cellID = @"cellID";
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
    
    NSArray *colors = [NSArray arrayWithObjects:[UIColor blueColor], [UIColor greenColor], [UIColor brownColor], nil];
    cell.backgroundColor = [colors objectAtIndex:indexPath.item % colors.count ];
    
    return cell;
}


- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section { 
    return 5;
}


@end
