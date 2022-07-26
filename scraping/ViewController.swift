//
//  ViewController.swift
//  scraping
//
//  Created by Kazuki Omori on 2022/07/20.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UITableViewController {
    var beefbowl = [Gyudon]()
    override func viewDidLoad() {
        super.viewDidLoad()
        scraping() 
        // Do any additional setup after loading the view.
    }

    func scraping() {
        
        AF.request("https://www.yoshinoya.com/menu/gyudon/gyu-don/").responseString { response in
            switch response.result {
            case let .success(value):
                if let doc = try? HTML(html: value, encoding: .utf8) {
                    // 牛丼のサイズをXpathで指定
                    var sizes = [String]()
                    for link in doc.xpath("//th[@class='menu-size']") {
                        sizes.append(link.text ?? "")
                    }
                    
                    //牛丼の値段をXpathで指定
                    var prices = [String]()
                    for link in doc.xpath("//td[@class='menu-price']") {
                        prices.append(link.text ?? "")
                    }
                    
                    //牛丼のサイズ分だけループ
                    for (index, value) in sizes.enumerated() {
                        let gyudon = Gyudon()
                        gyudon.size = value
                        gyudon.price = prices[index]
                        self.beefbowl.append(gyudon)
                    }
                self.tableView.reloadData()
            }
            case let .failure(error):
                   print(error)
            }
        }
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.beefbowl.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let gyudon = self.beefbowl[indexPath.row]
        cell.textLabel?.text = gyudon.size
        cell.detailTextLabel?.text = gyudon.price
        return cell
    }

}

