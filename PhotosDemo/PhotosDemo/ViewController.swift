//
//  ViewController.swift
//  PhotosDemo
//
//  Created by LJ on 15/8/28.
//  Copyright (c) 2015年 广东道一信息科技有限公司. All rights reserved.
//

import UIKit
import Photos

class ViewController: UITableViewController,UITableViewDelegate {
    private var userAlbums:PHFetchResult!
    private var userFavorites:PHFetchResult!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        PHPhotoLibrary.requestAuthorization {  status in dispatch_async(dispatch_get_main_queue(), { () -> Void in
            switch status {
            case .Authorized:
                self.fectchCollections()
                self.tableView.reloadData()
            default:
                self.showNoAccessAlertAndCancel()
            }
            
        })
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //MARK: - UITableViewDataSource
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 3
        case 1:
            return 3
        case 2:
            return 3
        default:
            return 0
        }
    }
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        //
        return 3;
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        //
        var cell = UITableViewCell()
        switch indexPath.section{
        case 0:
            break
        case 1:
            if indexPath.row == 0 {
                
            }
            else {
                
            }
            break
        case 2:
            cell.textLabel?.text = "选取"
            break
        default:
            break
            
        }
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let options = PHFetchOptions()
        options.sortDescriptors =
            [NSSortDescriptor(key: "creationDate", ascending: true)]
        let assets = PHAsset.fetchAssetsWithOptions(options)
        var destination = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("AssetCollection") as! AssetsViewController
        
        //AssetCollection
        destination.assetsFetchResults = PHAsset.fetchAssetsWithOptions(options)
        self.presentViewController(destination, animated: true, completion: nil)
    }
    
    func fectchCollections(){
        userAlbums = PHCollectionList.fetchTopLevelUserCollectionsWithOptions(nil)
        userFavorites = PHAssetCollection.fetchAssetCollectionsWithType(.SmartAlbum, subtype: .SmartAlbumFavorites, options: nil)
        
    }
    func showNoAccessAlertAndCancel(){
        
    }
    

}

