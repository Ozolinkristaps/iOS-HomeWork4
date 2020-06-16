//
//  PhotosViewController.swift
//  iOS-HomeWork4
//
//  Created by User on 08/06/2020.
//  Copyright © 2020 Kristaps Ozoliņš. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController {
    
    @IBOutlet weak var filesTable: UITableView!
    var files: [String] = []
    var openable: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        filesTable.delegate = self
        filesTable.dataSource = self
        
        listAllDocuments()

        // Do any additional setup after loading the view.
    }
    
    func listAllDocuments(){
              let documentsUrl =  FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
              do {
                  let folder = try FileManager.default.contentsOfDirectory(at: documentsUrl, includingPropertiesForKeys: nil)
                  let image = folder.filter{$0.pathExtension == "jpg"}
                  let documents = image
                    print(documents)
                  files = documents.map{ $0.deletingPathExtension().lastPathComponent }
              
              } catch {
                  print("error showing documents")
              }
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

extension PhotosViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(files[indexPath.row])
        self.openable = files[indexPath.row]
        performSegue(withIdentifier: "showImage", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "showImage") {
            let switchView = segue.destination as! ImageViewController
            switchView.selectedImage = self.openable
        }
    }
    
    
}

extension PhotosViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print(files.count)
        return files.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCell", for: indexPath)
        
        cell.textLabel?.text = files[indexPath.row]
        
        return cell
    }
}
