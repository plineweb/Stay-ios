

import UIKit
import SDWebImage

class AmenitiesCollection: UICollectionView, UICollectionViewDelegate,UICollectionViewDataSource{

    
    var mainArray:[NameImage] = []{
        didSet{
            reloadData()
        }
        
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        self.delegate=self
        self.dataSource=self
        let layout = self.collectionViewLayout as? UICollectionViewFlowLayout
        layout?.minimumLineSpacing = 1
        
    }
    
 

    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
       return self.mainArray.count
        
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AmenitiesCell", for: indexPath) as! AmenitiesCell
        
        if mainArray[indexPath.row].img == ""{
         
            cell.image = UIImageView(image: #imageLiteral(resourceName: "checked"))
            
        }else{
        
            cell.image.sd_setImage(with: URL(string:self.mainArray[indexPath.row].img))
            
        }
              cell.name.text = self.mainArray[indexPath.row].name
        
        return cell
    
        
    }

}
