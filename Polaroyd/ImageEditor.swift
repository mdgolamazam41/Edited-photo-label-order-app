/*-----------------------------------------

- Polaroyd -

created by FV iMAGINATION ©2015
for CodeCanyon.net
All Rights Reserved

------------------------------------------*/


import UIKit
import CoreImage
import Social
import AVFoundation
import iAd
import GoogleMobileAds
import AudioToolbox



var finalImage = UIImage?()

class ImageEditor: UIViewController,
UITextFieldDelegate,
ADBannerViewDelegate,
GADBannerViewDelegate,
UIDocumentInteractionControllerDelegate
{
    
    /* Views */
    
    //Ad banners properties
    var iAdBannerView = ADBannerView()
    var adMobBannerView = GADBannerView()
    
    /* Filter Buttons */
    var filterButtons: UIButton?
    var buttTag = 0
    
    /* Frame Buttons */
    var frameButtons: UIButton?
    var frameTag = 0
    

    @IBOutlet weak var frame_P_1: UIImageView!
    
    @IBOutlet weak var frame_p_2: UIImageView!
    
    @IBOutlet weak var frame_p_3: UIImageView!
    
    @IBOutlet weak var frameView: UIView!
    
  
    
    
    @IBOutlet weak var toolbarView: UIView!
    //@IBOutlet weak var filterNameLabel: UILabel!
    
    @IBOutlet weak var saveOutlet: UIButton!
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var frameImgView: UIImageView!
    @IBOutlet weak var originalImgView: UIImageView!
    @IBOutlet weak var filteredImgView: UIImageView!
    
    @IBOutlet weak var txtLabel: UILabel!
    
    
    /* FiltersView */
    @IBOutlet weak var filtersView: UIView!
    @IBOutlet weak var filtersScrollView: UIScrollView!
    
    
    /* Adjustment View */
    @IBOutlet weak var adjustmentView: UIView!
    
    
    /* Frames View */
    @IBOutlet weak var framesView: UIView!
    @IBOutlet weak var framesScrollView: UIScrollView!
    
    /* ImageTitleView */
    @IBOutlet weak var imageTitleView: UIView!
    @IBOutlet weak var txtField: UITextField!
    
    
    /* Combined Image to be saved or shared */
    var combinedImage: UIImage?
    var adjImage: UIImageView?

    
    
    
    /* Variables */
    var showHideFilters = false
    var showHideAdj = false
    var showHideFrames = false
    
    var filter: CIFilter?
    
    @IBAction func handlePan(recognizer:UIPanGestureRecognizer) {
        let translation = recognizer.translationInView(self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPointZero, inView: self.view)
    }
    
    
    
// Hide Status Bar
override func prefersStatusBarHidden() -> Bool {
        return true
}

override func viewDidLoad() {
        super.viewDidLoad()
        frameView.hidden = true
        adjustmentView.hidden = true
        //editView.hidden = true
        bottleCapView.hidden = true
    textBarView.hidden = true
        // showTheTextedits.hidden = true
        // Initialize the banners
        // initiAdBanner()
        // initAdMobBanner()
    frame_p_4.hidden = true
    frame_P_1.hidden = false
    frame_p_2.hidden = true
    frame_p_3.hidden = true
        // Get an image from previous Polaroyd Controller
        originalImgView.image = pickedImage
        filteredImgView.image = originalImgView.image
        
        
        // Setup Adjustment Sliders ==========
        contrastSlider.continuous = false
        brightnessSlider.continuous = false
        saturationSlider.continuous = false
        contrastSlider.setThumbImage(UIImage(named: "sliderThumb"), forState: UIControlState.Normal)
        contrastSlider.setThumbImage(UIImage(named: "sliderThumb"), forState: UIControlState.Highlighted)
        saturationSlider.setThumbImage(UIImage(named: "sliderThumb"), forState: UIControlState.Normal)
        saturationSlider.setThumbImage(UIImage(named: "sliderThumb"), forState: UIControlState.Highlighted)
        brightnessSlider.setThumbImage(UIImage(named: "sliderThumb"), forState: UIControlState.Normal)
        brightnessSlider.setThumbImage(UIImage(named: "sliderThumb"), forState: UIControlState.Highlighted)
        
        
        // Reset FilterName Label
        //filterNameLabel.text = ""
        
        
        // Move the Toolbar Views out of the screen
        filtersView.frame.origin.y = self.view.frame.size.height
        adjustmentView.frame.origin.y = self.view.frame.size.height
        // framesView.frame.origin.y = self.view.frame.size.height
        //imageTitleView.frame.origin.x = self.view.frame.size.width
        
        
        // Resize containerView on iPad
        if UIScreen.mainScreen().bounds.size.width == 768 {
            containerView.frame = CGRectMake(194, 44, 380, 433)
            originalImgView.frame = CGRectMake(14, 14, 352, 352)
            filteredImgView.frame = CGRectMake(14, 14, 352, 352)
        }
        
        
        // Call the methods that setup the Filters and Frames Menus
        setFiltersMenu()
        setFramesMenu()
}
    
    
    
    
    
// MARK: - SETUP FILTERS MENU
func setFiltersMenu() {
        
        // Variables for setting the Filter Buttons and Labels
        var xCoord: CGFloat = 0
        let yCoord: CGFloat = 5
        let buttonWidth:CGFloat = 60
        let buttonHeight: CGFloat = 60
        let gapBetweenButtons: CGFloat = 5
        
        // Counter
        var filtersCount = 0
        
        // Loop for creating buttons
        for filtersCount = 0; filtersCount < filtersArray.count; ++filtersCount {
            buttTag = filtersCount
            let filterImageStr:String = "f\(buttTag)"
            let filterNameStr = "\(filterNamesArray[filtersCount])"
            
            
            // Create a Button for each Filter
            filterButtons = UIButton(type: UIButtonType.Custom)
            filterButtons?.frame = CGRectMake(xCoord, yCoord, buttonWidth, buttonHeight)
            filterButtons?.tag = buttTag
            filterButtons?.showsTouchWhenHighlighted = true
            filterButtons?.setBackgroundImage(UIImage (named: filterImageStr), forState: UIControlState.Normal)
            filterButtons?.addTarget(self, action: "filterButtTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            
            
            // Add a Label that shows Filter Name
            let filterLabel: UILabel = UILabel()
            filterLabel.frame = CGRectMake(0, filterButtons!.frame.size.height-15, buttonWidth, 15)
            filterLabel.backgroundColor = UIColor.blackColor()
            filterLabel.alpha = 0.7
            filterLabel.textColor = UIColor.whiteColor()
            filterLabel.textAlignment = NSTextAlignment.Center
            filterLabel.font = UIFont(name: "AvenirNext-Regular", size: 10)
            filterLabel.text = filterNameStr
            filterButtons?.addSubview(filterLabel)
            
            
            // Add Buttons & Labels based on xCood
            xCoord +=  buttonWidth + gapBetweenButtons
            filtersScrollView.addSubview(filterButtons!)
        } // END LOOP ================================
        
        
        // Place Buttons into the Filters ScrollView =====
        filtersScrollView.contentSize = CGSizeMake(buttonWidth * CGFloat(filtersCount)+1.2, yCoord)
}
    
// MARK: - FILTER BUTTON TAPPED
func filterButtTapped(button: UIButton) {
        
        // Remove adjImage (if any)
        adjImage?.image = nil
        
        // Set the filteredImgView as the Original image
        filteredImgView.image = originalImgView.image
        // Hide the Original Image
        originalImgView.hidden = true
        
        // Reset all adjustment Sliders
        contrastSlider.value = 1.0
        saturationSlider.value = 1.0
        brightnessSlider.value = 0.0
        print("contrast: \(contrastSlider.value)")
        print("saturat: \(saturationSlider.value)")
        print("brightn: \(brightnessSlider.value)")
        
        
        // Print Name of the Filter in the FilterNameLabel
        let filterNameStr = "\(filterNamesArray[button.tag])"
        //filterNameLabel.text = filterNameStr
        
        // Animate filterNameLabel alpha
        //filterNameLabel.alpha = 0.0
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            //self.filterNameLabel.alpha = 1.0
            }, completion: { (finished: Bool) in
                UIView.animateWithDuration(0.3, delay: 0.8, options: UIViewAnimationOptions.CurveLinear, animations: {
                    //self.filterNameLabel.alpha = 0.0
                    }, completion: { (finished: Bool) in
                })
        })
        
        // NO Filter
        if button.tag == 0 {
            filteredImgView.image = originalImgView.image
        } else {
            
            
            /*=================================================
            ================ FILTER SETTINGS ==================
            ===================================================*/
            let CIfilterName = "\(filtersArray[button.tag])"
            print("\(CIfilterName)")
            
            let ciContext = CIContext(options: nil)
            let coreImage = CIImage(image: filteredImgView.image!)
            filter = CIFilter(name: CIfilterName)
            filter!.setDefaults()
            
            
            switch button.tag {
                
            case 4: //Old
                filter!.setValue(0.8, forKey:"inputIntensity")
                break
            case 5: //Vinty
                filter!.setValue(0.5, forKey:"inputIntensity")
                break
                
            case 9: // Green
                let color:UIColor = UIColor(red: 99/255.0, green: 218/255.0, blue: 90/255.0, alpha: 1.0)
                filter!.setValue(CIColor(color: color), forKey: kCIInputColorKey)
                filter!.setValue(0.5, forKey: kCIInputIntensityKey)
                break
                
            case 10: // Blue
                let color:UIColor = UIColor(red: 50/255.0, green: 70/255.0, blue: 218/255.0, alpha: 1.0)
                filter!.setValue(CIColor(color: color), forKey: kCIInputColorKey)
                filter!.setValue(0.5, forKey: kCIInputIntensityKey)
                break
                
            case 11: // Vignette
                filter!.setValue(1.5, forKey: kCIInputRadiusKey)
                filter!.setValue(3, forKey: kCIInputIntensityKey)
                break
                
                // Add new filters settings here...
                
                
            default: break
            }
            
            // Log the Filters attributes in the XCode console
            //  println("\(filter!.attributes())")
            
            // Finalize the filtered image ==========
            filter!.setValue(coreImage, forKey: kCIInputImageKey)
            let filteredImgViewData = filter!.valueForKey(kCIOutputImageKey) as! CIImage
            let filteredImgViewRef = ciContext.createCGImage(filteredImgViewData, fromRect: filteredImgViewData.extent)
            
            filteredImgView.image = UIImage(CGImage: filteredImgViewRef);
        }
        /*=================================================
        ================ END FILTER SETTINGS ==================
        ===================================================*/
        
}
    
    
    
    
    
    
    
