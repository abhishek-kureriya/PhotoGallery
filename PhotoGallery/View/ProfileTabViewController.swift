//
//  ProfileTabViewController.swift
//  PhotoGallery
//
//  Created by Abhishek on 20/04/2018.
//  Copyright © 2018 Abhishek. All rights reserved.
//

import UIKit

class ProfileTabViewController: UIViewController {

    @IBOutlet weak var profileTableView: UITableView!
    var paymentsCardsController = PaymentCardsController()
    var pendingPaymentList =  [Payment(),Payment(),Payment()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        paymentsCardsController.delegate = self
        self.profileTableView.register(UINib(nibName: "UserFavouriteTableViewCell", bundle: nil), forCellReuseIdentifier: "UserFavouriteTableViewCell")
        paymentsCardsController.payments = pendingPaymentList
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
     
       }
    override func viewWillAppear(_ animated: Bool) {
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
      
    }
    
  
}

extension ProfileTabViewController : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "UserFavouriteTableViewCell", for: indexPath) as! UserFavouriteTableViewCell
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let paymentsCell = cell as? UserFavouriteTableViewCell {
        paymentsCardsController.configure(collectionView: paymentsCell.collectionView)
        paymentsCell.setCollectionViewDataSourceDelegate(dataSourceDelegate: paymentsCardsController)
        }
        let height = NSNumber(value: Float(cell.frame.size.height))
        //heightAtIndexPath.setObject(height, forKey: indexPath as NSCopying)
    }
    
    
    
}


extension ProfileTabViewController: PaymentCardsControllerDelegate {
    
    func paymentCardsController(paymentCardsController: PaymentCardsController, didSelectItemAt indexPath: IndexPath) {
        // TODO: Open payment modal
    }
    
    func paymentCardsController(paymentCardsController: PaymentCardsController, didApproveItemAt indexPath: IndexPath) {
        // TODO: Replace with service call
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
           // let payment = self.pendingPaymentList!.remove(at: indexPath.item)
            //self.paymentsCardsController.remove(payment: payment)
        }
    }
}
