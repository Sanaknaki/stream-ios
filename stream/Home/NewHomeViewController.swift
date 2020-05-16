//
//  NewHomeViewController.swift
//  stream
//
//  Created by Ali Sanaknaki on 2020-05-15.
//  Copyright © 2020 Ali Sanaknaki. All rights reserved.
//

import UIKit
import Firebase

let samuelQuotes = [
    "Normally, both your asses would be dead as fucking fried chicken, but you happen to pull this shit while I'm in a transitional period so I don't wanna kill you, I wanna help you. But I can't give you this case, it don't belong to me. Besides, I've already been through too much shit this morning over this case to hand it over to your dumb ass.",
    "Well, the way they make shows is, they make one show. That show's called a pilot.",
    "My money's in that office, right? If she start giving me some bullshit about it ain't there, and we got to go someplace else and get it, I'm gonna shoot you in the head then and there.",
    "The path of the righteous man is beset on all sides by the iniquities of the selfish and the tyranny of evil men.",
    "And I will strike down upon thee with great vengeance and furious anger those who would attempt to poison and destroy My brothers. And you will know My name is the Lord when I lay My vengeance upon thee.",
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas rhoncus arcu eget urna feugiat congue. Donec maximus convallis cursus. Curabitur maximus eleifend dolor sagittis pharetra. Sed sem tellus, auctor sit amet mauris gravida, auctor faucibus ipsum. Integer a iaculis nisl. Donec condimentum lorem ut volutpat hendrerit. Nam suscipit et eros sit amet euismod. Duis ut blandit nibh, at facilisis ipsum. Proin ac felis bibendum, mattis mi et, pulvinar erat. Proin eu aliquet purus. Morbi vitae rutrum arcu, egestas condimentum nibh. Sed ornare odio non convallis tempus. Praesent luctus mattis neque, suscipit fermentum elit convallis malesuada. Pellentesque id lacus velit. Aenean imperdiet eleifend porta. Vivamus eget augue quis magna auctor elementum ut ut ligula."
]

class NewHomeViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, HomeViewHeaderControllerDelegate {

    private(set) var collectionView: UICollectionView
    
    var today = getCurrentDateFormatted()
    var posts = [Post]()
    
    // Initializers
    init() {
        // Create new `UICollectionView` and set `UICollectionViewFlowLayout` as its layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        // Create new `UICollectionView` and set `UICollectionViewFlowLayout` as its layout
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        super.init(coder: aDecoder)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle { return .lightContent }
    override func viewWillAppear(_ animated: Bool) { today = getCurrentDateFormatted() }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleRefresh), name: CreateStreamViewController.updateFeedNotificationName, object: nil)
        
        // Header
        collectionView.register(HomeViewHeaderController.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "headerId")
        
        // Cell
        collectionView.register(HomeViewCellController.self, forCellWithReuseIdentifier: HomeViewCellController.reuseId)
        
        // Add `coolectionView` to display hierarchy and setup its appearance
        view.addSubview(collectionView)
        collectionView.backgroundColor = .darkPurple()
        
        // Setup Autolayout constraints
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        collectionView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        collectionView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        // Setup `dataSource` and `delegate`
        collectionView.dataSource = self
        collectionView.delegate = self
        
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        (collectionView.collectionViewLayout as! UICollectionViewFlowLayout).sectionInsetReference = .fromLayoutMargins
        
        setupNavigationBar()
        
        fetchTodaysPosts()
        
        collectionView.alwaysBounceVertical = true
    }
    
    @objc func handleRefresh() {
        print("########")
        
        self.posts.removeAll()
        
        fetchTodaysPosts()
    }
    
    fileprivate func fetchTodaysPosts() {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Database.database().reference().child("posts").child(uid).child(self.today)
        
        ref.observeSingleEvent(of: .value) { (snapshot) in
            // Stop the refresh
            self.collectionView.refreshControl?.endRefreshing()
                        
            guard let dicts = snapshot.value as? [String: Any] else { return }
            
            // Value would be the attributes
            dicts.forEach({ (key: String, value: Any) in
                guard let dict = value as? [String: Any] else { return }
                var post = Post(dictionary: dict)
                
                post.id = key
                
                self.posts.insert(post, at: 0)
                
            })
            
            self.collectionView.reloadData()
        }
    }
    
    // Up/Down spacing
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    // Build the header, give it an Id to be altered
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        // Downcast to be the UserProfileHeader
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "headerId", for: indexPath) as! HomeViewHeaderController

        header.delegate = self
        
        header.today.text = self.today
        
        return header
    }
    
    // Render out the size of the header section
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.width, height: 150)
    }
    
    // MARK: - UICollectionViewDataSource -
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCellController.reuseId, for: indexPath) as! HomeViewCellController
        cell.stream.text = posts[indexPath.item].stream
        cell.today.text = posts[indexPath.item].time
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    // MARK: - UICollectionViewDelegateFlowLayout -
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionInset = (collectionViewLayout as! UICollectionViewFlowLayout).sectionInset
        let referenceHeight: CGFloat = 100 // Approximate height of your cell
        let referenceWidth = collectionView.safeAreaLayoutGuide.layoutFrame.width
            - sectionInset.left
            - sectionInset.right
            - collectionView.contentInset.left
            - collectionView.contentInset.right
        return CGSize(width: referenceWidth, height: referenceHeight)
    }
    
    fileprivate func setupNavigationBar() { navigationController?.isNavigationBarHidden = true }
    
    func didClickCreatePost() {
        let viewController = CreateStreamViewController()
        let navController = UINavigationController(rootViewController: viewController)
        // navController.modalPresentationStyle = .fullScreen // Popover full screen
        present(navController, animated: true, completion: nil)
    }
}
