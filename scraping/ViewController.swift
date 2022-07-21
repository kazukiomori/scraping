//
//  ViewController.swift
//  scraping
//
//  Created by Kazuki Omori on 2022/07/20.
//

import UIKit
import Alamofire
import Kanna

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    func scraping() {
        
        AF.request("https://www.yoshinoya.com/menu/gyudon/gyu-don/").responseString { response in
            switch response.result {
            case let .success(value):
                break
            case let .failure(error):
                   print(error)
            }
        }
    }

}