// MARK: - SETUP FRAMES MENU
func setFramesMenu() {
        
        // Variables for setting the Filter Buttons and Labels
        var xCoord: CGFloat = 0
        let yCoord: CGFloat = 10
        let buttonWidth:CGFloat = 50
        let buttonHeight: CGFloat = 50
        let gapBetweenButtons: CGFloat = 5
        
        // Counter
        var framesCount = 0
        
        // Loop for creating buttons ========
        for framesCount = 0; framesCount < 9; ++framesCount {
            frameTag = framesCount
            let framesImageStr:String = "frame\(frameTag)"
            
            // Create a Button for each Frame ==========
            frameButtons = UIButton(type: UIButtonType.Custom)
            frameButtons?.frame = CGRectMake(xCoord, yCoord, buttonWidth, buttonHeight)
            frameButtons?.tag = frameTag
            frameButtons?.showsTouchWhenHighlighted = true
            frameButtons?.setBackgroundImage(UIImage (named: framesImageStr), forState: UIControlState.Normal)
            frameButtons?.addTarget(self, action: "frameButtTapped:", forControlEvents: UIControlEvents.TouchUpInside)
            
            // Add Buttons & Labels based on xCood
            xCoord +=  buttonWidth + gapBetweenButtons
            //framesScrollView.addSubview(frameButtons!)
        } // END LOOP ================================
        
        
        // Place Buttons into the Frames ScrollView =====
       // framesScrollView.contentSize = CGSizeMake(buttonWidth * CGFloat(framesCount+1), yCoord)
}
    
    
func frameButtTapped(button: UIButton) {
    frameImgView.image = UIImage(named: "frame\(button.tag)")
}
    
    
    
    
    
    
// MARK: - ADJUSTMENT SLIDERS
    @IBOutlet weak var contrastSlider: UISlider!
    @IBOutlet weak var saturationSlider: UISlider!
    @IBOutlet weak var brightnessSlider: UISlider!
    
    @IBAction func sliderChanged(sender: UISlider) {
        
        print("contrast: \(contrastSlider.value)")
        print("saturat: \(saturationSlider.value)")
        print("brightn: \(brightnessSlider.value)")
        
        if adjImage != nil {
            adjImage?.removeFromSuperview()
        }
        
        adjImage = UIImageView(frame: CGRectMake(filteredImgView.frame.origin.x, filteredImgView.frame.origin.y, filteredImgView.frame.size.width, filteredImgView.frame.size.height))
        adjImage?.image = filteredImgView.image
        
        
        // Image process =======================
        let ciContext = CIContext(options: nil)
        let coreImage = CIImage(image: (adjImage?.image)!)
        let filter2 = CIFilter(name: "CIColorControls")
        filter2!.setDefaults()
        
        filter2!.setValue(contrastSlider.value, forKey: "inputContrast")     // 0 to 2
        filter2!.setValue(saturationSlider.value, forKey: "inputSaturation") // 0 to 2
        filter2!.setValue(brightnessSlider.value, forKey: "inputBrightness") // -1 to 1
        
        filter2!.setValue(coreImage, forKey: kCIInputImageKey)
        let filteredImgViewData = filter2!.valueForKey(kCIOutputImageKey) as! CIImage
        let filteredImgViewRef = ciContext.createCGImage(filteredImgViewData, fromRect: filteredImgViewData.extent)
        adjImage?.image = UIImage(CGImage: filteredImgViewRef)
        filteredImgView.image = adjImage?.image
        //containerView.addSubview(adjImage!)
        //containerView.addSubview(originalText)
    }
    
    
    
    
    

