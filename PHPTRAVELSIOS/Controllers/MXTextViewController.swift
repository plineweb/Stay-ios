

import UIKit
import MapKit

class MXTextViewController: UIViewController {
    
    
    @IBOutlet weak var desc: UILabel!
   
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var policy: UILabel!
    @IBOutlet weak var payments: AmenitiesCollection!
    @IBOutlet weak var amen_collection: AmenitiesCollection!
    
    var amenities_arry:[NameImage] = []{
        didSet{
            amen_collection.mainArray = amenities_arry
        }
    }
    
    var payments_arry:[NameImage] = []{
        didSet{
            payments.mainArray = payments_arry
        }
        
    }
    
    var overView : Overview? = nil {
        didSet{
            desc.text = overView?.desc
            policy.text = overView?.policy
            
            let location = CLLocationCoordinate2DMake(Double((overView?.latitude)!)!,Double((overView?.longitude)!)!)
            
            let span = MKCoordinateSpanMake(0.05,0.05)
            let region = MKCoordinateRegion(center: location, span: span)
            mapView.setRegion(region, animated: true)
            
            let dropPin = MKPointAnnotation()
            dropPin.coordinate = location
            dropPin.title = "Location"
            mapView.addAnnotation(dropPin)
            
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    


        
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }
    
    
    
}
