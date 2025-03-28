//
//  ViewController.swift
//  A2_iOS_Akeen_101462287
//
//  Created by Akeen on 2025-03-26.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var products = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        title = "Product List"
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let product = products[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = product.name
        return cell
    }
    
    func  showAllProducts(){
        do{
            products = try context.fetch(Product.fetchRequest())
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
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

