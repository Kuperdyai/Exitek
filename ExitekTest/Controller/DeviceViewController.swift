//
//  DeviceViewController.swift
//  ExitekTest
//
//  Created by Александр on 04.09.2022.
//

import UIKit
import CoreData

class DeviceViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    var devices: [Device] = []
    
    var phones = [Mobile(imei: phonesImei.first.rawValue, model: phonesInfo.iphone.rawValue), Mobile(imei: phonesImei.second.rawValue, model: phonesInfo.samsung.rawValue), Mobile(imei: phonesImei.third.rawValue, model: phonesInfo.sony.rawValue), Mobile(imei: phonesImei.fourth.rawValue, model: phonesInfo.xiaomi.rawValue)]
    
    enum phonesInfo: String {
        case samsung, iphone, xiaomi, sony
    }
    
    enum MobileError: Error {
        case invalidSelection, noData
    }
    
    enum phonesImei: String {
        case first = "352052071422096"
        case second = "223435563422344"
        case third = "16573085582086"
        case fourth = "76040042086079"
    }
    
    private func getContext() -> NSManagedObjectContext {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
        
    }
    
}

extension DeviceViewController: MobileStorage {
    
    func getAll() -> Set<Mobile> {
        
        let context = getContext()
        
        var phones: Set<Mobile> = Set()
        
        let fetchRequest: NSFetchRequest<Device> = Device.fetchRequest()
        
        do {
            devices = try context.fetch(fetchRequest)
            for i in 0...devices.count - 1 {
                phones.insert(devices[i].mobile)
            }
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return phones
    }
    
    func findByImei(_ imei: String) -> Mobile? {
        
        let context = getContext()
        
        var mobile: Mobile?
        
        let fetchRequest: NSFetchRequest<Device> = Device.fetchRequest()
        
        do {
            devices = try context.fetch(fetchRequest)
            for i in 0...devices.count - 1 {
                if devices[i].imei == imei {
                    mobile = devices[i].mobile
                } else {
                    continue
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return mobile
    }
    
    func save(_ mobile: Mobile) -> Mobile {
        
        let context = getContext()
        
        let entity = NSEntityDescription.entity(forEntityName: "Device", in: context)
        
        let deviceObject = Device(entity: entity!, insertInto: context)
        deviceObject.imei = mobile.imei
        deviceObject.model = mobile.model
        
        do {
            try context.save()
        } catch {
            print(error)
        }
        
        return deviceObject.mobile
    }
    
    func delete(_ product: Mobile) throws {
        
        let context = getContext()
        let fetchRequest: NSFetchRequest<Device> = Device.fetchRequest()
        
        if let objects = try? context.fetch(fetchRequest) {
            for object in objects {
                if object.mobile.imei == product.imei {
                    context.delete(object)
                } else {
                    continue
                }
            }
        }
        
        do {
            
            try context.save()
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
    
    func exists(_ product: Mobile) -> Bool {
        
        let context = getContext()
        var result: Bool = false
        
        let fetchRequest: NSFetchRequest<Device> = Device.fetchRequest()
        
        do {
            devices = try context.fetch(fetchRequest)
            for i in 0...devices.count - 1 {
                if devices[i].imei == product.imei {
                    result = true
                } else {
                    continue
                }
            }
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        return result
    }
    
    
    
}

