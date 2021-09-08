import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var userNames = ["Alexander", "Suyama"]
        
    //ユーザーツイート
    var tweets = ["Our short film, Sister Hearts, is a #Webbys finalist for Best Branded Long Form Video #Webbys finalist for Best Branded Long Form Video", "Our short film"]
     
    //ユーザー画像
    var userPhotos = ["icon1", "icon1"]

    @IBOutlet weak var tweetTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tweetTableView.dataSource = self
        tweetTableView.delegate = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        tweetTableView.estimatedRowHeight = 150
        return UITableView.automaticDimension //変更
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tweetTableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as? TweetTableViewCell
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        
        cell?.profileName.text = self.userNames[indexPath.row]
        cell?.tweet.text = self.tweets[indexPath.row]
        cell?.profileImage.image = UIImage(named: self.userPhotos[indexPath.row])
        cell?.profileImage.layer.cornerRadius = 25
        
        return cell!
    }
}