// MARK: - FILTERS BUTTON
    @IBOutlet weak var filtersButtOutlet: UIButton!
@IBAction func filtersToolbarButt(sender: AnyObject) {
        showHideFilters = !showHideFilters
        adjustmentView.hidden = true
        filtersView.hidden = false
        //editView.hidden = true
    bottleCapView.hidden = true
    frameView.hidden = true
    textBarView.hidden = true
        // showTheTextedits.hidden = true

        if showHideFilters {
            showFiltersView()
            hideAdjustmentView()
            //hideFramesView()
        } else {
            hideFiltersView()
        }
        
        showHideAdj = false
        showHideFrames = false
}
    
    
// MARK: - ADJUSTMENT BUTTON
    @IBOutlet weak var adjustmentButtOutlet: UIButton!
@IBAction func adjustmentButt(sender: AnyObject) {
        adjustmentView.hidden = false
        filtersView.hidden = true
        //editView.hidden = true
    frameView.hidden = true
    bottleCapView.hidden = true
    textBarView.hidden = true
        // showTheTextedits.hidden = true
        showHideAdj = !showHideAdj
        if showHideAdj {
            showAdjustmentView()
            //hideFramesView()
            hideFiltersView()
            
        } else {
            hideAdjustmentView()
        }
        
        showHideFilters = false
        showHideFrames = false
}
    
    
// MARK: - FRAMES BUTTON
    @IBOutlet weak var framesButtOutlet: UIButton!
