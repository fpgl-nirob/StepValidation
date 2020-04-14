//
//  ViewController.swift
//  SiliconOrcInterview
//
//  Created by Nirob Hasan on 13/4/20.
//  Copyright © 2020 Nirob Hasan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: BaseViewController {
    @IBOutlet weak var nhNavigationBar: NHNavigationBar!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nhNavigationBar.navDelegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.setupNavBar()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }

    func setupNavBar() {
        nhNavigationBar.setTitleLabel(title: "Step Validation")
    }

}

extension ViewController: NHNavigationBarDelegate {
    func backButtonClicked() {
        
    }
    
    func rightButtonClicked() {
        
    }
    
}

