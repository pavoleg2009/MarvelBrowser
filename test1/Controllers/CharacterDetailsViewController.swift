//
//  CharacterDetailsViewController.swift
//  test1
//
//  Created by Oleg Pavlichenkov on 19/10/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

import UIKit

class CharacterDetailsViewController: UIViewController {
    
    var character: Character!

    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        populateView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func populateView() {
        title = character.name
        descriptionTextView.text = character.characterDescription
        thumbnailImage.pos_setImage(url: URL(string:character.thumbnailPath))
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