@IBAction func framesButt(sender: AnyObject) {
        showHideFrames = !showHideFrames
        if showHideFrames {
           // showFramesView()
            hideFiltersView()
            hideAdjustmentView()
            frameView.hidden = true
        } else {
            //hideFramesView()
        }
        
        showHideAdj = false
        showHideFilters = false
}
    
    
// MARK: - TEXT BUTTON
    @IBOutlet weak var textOutlet: UIButton!
@IBAction func textButt(sender: AnyObject) {
    
        adjustmentView.hidden = true
        filtersView.hidden = true
        frameView.hidden = true
        bottleCapView.hidden = true
        imageTitleView.frame.origin.x = 0
        
        txtField.becomeFirstResponder()
        txtField.delegate = self
}
    
func textFieldShouldReturn(textField: UITextField) -> Bool {
    txtField.resignFirstResponder()
    imageTitleView.frame.origin.x = self.view.frame.size.width
    txtLabel.text = txtField.text
        
return true
}
    
    
@IBAction func frameButton(sender: AnyObject) {
        
        frameView.hidden = false
        adjustmentView.hidden = true
        filtersView.hidden = false
        //editView.hidden = true
        bottleCapView.hidden = true
    textBarView.hidden = true
}
    
// MARK: - SHOW/HIDE FILTERS VIEW
func showFiltersView() {
        filtersButtOutlet.backgroundColor = UIColor(red: 201.0/255.0, green: 91.0/255.0, blue: 96.0/255.0, alpha: 1.0)
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.filtersView.frame.origin.y = self.toolbarView.frame.origin.y - self.filtersView.frame.size.height
        }, completion: { (finished: Bool) in
        })
}
func hideFiltersView() {
        filtersButtOutlet.backgroundColor = UIColor.clearColor()
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.filtersView.frame.origin.y = self.view.frame.size.height
        }, completion: { (finished: Bool) in
        })
}
    
    
// MARK: - SHOW/HIDE ADJUSTMENT VIEW
func showAdjustmentView() {
    
    
        adjustmentButtOutlet.backgroundColor = UIColor(red: 201.0/255.0, green: 91.0/255.0, blue: 96.0/255.0, alpha: 1.0)
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.adjustmentView.frame.origin.y = self.toolbarView.frame.origin.y - self.adjustmentView.frame.size.height
        }, completion: { (finished: Bool) in
        })
}
func hideAdjustmentView() {
        adjustmentButtOutlet.backgroundColor = UIColor.clearColor()
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.adjustmentView.frame.origin.y = self.view.frame.size.height
        }, completion: { (finished: Bool) in
        })
}
    
    
// MARK: - SHOW/HIDE FRAMES VIEW
func showFramesView() {
        framesButtOutlet.backgroundColor = UIColor(red: 201.0/255.0, green: 91.0/255.0, blue: 96.0/255.0, alpha: 1.0)
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.framesView.frame.origin.y = self.toolbarView.frame.origin.y - self.framesView.frame.size.height
        }, completion: { (finished: Bool) in
        })
}
func hideFramesView() {
        framesButtOutlet.backgroundColor = UIColor.clearColor()
        
        UIView.animateWithDuration(0.1, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            self.framesView.frame.origin.y = self.view.frame.size.height
        }, completion: { (finished: Bool) in
        })
}
    

    
    @IBAction func textEdit(sender: AnyObject) {
        
        
        // showTheTextedits.hidden = false
        
        // editText.text! = showTheTextedits.text!
        
        // showTheTextedits.text = ""
        
        //textlabel.text = shoTextt.text
        //textlabel.reloadInputViews()
        containerView.addSubview(editView)
        //editView.hidden = false
        //doneText.hi
        adjustmentView.hidden = true
        filtersView.hidden = true
        frameView.hidden = true
        bottleCapView.hidden = true
        textBarView.hidden = true
        
    }
    
    
    // fromae view tusher
    
    @IBOutlet weak var frame_p_4: UIImageView!
    
    @IBAction func frame1(sender: AnyObject) {
        
        frame_P_1.hidden = false
        frame_p_2.hidden = true
        frame_p_3.hidden = true
        frame_p_4.hidden = true
    }
    
    @IBAction func frame2(sender: AnyObject) {
        
        frame_P_1.hidden = true
        frame_p_2.hidden = false
        frame_p_3.hidden = true
        frame_p_4.hidden = true
        
    }
    
    
    @IBAction func frame3(sender: AnyObject) {
        
        frame_P_1.hidden = true
        frame_p_2.hidden = true
        frame_p_3.hidden = false
        frame_p_4.hidden = true
    }
    
    @IBAction func frame4(sender: AnyObject) {
        
        frame_P_1.hidden = true
        frame_p_2.hidden = true
        frame_p_3.hidden = true
        frame_p_4.hidden = true
        
    }
    
    @IBAction func frame5(sender: AnyObject) {
        
        frame_P_1.hidden = true
        frame_p_2.hidden = true
        frame_p_3.hidden = true
        frame_p_4.hidden = false
        
    }
    
    
    
    @IBOutlet weak var editView: UIView!
    
    
    
    @IBOutlet weak var textabelShow: UITextField!

    @IBOutlet weak var originalText: UILabel!
   
    @IBAction func doneText(sender: AnyObject) {
        
        originalText.text = textabelShow.text
        //editView.hidden = true
        
        
    }

    
    
    
    
    
