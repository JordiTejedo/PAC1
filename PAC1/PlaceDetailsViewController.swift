//
//  DetailController.swift
//  PAC1
//
//  Created by Jordi Tejedo on 23/9/22.
//

import UIKit

class PlaceDetailsViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var type: UIPickerView!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    //var index : Int = 0;
    var id : String = "";
    
    var imagePicker = UIImagePickerController()

    @IBOutlet weak var scrollView: UIScrollView!

    var keyboardHeight:CGFloat!
    var activeField: UIView!
    var lastOffset:CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.type.delegate = self
        self.type.dataSource = self
        
        //let place = ManagerPlaces.Shared().getItemAt(index: index)
        let place = ManagerPlaces.shared().getItemBy(id: id)
        
        let borderColor = UIColor(red:204.0/255.0, green:204.0/255.0, blue:204.0/255.0, alpha:1.0)
    
        name.text = place.name
        name.layer.borderWidth = 1.0
        name.layer.cornerRadius = 5.0
        name.layer.borderColor = borderColor.cgColor
        
        type.selectRow(PlacesTypes.allCases.firstIndex(where: {$0 == place.type})!, inComponent: 0, animated: true)
        
        desc.text = place.description
        desc.layer.borderWidth = 1.0
        desc.layer.cornerRadius = 5.0
        desc.layer.borderColor = borderColor.cgColor
        
        image.image = UIImage(data: place.image!, scale: 1)
        image.layer.borderWidth = 1.0
        image.layer.cornerRadius = 5.0
        image.layer.borderColor = borderColor.cgColor
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage(_:)))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
        
        // Soft keyboard Control
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action:#selector(dismissKeyboard))
        view.addGestureRecognizer(tap)
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector:#selector(hideKeyboard), name:UIResponder.keyboardWillHideNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(showKeyboard), name:UIResponder.keyboardWillShowNotification, object: nil)
        name.delegate = self
        desc.delegate = self
    }
    
    @IBAction func Update(_ sender: Any) {
        let place = ManagerPlaces.shared().getItemBy(id: id)
        place.name = name.text!
        place.type = PlacesTypes.allCases[type.selectedRow(inComponent: 0)]
        place.description = desc.text
        place.image = image.image?.pngData()
        ManagerPlaces.shared().update(place)
        
        ManagerPlaces.shared().updateObservers()
        
        dismiss(animated: true, completion: nil)
    }
    
    @objc func selectImage(_ sender:AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false

            present(imagePicker, animated: true, completion: nil)
        }
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        self.dismiss(animated: true, completion: { () -> Void in

        })

        //info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.image.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
    }
    
    @IBAction func Delete(_ sender: Any) {
        let place = ManagerPlaces.shared().getItemBy(id: id)
        ManagerPlaces.shared().remove(place)
        
        ManagerPlaces.shared().updateObservers()
        
        dismiss(animated: true, completion: nil)
    }
    
    // Picker delegates
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PlacesTypes.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PlacesTypes.allCases[row].rawValue
    }
    
    // Text view delegates
    @objc func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        activeField = textView
        lastOffset = self.scrollView.contentOffset
        return true
    }
    
    @objc func textViewShouldEndEditing(_ textView: UITextView) -> Bool {
        if(activeField==textView) {
            activeField?.resignFirstResponder()
            activeField = nil
        }
        return true
    }
    
    //Text field delegates
    @objc func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        activeField = textField
        lastOffset = self.scrollView.contentOffset
        return true
    }
    
    @objc func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if(activeField==textField) {
            activeField?.resignFirstResponder()
            activeField = nil
        }
        return true
    }
    
    @objc func showKeyboard(notification: Notification) {
        if(activeField != nil){
            let userInfo = notification.userInfo!
            let keyboardScreenEndFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
            keyboardHeight = keyboardViewEndFrame.size.height
            let distanceToBottom = self.scrollView.frame.size.height - (activeField?.frame.origin.y)! - (activeField?.frame.size.height)!
            let collapseSpace = keyboardHeight - distanceToBottom
            if collapseSpace > 0 {
                self.scrollView.setContentOffset(CGPoint(x: self.lastOffset.x, y: collapseSpace + 10), animated: false)
                //self.constraintHeight.constant += self.keyboardHeight
            }
            else{
                keyboardHeight = nil
            }
        }
    }
    
    // Hide soft keyboard
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc func hideKeyboard(notification: Notification) {
        if (keyboardHeight != nil) {
            self.scrollView.contentOffset = CGPoint(x:self.lastOffset.x, y: self.lastOffset.y)
            //self.constraintHeight.constant -= self.keyboardHeight
        }
        keyboardHeight = nil
    }
}
