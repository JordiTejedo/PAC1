//
//  TableViewController.swift
//  PAC1
//
//  Created by Jordi Tejedo on 27/9/22.
//

import Foundation
import UIKit

protocol PlacesTableDelegate {
    func loadTable()
}

class PlacesTableViewController: UITableViewController, PlacesTableDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let view: UITableView = (self.view as? UITableView)!;
        view.delegate = self
        view.dataSource = self
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadTable()
    }
    
    func loadTable() {
        self.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "fromPlacesTableToPlaceDetails") {
            let placeDetailsViewController = segue.destination as! PlaceDetailsViewController
            placeDetailsViewController.id = sender as! String
            placeDetailsViewController.placesTableDelegate = self
        } else if (segue.identifier == "fromPlacesTableToNewPlace") {
            let newPlaceViewController = segue.destination as! NewPlaceViewController
            newPlaceViewController.placesTableDelegate = self
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ManagerPlaces.Shared().places.count;
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath:IndexPath) {
        self.performSegue(withIdentifier: "fromPlacesTableToPlaceDetails", sender: ManagerPlaces.Shared().getItemAt(index: indexPath.row).id)
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70;
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:LocationCell = self.tableView.dequeueReusableCell(withIdentifier: "locationCell") as! LocationCell
                
        if (ManagerPlaces.Shared().places[indexPath.row].image != nil) {
            cell.img.image = UIImage(data: ManagerPlaces.Shared().places[indexPath.row].image!)
        }
        cell.name.text = ManagerPlaces.Shared().places[indexPath.row].name
        
        return cell
    }
}
