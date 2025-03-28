//
//  ViewController.swift
//  A2_iOS_Akeen_101462287
//
//  Created by Akeen on 2025-03-26.
//

import UIKit

class ViewController: UIViewController {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    func  showAllProducts(){
        do{
            let products = try context.fetch(Product.fetchRequest())
        }
        catch{
            
        }
    }
    
    func createProduct(name: String, details: String, price: Double, provider: String){
        let newProduct = Product(context:context)
        newProduct.id = UUID()
        newProduct.name = name
        newProduct.details = details
        newProduct.price = price
        newProduct.provider = provider
        
        do{
             try context.save()
        }
        catch{
            
        }
        
        
    }
    
    func searchProduct(){
        
    }


}