// tusher bottle change
    
    @IBAction func bottleCapAction(sender: AnyObject) {
        
        //editView.hidden = true
        adjustmentView.hidden = true
        filtersView.hidden = true
        frameView.hidden = true
        bottleCapView.hidden = false
        textBarView.hidden = true
        
    }

    @IBOutlet weak var bottleCapMainImage: UIImageView!
    
    @IBOutlet weak var bottleCapView: UIView!
    
    
    @IBAction func whiteCap(sender: AnyObject) {
        
        bottleCapMainImage.image = UIImage(named: "bottleOne")
        
    }
    
    
    @IBAction func blackCap(sender: AnyObject) {
        
        bottleCapMainImage.image = UIImage(named: "bottleTwo")
        
    }
    
    
    @IBAction func goldenCap(sender: AnyObject) {
        
        bottleCapMainImage.image = UIImage(named: "bottleThree")
        
    }
    
    
// tusher title change
    
    
    @IBOutlet weak var textBarView: UIView!
    
    @IBAction func textBarButton(sender: AnyObject) {
        
        adjustmentView.hidden = true
        filtersView.hidden = true
        frameView.hidden = true
        bottleCapView.hidden = true
        textBarView.hidden = false
        
    }
   
    
    @IBOutlet weak var textOneButtoneTitle: UIButton!
    
    @IBAction func text1(sender: AnyObject) {
        
        if textOneButtoneTitle.titleLabel?.text == "text1 On"{
        
            textOneButtoneTitle.titleLabel?.text = "text1 Off"
        
        }else if textOneButtoneTitle.titleLabel?.text == "text1 Off"{
        
            textOneButtoneTitle.titleLabel?.text = "text1 On"
            
        }
        
    }
    
    
    @IBOutlet weak var textTwoButtonTile: UIButton!
    
    @IBAction func text2(sender: AnyObject) {
        
        
        
        
    }
    
    
    @IBOutlet weak var textThreeButtonTitle: UIButton!
    
    @IBAction func text3(sender: AnyObject) {
        
        
        
        
    }
    
    
    @IBOutlet weak var testOneTitle: UITextView!
    
    @IBOutlet weak var textTwoTitle: UITextView!
    
    @IBOutlet weak var textThreeTitle: UITextView!
    
    
    
    
    
    
    
    
    
    
