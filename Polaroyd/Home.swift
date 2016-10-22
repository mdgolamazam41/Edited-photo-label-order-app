/*-----------------------------------------

 - Polaroyd -

created by FV iMAGINATION ©2015
for CodeCanyon.net
All Rights Reserved

------------------------------------------*/

import UIKit


/*  GLOBAL VARIABLES */
var pickedImage: UIImage?
var imageFromCamera: Bool = false


/* IMPORTANT: REPLACE THE RED STRING BELOW WITH THE UNIT ID YOU'VE GOT BY REGISTERING YOUR APP IN http://www.apps.admob.com */
let ADMOB_UNIT_ID = "ca-app-pub-9733347540588953/7805958028"



// MARK: -  Filters List & Names
let filtersArray = [
    "None",                    //0
    "CIPhotoEffectInstant",    //1
    "CIPhotoEffectProcess",    //2
    "CIPhotoEffectTransfer",   //3
    "CISepiaTone",             //4
    "CISepiaTone",             //5
    "CIPhotoEffectFade",       //6
    "CIPhotoEffectTonal",      //7
    "CIPhotoEffectNoir",       //8
    "CIColorMonochrome",       //9
    "CIColorMonochrome",       //10
    "CIVignette",              //11
]
let filterNamesArray = [
    "None",     //0
    "Instant",  //1
    "Process",  //2
    "Transfer", //3
    "Old",      //4
    "Vinty",    //5
    "Fade",     //6
    "Tonal",    //7
    "Noir",     //8
    "Green",    //9
    "Blue",     //10
    "Vignette", //11
]









class Home: UIViewController,
UINavigationControllerDelegate,
UIImagePickerControllerDelegate
{
    
  
// Hide Status Bar
override func prefersStatusBarHidden() -> Bool {
        return true
}
    
func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool) {
        UIApplication.sharedApplication().statusBarHidden = true
}
    

override func viewDidLoad() {
        super.viewDidLoad()
    print(selectedCapId)
        
}
    
    
// MARK: - CAMERA BUTTON
@IBAction func camButt(sender: AnyObject) {
        imageFromCamera = true
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.Camera;
            imagePicker.allowsEditing = true
            presentViewController(imagePicker, animated: true, completion: nil)
        }
}
    
// MARK: - PHOTO LIBRARY BUTTON
@IBAction func libraryButt(sender: AnyObject) {
        imageFromCamera = false
 
    if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary;
            imagePicker.allowsEditing = true
            presentViewController(imagePicker, animated: true, completion: nil)
        }
}
    
// ImagePicked delegate 
func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        pickedImage = image
        
        dismissViewControllerAnimated(false, completion: nil)
        
        // Go to ImageEditor Controller to edit the picked image
        goToImageEditor()
}

    
// MARK: - GO TO IMAGE EDITOR VC
func goToImageEditor() {
        let myVC = self.storyboard?.instantiateViewControllerWithIdentifier("ImageEditor") as! ImageEditor
        self.presentViewController(myVC, animated: true, completion: nil)
}
    
    
    
    
    
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}


}






