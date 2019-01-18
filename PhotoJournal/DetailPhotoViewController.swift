//
//  DetailPhotoViewController.swift
//  PhotoJournal
//
//  Created by Pursuit on 1/16/19.
//  Copyright © 2019 Pursuit. All rights reserved.
//

import UIKit

class DetailPhotoViewController: UIViewController {
    
private var itemDescriptionPlaceHolder = "Description"
    
    @IBOutlet weak var itemDescriptionTextView: UITextView!
    
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    
    @IBOutlet weak var ImageView: UIImageView!
    
    private var ImagePickerViewController: UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemDescriptionTextView.becomeFirstResponder()
        itemDescriptionTextView.delegate = self
        itemDescriptionTextView.text = itemDescriptionPlaceHolder
        itemDescriptionTextView.textColor = .gray
      setUpImagePickerViewController()
    }
    
    private func setUpImagePickerViewController() {
        ImagePickerViewController = UIImagePickerController()
        ImagePickerViewController.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            cameraButton.isEnabled  = false
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        let data = ImageView.image?.pngData()
        let date = Date()
        let isoDateFormatter = ISO8601DateFormatter()
        isoDateFormatter.formatOptions = [.withFullDate,
                                          .withFullTime,
                                          .withInternetDateTime,
                                          .withTimeZone,
                                          .withDashSeparatorInDate]
        let timestamp = isoDateFormatter.string(from: date)
        guard let itemDescription = itemDescriptionTextView.text else {fatalError("Item, Description nil")}
        let item = Item.init(Photo: data!, description: itemDescription, createdAt: timestamp)
        PhotoModel.addItem(item: item)
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func CancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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



extension DetailPhotoViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if itemDescriptionTextView.text == itemDescriptionPlaceHolder {
            textView.text = ""
            textView.textColor = .black
        }
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            if textView == itemDescriptionTextView {
                textView.text = itemDescriptionPlaceHolder
                textView.textColor = .gray
            }
        }
    }
}
