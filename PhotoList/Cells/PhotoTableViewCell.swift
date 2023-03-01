
import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbImgView : UIImageView!
    @IBOutlet weak var titleLabel : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setupCell(viewModel: PhotoListTableCellViewModel) {
        self.thumbImgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
        if let url = viewModel.thumbnailUrl {
             self.thumbImgView.sd_setImage(with:url, placeholderImage: UIImage(named: "placeholder.png"))
         }
        self.titleLabel?.text = viewModel.title
        self.titleLabel?.textColor = UIColor(named: "textColor")
    }
}
