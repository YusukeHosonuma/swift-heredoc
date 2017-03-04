//
//  ViewController.swift
//  SwiftHeredocExample
//
//  Created by Yusuke on 2017/02/19.
//  Copyright © 2017 Penginmura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    /*
     << DOC;
     This
     is
     a
     message
     from
     America
     */
    let string = "This\nis\na\nmessage\nfrom\nAmerica"
    
    /*
     << DOC;
     {
        "resultCount": 1,
        "users": [{
            "id": "fooid",
            "name": "barname"
        }]
     }
     */
    let json = "{\n   \"resultCount\": 1,\n   \"users\": [{\n       \"id\": \"fooid\",\n       \"name\": \"barname\"\n   }]\n}"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

