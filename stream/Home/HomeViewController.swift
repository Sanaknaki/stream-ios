//
//  HomeViewController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-13.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let headerId = "headerId"
    let cellId   = "cellId"

    var streams = [HomeViewCellController]()
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .darkPurple()
                
        // Header
        collectionView.register(HomeViewHeaderController.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: headerId)
        
        // Cell
        collectionView.register(HomeViewCellController.self, forCellWithReuseIdentifier: cellId)
        
        setupNavigationBar()
        
        collectionView.alwaysBounceVertical = true
    }
    
    // Build the header, give it an Id to be altered
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // Downcast to be the UserProfileHeader
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! HomeViewHeaderController

        return header
    }
    
    // Render out the size of the header section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.width, height: 200)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! HomeViewCellController

        if(indexPath.item == 1) {
            cell.stream.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas rhoncus arcu eget urna feugiat congue. Donec maximus convallis cursus. Curabitur maximus eleifend dolor sagittis pharetra."
        } else if(indexPath.item == 2) {
            cell.stream.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas rhoncus arcu eget urna feugiat congue. Donec maximus convallis cursus. Curabitur maximus eleifend dolor sagittis pharetra. Sed sem tellus, auctor sit amet mauris gravida, auctor faucibus ipsum. Integer a iaculis nisl. Donec condimentum lorem ut volutpat hendrerit. Nam suscipit et eros sit amet euismod. Duis ut blandit nibh, at facilisis ipsum. Proin ac felis bibendum, mattis mi et, pulvinar erat. Proin eu aliquet purus. Morbi vitae rutrum arcu, egestas condimentum nibh. Sed ornare odio non convallis tempus. Praesent luctus mattis neque, suscipit fermentum elit convallis malesuada. Pellentesque id lacus velit. Aenean imperdiet eleifend porta. Vivamus eget augue quis magna auctor elementum ut ut ligula."
        }
        
        streams.append(cell)
                
        return cell
    }
    
    fileprivate func setupNavigationBar() { navigationController?.isNavigationBarHidden = true }
}
