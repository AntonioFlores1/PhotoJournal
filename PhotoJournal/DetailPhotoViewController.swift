//
//  DetailPhotoViewController.swift
//  PhotoJournal
//
//  Created by Pursuit on 1/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController {

    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    private var ImagePickerViewController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      setUpImagePickerViewController()
    }
    private func setUpImagePickerViewController() {
        ImagePickerViewController = UIImagePickerController()
        ImagePickerViewController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isEnabled  = false

        }

    }
    
    
    @IBAction func PhotoLibraryPressed(_ sender: UIBarButtonItem) {
        present(ImagePickerViewController, animated: true, completion: nil)
    }
    
    

}

extension DetailPhotoViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            ImageView.image = image
        } else {
            print("Original Image is nil")
        }
        dismiss(animated: true, completion: nil)
    }
    
}
