//
//  ViewController.swift
//  SwiftHeredocExample
//
//  Created by Yusuke on 2017/02/19.
//  Copyright © 2017 Penginmura. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!

    /*
     << DOC;
     {
        "id": 1,
        "name": "Taro"
     }
     */
    let json1 = ""
    
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
    let json2 = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool) {

        super.viewDidAppear(animated)

        // Apply textview
        self.textView.text = json2
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

