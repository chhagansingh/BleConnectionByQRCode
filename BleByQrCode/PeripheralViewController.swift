//
//  PeripheralViewController.swift
//  BleByQrCode
//
//  Created by Chhagan Singh on 27/08/18.
//  Copyright © 2018 Chhagan Singh. All rights reserved.
//

import UIKit
import Foundation
import CoreBluetooth

class PeripheralViewController: UIViewController , CBPeripheralDelegate, UITableViewDataSource{

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var UUIDLabel: UILabel!
    @IBOutlet weak var RSSILabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    
    var peripheral: CBPeripheral!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        print("Peripheral: \(peripheral)")
        
        nameLabel.text = peripheral.name ?? "No Name"
        UUIDLabel.text = peripheral.identifier.uuidString
        
        peripheral.delegate = self
        peripheral.readRSSI()
        peripheral.discoverServices(nil)
    }
    
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?)
    {
        print("Did discover services.")
        if let error = error
        {
            print(error)
        }
        else
        {
            //print("\(peripheral.services)")
            tableView.reloadData()
        }
        
    }
   

    func peripheral(_ peripheral: CBPeripheral, didReadRSSI RSSI: NSNumber, error: Error?)
    {
        print("Did read RSSI.")
        if let error = error
        {
            print("Error getting RSSI: \(error)")
            RSSILabel.text = "Error getting RSSI."
        }
        else
        {
            RSSILabel.text = "\(RSSI.intValue)"
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        guard let services = peripheral.services else
        {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ServiceCell", for: indexPath as IndexPath)
        let service = services[indexPath.row]
        print("Service UUID Description: \(service.uuid.description)")
        cell.textLabel?.text = service.uuid.description
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath?)
        //func selectRowAtIndexPath(indexPath: NSIndexPath)
    {
        print("booger...")
        let services = peripheral.services!
        let service = services[indexPath!.row]
        print("Service has been selected: \(service.uuid.description)")
        
    }
    
    //In a storyboard-based application, you will often want to do a little preparation before navigation
     func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "charsSegue"
        {
            let services = peripheral.services!  //services contains the list of services discovered for this peripheral
            let service = services[tableView.indexPathForSelectedRow!.row] //service is the particular selected by tap
            
            if let destinationVC = segue.destination as? charsTableViewController
            {
                destinationVC.service = service  //Pass the selected service to charsTableViewController
                destinationVC.peripheral = peripheral
            }
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return peripheral.services?.count ?? 0
    }
}
