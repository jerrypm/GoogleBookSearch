//
//  HomeViewController.swift
//  DaftarBuku
//
//  Created by Jeri Purnama Maulid on 08/08/18.
//  Copyright © 2018 Jeri Purnama Maulid. All rights reserved.
//

import UIKit
import Alamofire
import Kingfisher
import SwiftyJSON

class HomeViewController: UIViewController {

    @IBOutlet weak var txtField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var dataAll: BukuCari?
    var authorArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 150
        self.tableView.register(UINib(nibName: "TableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        self.tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "search.png"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsetsMake(0, -16, 0, 0)
        button.frame = CGRect(x: CGFloat(txtField.frame.size.width - 25), y: CGFloat(5), width: CGFloat(20), height: CGFloat(25))
        button.addTarget(self, action: #selector(self.bCari), for: .touchUpInside)
        txtField.rightView = button
        txtField.rightViewMode = .always
        

    }
    
    @objc func bCari(_ sender: Any) {
        DispatchQueue.main.async {
            NetworkService<BukuCari>.process(client: NetworkClient(endPont: .cariBuku(txt: self.txtField.text!)), onSuccess: { (data) in
                self.dataAll = data
                
                self.tableView.reloadData()
            }, onFailure: nil)
        }
    }

}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataAll?.items1?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let items = dataAll?.items1?[indexPath.row].volumeInfo
        let url = URL(string: items?.imageLinks?.smallThumbnail ?? "")
        
        cell.imgView.kf.setImage(with: url)
        cell.title.text = items?.title ?? ""
        cell.starRating.settings.updateOnTouch = false
        if items?.averageRating == nil {
          cell.starRating.rating = 0.0
        } else {
          cell.starRating.rating = (items?.averageRating)!
        }
        
        
        if items?.authors == nil {
            self.authorArray.append("")
            
        } else {
            let joinString = items?.authors?.joined(separator: ", ")
            print("data: \(joinString ?? "")")
            self.authorArray.append(joinString!)
        }
        
        cell.author.text = authorArray[indexPath.row]
        
        
        return cell
    }
    
}
