//
//  ViewController.swift
//  CompareMe
//
//  Created by iD Student on 6/27/16.
//  Copyright © 2016 iD Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate {
    
    
    //After Image
    @IBOutlet weak var BackImage: UIImageView!
    
    //BeforeImage
    @IBOutlet weak var FrontImage: UIImageView!
    
    @IBOutlet weak var slider: UISlider!
    
    let imagePicker = UIImagePickerController()
    var allPixels = [Int]()
    
    var image = UIImage(named: "Before")
    var imageForSavingOrNotSaving = UIImage(named: "CompareBtnImage")
    var fromCameraFront: Bool = false
    var fromCameraBack: Bool = false
    
    var AMOUNTPIXELSERASE = 0
    
    //front = 0 , back = 1
    var frontOrBack: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BackImage.image = UIImage(named: ("After"))
        FrontImage.image = UIImage(named: ("Before"))
        imagePicker.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func sliderDragged(sender: AnyObject)
    {
        let rgba = RGBA(image: image!)!
        
        let pixelWidth = rgba.width
        let pixelHeight = rgba.height
        
        let xAxisValue = slider.value
        
        let selectedWidth : Int = Int(floor(xAxisValue * Float(pixelWidth)))
        
        
        
        for i in 0 ..< pixelHeight
        {
            for j in 0 ..< selectedWidth
            {
                let index = i * rgba.width + j
                rgba.pixels[index].alpha = 0
                rgba.pixels[index].blue = 0
                rgba.pixels[index].red = 0
                rgba.pixels[index].green = 0
                
            }
            
        }
        FrontImage.image = rgba.toUIImage()
        
        
        print(AMOUNTPIXELSERASE)
    }
    
    func convertCIImageToCGImage(inputImage: CIImage) -> CGImage! {
        let context = CIContext(options: nil)
        //        if context != nil {
        return context.createCGImage(inputImage, fromRect: inputImage.extent)
        //        }
        //        return nil
    }
    
    
    
    @IBAction func OnFrontImageButtonPressed(sender: AnyObject) {
        
        frontOrBack = 0
        
        let alert: UIAlertController = UIAlertController(title: "Choose Option", message: nil, preferredStyle: .ActionSheet)
        
        let button0: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {(action: UIAlertAction) -> Void in
            //  UIAlertController will automatically dismiss the view
        })
        let button1: UIAlertAction = UIAlertAction(title: "Take photo", style: .Default, handler: {(action: UIAlertAction) -> Void in
            //  The user tapped on "Take a photo"
            let imagePickerController: UIImagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .Camera
            imagePickerController.delegate = self
            self.presentViewController(imagePickerController, animated: true, completion: {() -> Void in
            })
            self.fromCameraFront = true
        })
        let button2: UIAlertAction = UIAlertAction(title:"Choose Existing", style: .Default, handler: {(action: UIAlertAction) -> Void in
            
            
            let imagePickerController: UIImagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .PhotoLibrary
            imagePickerController.delegate = self
            self.presentViewController(imagePickerController, animated: true, completion: {() -> Void in
            })
        })
        
        
        alert.addAction(button0)
        alert.addAction(button1)
        alert.addAction(button2)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    @IBAction func OnBackImageButtonPressed(sender: AnyObject) {
        frontOrBack = 1
        
        let alert: UIAlertController = UIAlertController(title: "Choose Option", message: nil, preferredStyle: .ActionSheet)
        
        let button0: UIAlertAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: {(action: UIAlertAction) -> Void in
            //  UIAlertController will automatically dismiss the view
        })
        let button1: UIAlertAction = UIAlertAction(title: "Take photo", style: .Default, handler: {(action: UIAlertAction) -> Void in
            //  The user tapped on "Take a photo"
            let imagePickerController: UIImagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .Camera
            imagePickerController.delegate = self
            self.presentViewController(imagePickerController, animated: true, completion: {() -> Void in
            
            })
            self.fromCameraBack = true
        })
        let button2: UIAlertAction = UIAlertAction(title:"Choose Existing", style: .Default, handler: {(action: UIAlertAction) -> Void in
            
            //  The user tapped on "Choose existing"
            
            
            
            let imagePickerController: UIImagePickerController = UIImagePickerController()
            imagePickerController.sourceType = .PhotoLibrary
            imagePickerController.delegate = self
            self.presentViewController(imagePickerController, animated: true, completion: {() -> Void in
            })
        })
        
        
        alert.addAction(button0)
        alert.addAction(button1)
        alert.addAction(button2)
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        
        {
            if frontOrBack == 0{
                FrontImage.contentMode = .ScaleAspectFill
                FrontImage.image = pickedImage
                image = FrontImage.image
                if fromCameraFront == true{
                    UIImageWriteToSavedPhotosAlbum(image!, nil, nil, nil)
                    fromCameraFront = false
                }
            }
            if frontOrBack == 1{
                BackImage.contentMode = .ScaleAspectFill
                BackImage.image = pickedImage
                imageForSavingOrNotSaving = BackImage.image
                if fromCameraBack == true{
                    UIImageWriteToSavedPhotosAlbum(imageForSavingOrNotSaving!, nil, nil, nil)
                    fromCameraBack = false
                }
            }
        }
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}





