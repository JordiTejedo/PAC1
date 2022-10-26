//
//  TableViewController.swift
//  PAC1
//
//  Created by Jordi Tejedo on 27/9/22.
//

import Foundation
import UIKit

class PlacesTableViewController: UITableViewController, ManagerPlacesObserver {
    
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view: UITableView = (self.view as? UITableView)!;
        view.delegate = self
        view.dataSource = self
        
        setupActivityIndicator()
        
        ManagerPlaces.shared().addObserver(object:self)
    }
    
    func setupActivityIndicator() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .large
        view.addSubview(activityIndicator)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromPlacesTableToPlaceDetails") {
            let placeDetailsViewController = segue.destination as! PlaceDetailsViewController
            placeDetailsViewController.id = sender as! String
        }
    }
    
    func onPlacesChange() {
        activityIndicator.startAnimating()
        self.view.isUserInteractionEnabled = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            /*let view: UITableView = (self.view as? UITableView)!;
            view.reloadData()*/
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
            self.view.isUserInteractionEnabled = true
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManagerPlaces.shared().places.count;
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        self.performSegue(withIdentifier: "fromPlacesTableToPlaceDetails", sender: ManagerPlaces.shared().getItemAt(index: indexPath.row).id)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LocationCell = self.tableView.dequeueReusableCell(withIdentifier: "locationCell") as! LocationCell
                
        if (ManagerPlaces.shared().places[indexPath.row].image != nil) {
            cell.img.image = UIImage(data: ManagerPlaces.shared().places[indexPath.row].image!)
        }
        cell.name.text = ManagerPlaces.shared().places[indexPath.row].name
        
        return cell
    }
}
