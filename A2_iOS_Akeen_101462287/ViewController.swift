//
//  ViewController.swift
//  A2_iOS_Akeen_101462287
//
//  Created by Akeen on 2025-03-26.
//
import CoreData
import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var searchBar: UISearchBar!

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
        self.navigationItem.titleView = searchBar
        view.addSubview(tableView)
        showAllProducts()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.frame = view.bounds
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))

    }
    

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(searching){
            return searchProducts.count
        }
        else{
            return products.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if(searching)
        {
            let searchProduct = searchProducts[indexPath.row]
            cell.textLabel?.text = "\(searchProduct.name ?? "name not found"):    \(searchProduct.details ?? "no description given")";
        }
        else
        {
    
            let product = products[indexPath.row]
            cell.textLabel?.text = "\(product.name ?? "name not found"):    \(product.details ?? "no description given")";
        }

        return cell
    }
    
    func tableView(_ tableView:UITableView, didSelectRowAt indexPath: IndexPath){
        //let selectedIndex = indexPath.row
        performSegue(withIdentifier: "showProductDetails", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:Any?){
        if let destination = segue.destination as? ProductViewController{
            if(searching)
            {
                destination.product = searchProducts[(tableView.indexPathForSelectedRow?.row)!]
            }
            else{
                destination.product = products[(tableView.indexPathForSelectedRow?.row)!]
            }
            }
    }
    
    func showAllProducts(){
        do{
            products = try context.fetch(Product.fetchRequest())
            DispatchQueue.main.async{
                self.tableView.reloadData()
            }
        }
        catch{
            
        }
    }
    
    @objc func addButtonTapped(){
        let alert = UIAlertController(title: "Add Product", message: "Enter new product details", preferredStyle: .alert)
        alert.addTextField{
            (textField) in textField.placeholder = "Name"
        }
        alert.addTextField{
            (textField) in textField.placeholder = "Description"
        }
        alert.addTextField{
            (textField) in textField.placeholder = "Price"
        }
        alert.addTextField{
            (textField) in textField.placeholder = "Provider"
        }
        alert.addAction(UIAlertAction(title:"submit", style: .cancel, handler:{
            _ in
            
            guard let field = alert.textFields?[0], let text = field.text, !text.isEmpty else { return }
            
            guard let field2 = alert.textFields?[1], let text2 = field2.text, !text.isEmpty else { return }
            
            guard let field3 = alert.textFields?[2], let text3 = field3.text, !text.isEmpty else { return }
            
            guard let field4 = alert.textFields?[3], let text4 = field4.text, !text.isEmpty else { return }
      
            self.createProduct(productName: text, productDetails: text2, productPrice: Double(text3) ?? 0, productProvider: text4)
        }))
        present(alert, animated: true)
    }
    
    func createProduct(productName: String, productDetails: String, productPrice: Double, productProvider: String){
        let newProduct = Product(context: context)
        newProduct.id = UUID()
        newProduct.name = productName
        newProduct.details = productDetails
        newProduct.price = productPrice
        newProduct.provider = productProvider
        
        
        do{
            try context.save()
            showAllProducts()

        }
        catch{
            
        }
        
        
    }
    
    var searchProducts = [Product]()
    var searching = false

}

extension ViewController: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        //searching = true
        
        searchProducts = products.filter({(product) -> Bool in
             ( product.name?.lowercased().contains(searchText.lowercased()) ?? false ||
                     product.details?.lowercased().contains(searchText.lowercased()) ?? false)
        })
        searching = true
        tableView.reloadData()
        
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
}

