//
//  ViewController.swift
//  SortingArm
//
//  Created by Jeremy Swafford on 3/30/17.
//  Copyright © 2017 NCSU ECE Project 14. All rights reserved.
//

import UIKit
import MobileCoreServices
import VisualRecognitionV3

let apiKey = "8184c961e86deb450925a2196ddfde4dbb1f1721"
let version = "2017-04-04" // use today's date for the most recent version
let visualRecognition = VisualRecognition(apiKey: apiKey, version: version)

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        let mediaType = info[UIImagePickerControllerMediaType] as! NSString
        
        self.dismiss(animated: true, completion: nil)
        
        if mediaType.isEqual(to: kUTTypeImage as String) {
            let image = info[UIImagePickerControllerOriginalImage] as! UIImage
            
            imageView.image = image
            
            if (newMedia == true) {
                UIImageWriteToSavedPhotosAlbum(image, self, #selector(ViewController.image(image:didFinishSavingWithError:contextInfo:)), nil)
            } else if mediaType.isEqual(to: kUTTypeMovie as String) {
                // Code to support video here
            }
            
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSErrorPointer, contextInfo:UnsafeRawPointer) {
        
        if error != nil {
            let alert = UIAlertController(title: "Save Failed",
                                          message: "Failed to save image",
                                          preferredStyle: UIAlertControllerStyle.alert)
            
            let cancelAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            
            alert.addAction(cancelAction)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var theLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    var newMedia: Bool?

    @IBAction func doit(_ sender: AnyObject) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.camera) {
            
            let imagePicker = UIImagePickerController()
            
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.camera
            imagePicker.mediaTypes = [kUTTypeImage as String]
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
            newMedia = true
        }
        
        //test()
    }
    
    @IBAction func toWatson(_ sender: UIButton) {
        test()
    }
    func test(){
        
        let url = "http://res.freestockphotos.biz/pictures/10/10240-an-empty-brown-beer-bottle-isolated-on-a-white-background-pv.jpg"
        //let theImage:UIImage? = imageView.image
        let failure = { (error: Error) in print(error) }
        
        //visualRecognition.classify(imageFile: imageView.image, success: <#T##(ClassifiedImages) -> Void#>)

        visualRecognition.classify(image: url, failure: failure) { classifiedImages in
            print(classifiedImages)
            self.theLabel.text = ""
            for index in 0...5 {
                self.theLabel.text = (self.theLabel.text! + classifiedImages.images[0].classifiers[0].classes[index].classification as? String)! + " "
                self.theLabel.text = (self.theLabel.text! + "\(classifiedImages.images[0].classifiers[0].classes[index].score)" as? String)! + "\r\n"
            }
        }
    }
}

