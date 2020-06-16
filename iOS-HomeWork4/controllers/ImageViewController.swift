//
//  ImageViewController.swift
//  iOS-HomeWork4
//
//  Created by Students on 16/06/2020.
//  Copyright © 2020 Kristaps Ozoliņš. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    @IBOutlet weak var imagename: UILabel!
    @IBOutlet weak var image: UIImageView!
    var selectedImage: String? = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        let neededImage = FileManager.documentsDir() + "/" + (selectedImage ?? "") + ".jpg"
        
        imagename.text = selectedImage
        self.image.image = UIImage(imageLiteralResourceName: neededImage)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
