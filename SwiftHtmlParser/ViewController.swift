//
//  ViewController.swift
//  SwiftHtmlParser
//
//  Created by 小尛龙 on 14-11-2.
//  Copyright (c) 2014年 iMac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet  var cityLabel: UILabel!
    var url:String? = "http://www.pm25.in/wuxi"
    var city:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
      getData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData(){
        var url : NSURL = NSURL(string: self.url!)
        let request : NSURLRequest = NSURLRequest(URL: url)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue(), completionHandler: { (response, data, error) -> Void in
            if (error != nil){
                let alertView:UIAlertView = UIAlertView()
                alertView.title="提示"
                alertView.message="\(error.localizedDescription)"
                alertView.addButtonWithTitle("确定")
                alertView.show()
            }else{
                self.parseData(data)
            }
        })
        
    }
    
    /**
    解析html
    */

    func parseData(data:NSData){
       var doc:TFHpple = TFHpple.hppleWithHTMLData(data,encoding:"UTF8")
        
        /**
        <div class="city_name">
        <h2>无锡</h2>
        </div>
        */
       var city:TFHppleElement = doc.peekAtSearchWithXPathQuery("//div[@class='city_name']/h2")
       
        /**城市
        {
        nodeChildArray =(
        {
        nodeContent = "\U65e0\U9521";
        nodeName = text;
        }
        );
        nodeName = h2;
        raw = "<h2>\U65e0\U9521</h2>";
        }*/
        
        
        self.city = city.firstChild.content?.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
      
        println("城市:\(self.city)")
        self.cityLabel.text = "解析城市：" + self.city!
        
    }
   

}