// MARK: - SAVE IMAGE BUTTON
@IBAction func saveImage(sender: AnyObject) {
        let rect: CGRect = containerView.bounds
        UIGraphicsBeginImageContextWithOptions(rect.size, true, 0.0)
        let context = UIGraphicsGetCurrentContext()
        containerView.layer.renderInContext(context!)
        combinedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
         print(combinedImage)
        finalImage = combinedImage
        self.performSegueWithIdentifier("imageToCarti", sender: self)
        //shareImage()
}
    
    
// MARK: - SHARE IMAGE METHOD
func shareImage() {
    let messageStr:String  = "Check out my awesome photo!"
    let img: UIImage = combinedImage!
        
    let shareItems:Array = [messageStr, img]
        
    let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
    activityViewController.excludedActivityTypes = [UIActivityTypePrint, UIActivityTypePostToWeibo, UIActivityTypeCopyToPasteboard, UIActivityTypeAddToReadingList, UIActivityTypePostToVimeo, UIActivityTypePostToFacebook, UIActivityTypePostToTwitter, UIActivityTypeMessage, UIActivityTypeMail, UIActivityTypeAssignToContact, UIActivityTypePostToFlickr, UIActivityTypeAirDrop]
        
    if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            // iPad
            let popOver = UIPopoverController(contentViewController: activityViewController)
            popOver.presentPopoverFromRect(saveOutlet.frame, inView: self.view, permittedArrowDirections: UIPopoverArrowDirection.Any, animated: true)
    } else {
            // iPhone
            presentViewController(activityViewController, animated: true, completion: nil)
    }

}
    
    
    
    
    
    
    
override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
}
}
