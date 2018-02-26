//
//  BarCodeGenaratorVC.swift
//  AugmentedTranslationSample
//
//  Created by Nitin Singh Chauhan on 2/26/18.
//  Copyright © 2018 Nitin Singh Chauhan. All rights reserved.
//

import UIKit
import ZXingObjC

class BarCodeGenaratorVC: UIViewController {

    @IBOutlet weak var myImageView: UIImageView!
    @IBOutlet weak var textView: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func barcodeGenerate(sender : UIButton)
    {
        
        let writer = ZXMultiFormatWriter.writer() as! ZXMultiFormatWriter
        
        guard let result : ZXBitMatrix =  try! writer.encode(textView.text!, format: kBarcodeFormatPDF417, width: 500, height: 500)
        else {
            return}
        
        let imageRef =   ZXImage.init(matrix: result).cgimage as! CGImage
        let image = UIImage.init(cgImage: imageRef)
        myImageView.image = image

    }

    

}
