//
//  ViewController.swift
//  AugmentedTranslationSample
//
//  Created by Nitin Singh Chauhan on 1/29/18.
//  Copyright © 2018 Nitin Singh Chauhan. All rights reserved.
//

import UIKit
import Photos

class ViewController: UIViewController,
UINavigationControllerDelegate{

    
    let ocr = CognitiveServices.sharedInstance.ocr
    var picker:UIImagePickerController? = UIImagePickerController()
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var textView: UITextView!
     @IBOutlet weak var scanButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        picker?.delegate = self
        scanButton.isUserInteractionEnabled = false
        scanButton.isEnabled = false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func takePhotoClicked(_ sender: Any) {
        openCamera()
    }
    
    @objc func openCamera()
    {
        picker!.allowsEditing = false
        picker!.sourceType = .photoLibrary
        picker!.mediaTypes = UIImagePickerController.availableMediaTypes(for: .photoLibrary)!
        present(picker!, animated: true, completion: nil)
//        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
//            picker!.allowsEditing = false
//            picker!.sourceType = UIImagePickerControllerSourceType.camera
//            picker!.cameraCaptureMode = .photo
//            present(picker!, animated: true, completion: nil)
//        }else{
//            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
//            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
//            alert.addAction(ok)
//            present(alert, animated: true, completion: nil)
//        }
    }
    @IBAction func textFromImage(_ sender: UIButton) {
        
        let requestObject: OCRRequestObject = (resource: UIImagePNGRepresentation(myImageView.image!)!, language: .Automatic, detectOrientation: true)
        try! ocr.recognizeCharactersWithRequestObject(requestObject, completion: { (response) in
            if (response != nil){
                let text = self.ocr.extractStringFromDictionary(response!)
                self.textView.text = text
            }
        })
        
    }
    
    
}
extension ViewController : UIImagePickerControllerDelegate
{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any])
  {
        var chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        myImageView.contentMode = .scaleAspectFit
        myImageView.image = chosenImage
        dismiss(animated: true, completion: nil)
    scanButton.isUserInteractionEnabled = true
    scanButton.isEnabled = true
    }
}
