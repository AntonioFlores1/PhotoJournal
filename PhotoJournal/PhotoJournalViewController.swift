//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Pursuit on 1/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class PhotoJournalViewController: UIViewController {

    @IBOutlet weak var tableCollectionView: UICollectionView!
 
    private var allJournalImages = PhotoModel.getItems(){
        didSet {
            tableCollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       //tableCollectionView.delegate = self
       tableCollectionView.dataSource = self
        print(DataPersistenceManager.documentsDirectory())
    }

    override func viewWillAppear(_ animated: Bool) {
        tableCollectionView.reloadData()
    }
    
    @IBOutlet weak var ButtonPress: UIBarButtonItem!
    
    @IBAction func PlusButton(_ sender: Any) {
        let newstoryBoard = UIStoryboard(name:"Main",bundle: nil)
        let vc = newstoryBoard.instantiateViewController(withIdentifier: "DetailPhoto") as! DetailPhotoViewController
        present(vc, animated: true, completion: nil)
        
    }
    
    @IBAction func editButton(_ sender: UIButton) {
        
        let optionMenuController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        // Create UIAlertAction for UIAlertController
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive){ (action) in
            PhotoModel.delete(atIndex: sender.tag)
            self.allJournalImages = PhotoModel.getItems()
        }
        let editAction = UIAlertAction(title: "Edit", style: .default){ (action) in
            let secondStoryBoard = UIStoryboard(name:"Main",bundle:nil)
            let vc = secondStoryBoard.instantiateViewController(withIdentifier: "DetailPhoto") as! DetailPhotoViewController
            self.present(vc, animated: true, completion: nil)
            
        }
        let shareAction = UIAlertAction(title: "Share", style: .default) { (action) in
            print("File has been Shared")
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            print("Cancel")
        })
        
        optionMenuController.addAction(editAction)
        optionMenuController.addAction(shareAction)
        optionMenuController.addAction(deleteAction)
        optionMenuController.addAction(cancelAction)

        self.present(optionMenuController, animated: true, completion: nil)
        
    }
        
        
    }
extension PhotoJournalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotoModel.getItems().count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = tableCollectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath) as? PhotoCellCollectionViewCell else {return UICollectionViewCell()}
        let item = PhotoModel.getItems()[indexPath.row]
        cell.PhotoImage.image = UIImage.init(data: item.Photo)
        cell.DescriptionLabel.text = item.description
        cell.DateLabel.text = item.dateFormattedString
         return cell
}
   
}

//extension PhotoJournalViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
//        let item = PhotoModel.getItems()[indexPath.row]
//        PhotoModel.delete(item: item, atIndex: indexPath.row)
//        collectionView.deleteItems(at: [indexPath])
//    }
//}

