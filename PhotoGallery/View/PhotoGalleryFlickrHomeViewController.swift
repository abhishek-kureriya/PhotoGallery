//
//  PhotoGalleryFlickrHomeViewController.swift
//  PhotoGallery
//
//  Created by Abhishek on 18/04/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class PhotoGalleryFlickrHomeViewController: UIViewController,photoGalleryViewModelDelegate{
  
      var viewModel = PhotoGalleryFlickrHomeViewModel()
      var collectionViewDataset:[FlickerSearchResponseDataModel]?
      var selectedCell = UICollectionViewCell()
      var  searchString = "northernlights"
      @IBOutlet weak var collectionView: UICollectionView!
   
    
      override func viewDidLoad() {
        super.viewDidLoad()
         viewModel.deleget = self
        viewModel.callFlickrApi(searchString: searchString)
        configure(PhotoGridCollectionView: collectionView)
        self.hideKeyboard()
       
       
      }
    
     override func viewWillAppear(_ animated: Bool) {
        if( traitCollection.forceTouchCapability == .available){
            registerForPreviewing(with: self, sourceView: collectionView)
        }
        self.tabBarController?.navigationController?.isNavigationBarHidden = false
        self.tabBarController?.setNavbar(titleText: "Photo Gallery", isLagreTitleOn: true,isBackButtonHidden:true, isTranslucent: false)
         addSearchControll()
    }
    
    
    func addSearchControll() -> Void {
        
        let searchController = UISearchController(searchResultsController: nil)
        self.tabBarController?.navigationItem.searchController = searchController
        searchController.searchBar.tintColor = UIColor.white
        searchController.searchBar.delegate = self
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).title = "Dismiss"
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).attributedPlaceholder = NSAttributedString(string: "Search your destination here..", attributes: [NSAttributedStringKey.foregroundColor: UIColor.orange])
        
        if let textfield = searchController.searchBar.value(forKey: "searchField") as? UITextField {
            if let backgroundview = textfield.subviews.first {
                backgroundview.backgroundColor = UIColor.white
                backgroundview.layer.cornerRadius = 10
                backgroundview.clipsToBounds = true
            }
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func updateView(responseObj: [FlickerSearchResponseDataModel]) {
        collectionViewDataset = responseObj
        collectionView.reloadData()
   
    }
    
    func showErroronview(errorMessage: String) {
        
    }
    

  }
  //MARK: Search Bar
extension PhotoGalleryFlickrHomeViewController: UISearchBarDelegate {
  
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.dismiss(animated: true, completion: nil)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
         searchString = searchBar.text!
         viewModel.callFlickrApi(searchString: searchString)
         self.dismiss(animated: true, completion: nil)
    }
 
}


// MARK: UIViewControllerPreviewingDelegate methods
extension PhotoGalleryFlickrHomeViewController: UIViewControllerPreviewingDelegate {

    func previewingContext(_ previewingContext: UIViewControllerPreviewing, viewControllerForLocation location: CGPoint) -> UIViewController? {
    
    guard let indexPath = collectionView?.indexPathForItem(at: location) else { return nil }
    
    guard let cell = collectionView?.cellForItem(at: indexPath) else { return nil }
    
    guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "PhotoDetailViewController") as? PhotoDetailViewController else { return nil }
    
     detailVC.detailViewObj = collectionViewDataset?[indexPath.row]
     detailVC.preferredContentSize = CGSize(width: 0.0, height: 300)
     previewingContext.sourceRect = cell.frame
      return detailVC
   }

  // MARK: Trait collection delegate methods
   override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
    
   }
 func previewingContext(_ previewingContext: UIViewControllerPreviewing, commit viewControllerToCommit: UIViewController) {
    
    show(viewControllerToCommit, sender: self)
    
  }
    
}
