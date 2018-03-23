//
//  FaceViewController.swift
//  AugmentedTranslationSample
//
//  Created by Nitin Singh Chauhan on 3/23/18.
//  Copyright © 2018 Nitin Singh Chauhan. All rights reserved.
//

import UIKit
import Photos

class FaceViewController: UIViewController ,UINavigationControllerDelegate{

    var picker:UIImagePickerController? = UIImagePickerController()
    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var scanButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        picker?.delegate = self
        scanButton.isUserInteractionEnabled = false
        scanButton.isEnabled = false
        // Do any additional setup after loading the view.
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
        
    }
    @IBAction func textFromImage(_ sender: UIButton) {
        let ciImage  = CIImage(cgImage:myImageView.image!.cgImage!)
        let ciDetector = CIDetector(ofType:CIDetectorTypeFace
            ,context:CIContext()
            ,options:[
                CIDetectorAccuracy:CIDetectorAccuracyHigh,
                CIDetectorSmile:true
            ]
        )
        let features = ciDetector?.features(in: ciImage)
        
        UIGraphicsBeginImageContext(myImageView.image!.size)
        myImageView.image!.draw(in: CGRect(x:0,y:0,width:myImageView.image!.size.width,height:myImageView.image!.size.height))
        
        for feature in features!{
            
            //context
            let drawCtxt = UIGraphicsGetCurrentContext()
            
            //face
            var faceRect = (feature as! CIFaceFeature).bounds
            faceRect.origin.y = myImageView.image!.size.height - faceRect.origin.y - faceRect.size.height
            drawCtxt!.setStrokeColor(UIColor.red.cgColor)
            drawCtxt!.stroke(faceRect)
            
            //mouse
            if (feature as! CIFaceFeature).hasMouthPosition != false{
                let mouseRectY = myImageView.image!.size.height - (feature as! CIFaceFeature).mouthPosition.y
                let mouseRect  = CGRect(x:(feature as! CIFaceFeature).mouthPosition.x - 5,y:mouseRectY - 5,width:10,height:10)
                drawCtxt!.setStrokeColor(UIColor.blue.cgColor)
                drawCtxt!.stroke(mouseRect)
            }
            
            //hige
            let higeImg      = UIImage(named:"hige_100.png")
            let mouseRectY = myImageView.image!.size.height - (feature as! CIFaceFeature).mouthPosition.y
            let higeWidth  = faceRect.size.width * 4/5
            let higeHeight = higeWidth * 0.3
            let higeRect  = CGRect(x:(feature as! CIFaceFeature).mouthPosition.x - higeWidth/2,y:mouseRectY - higeHeight/2,width:higeWidth,height:higeHeight)
            drawCtxt?.draw(higeImg!.cgImage!, in: higeRect)
            
            //leftEye
            if(feature as! CIFaceFeature).hasLeftEyePosition != false{
                let leftEyeRectY = myImageView.image!.size.height - (feature as! CIFaceFeature).leftEyePosition.y
                let leftEyeRect  = CGRect(x:(feature as! CIFaceFeature).leftEyePosition.x - 5,y:leftEyeRectY - 5,width:10,height:10)
                drawCtxt!.setStrokeColor(UIColor.blue.cgColor)
                drawCtxt!.stroke(leftEyeRect)
            }
            
            //rightEye
            if (feature as! CIFaceFeature).hasRightEyePosition != false{
                let rightEyeRectY = myImageView.image!.size.height - (feature as! CIFaceFeature).rightEyePosition.y
                let rightEyeRect  = CGRect(x:(feature as! CIFaceFeature).rightEyePosition.x - 5,y:rightEyeRectY - 5,width:10,height:10)
                drawCtxt!.setStrokeColor(UIColor.blue.cgColor)
                drawCtxt!.stroke(rightEyeRect)
            }
        }
        let drawedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        myImageView.image = drawedImage
    }

}
extension FaceViewController : UIImagePickerControllerDelegate
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
