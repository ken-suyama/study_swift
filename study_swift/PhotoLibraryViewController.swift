//
//  PhotoLibraryViewController.swift
//  study_swift
//
//  Created by 須山賢 on 2021/09/13.
//  Copyright © 2021 須山賢. All rights reserved.
//

import UIKit

class PhotoLibraryViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    private let viewModel = TweetViewModel()
    private var tweets: [Tweet] = []

    @IBOutlet weak var photoCollection: UICollectionView!

//    let photos = [
//        "icon1","icon1","icon1","icon1","icon1",
//        "icon1","icon1","icon1","icon1","icon1",
//        "icon1","icon1","icon1","icon1","icon1",
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tweets = self.viewModel.fetchMyPhotoTweets()
        
        photoCollection.delegate = self
        photoCollection.dataSource = self
        
        adjustCellLayout()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        let imageCell: UICollectionViewCell =
            collectionView.dequeueReusableCell(withReuseIdentifier: "tweetImage", for: indexPath)
        imageCell.layer.borderColor = UIColor.black.cgColor
        imageCell.layer.borderWidth = 0.5

        let imageView = imageCell.contentView.viewWithTag(1) as! UIImageView
        let tweet = self.tweets[indexPath.row]
        let cellImage = UIImage(url: tweet.imageUrl ?? "https://i.gzn.jp/img/2018/01/15/google-gorilla-ban/00.jpg")
        imageView.image = cellImage
        
        return imageCell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tweets.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.blue.cgColor
        cell?.layer.borderWidth = 1
    }
    
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = UIColor.black.cgColor
        cell?.layer.borderWidth = 0.5
        cell?.isSelected = false
    }
    
    private func adjustCellLayout() {
        let layout = UICollectionViewFlowLayout()
        let screenWidth = UIScreen.main.bounds.width
        let scaleFactor = screenWidth / 3
        layout.itemSize = CGSize(width: scaleFactor, height: scaleFactor)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        photoCollection.collectionViewLayout = layout
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let screenWidth = UIScreen.main.bounds.width
//        let scaleFactor = screenWidth / 10
//
//        return CGSize(width: scaleFactor, height: scaleFactor)
//    }
}
