//
//  buyView.swift
//  NUGUGAE
//
//  Created by 박준하 on 2022/06/28.
//

import UIKit

class buyView : LoginHomeVC {
    
    @IBOutlet weak var imageViewIM: UIImageView!
    
    var radius = 22
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageViewIM.layer.cornerRadius = CGFloat(redius)
        
    }
}
