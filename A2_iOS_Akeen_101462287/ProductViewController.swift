//
//  ProductViewController.swift
//  A2_iOS_Akeen_101462287
//
//  Created by Akeen on 2025-03-28.
//

import UIKit

class ProductViewController: UIViewController {

    @IBOutlet weak var productProvider: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDetails: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productId: UILabel!
    
    var product:Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //productId.text = String(product!.id)
        productName.text = product?.name
        productDetails.text = product?.details
        productPrice.text = String(product!.price)
        productProvider.text = product?.provider
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
