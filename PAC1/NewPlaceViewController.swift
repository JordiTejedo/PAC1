//
//  NewPlaceViewController.swift
//  PAC1
//
//  Created by Jordi Tejedo on 28/9/22.
//

import UIKit
import CoreLocation

class NewPlaceViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var type: UIPickerView!
    @IBOutlet weak var desc: UITextView!
    @IBOutlet weak var image: UIImageView!
    
    var placesTableDelegate : PlacesTableDelegate? = nil
    var placesMapDelegate : PlacesMapDelegate? = nil
    
    var locationManager = CLLocationManager()
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.type.delegate = self
        self.type.dataSource = self
        
        locationManager.requestWhenInUseAuthorization()
        
        let borderColor = UIColor(red:204.0/255.0, green:204.0/255.0, blue:204.0/255.0, alpha:1.0)
    
        name.layer.borderWidth = 1.0
        name.layer.cornerRadius = 5.0
        name.layer.borderColor = borderColor.cgColor
        
        desc.layer.borderWidth = 1.0
        desc.layer.cornerRadius = 5.0
        desc.layer.borderColor = borderColor.cgColor
        
        image.layer.borderWidth = 1.0
        image.layer.cornerRadius = 5.0
        image.layer.borderColor = borderColor.cgColor
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage(_:)))
        image.isUserInteractionEnabled = true
        image.addGestureRecognizer(tapGestureRecognizer)
    }
    
    @IBAction func Create(_ sender: Any) {
        let currentLocation: CLLocation! = locationManager.location
        
        ManagerPlaces.Shared().append(Place(type: PlacesTypes.allCases[type.selectedRow(inComponent: 0)], name: name.text!, description: desc.text, image_in: image.image?.pngData(), location: currentLocation.coordinate))
        
        if (placesTableDelegate != nil) {
            self.placesTableDelegate?.loadTable()
        } else if (placesMapDelegate != nil){
            self.placesMapDelegate?.loadAnnotations()
        }
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
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return PlacesTypes.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return PlacesTypes.allCases[row].rawValue
    }
}
