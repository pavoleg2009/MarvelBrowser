//
//  MainTableViewController.swift
//  test1
//
//  Created by Oleg Pavlichenkov on 17/10/2017.
//  Copyright © 2017 Oleg Pavlichenkov. All rights reserved.
//

import UIKit

class MainTableViewController: UITableViewController {
    
    var apiClient = ApiClient.shared
    var characters: [Character] = []
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        //searchController.searchBar.delegate = self
        
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        initialRequest()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Test", style: .plain, target: self, action: #selector(test(_:)))
    }
    
    func initialRequest() {
        apiClient.getSearchResults(searchTerm: "S") { (characters, string) in
            self.characters = characters
            self.tableView.reloadData()
        }
    }
    
    @IBAction func test(_ sender: Any) {
//        print("test")
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return characters.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "characterCell", for: indexPath) as? CharacterTableViewCell else {
            return UITableViewCell()
        }
        
        let character = characters[indexPath.row]
    
        cell.nameLabel.text = character.name
        cell.idLabel.text = String(character.id)
        cell.modifiedLabel.text = Character.dateToStringFormatter.string(from: character.modified)
//        cell.descriptionTextView.text = character.characterDescription
        cell.thumbnailImage.pos_setImage(url: URL(string:character.thumbnailPath))
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 94
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    // MARK: - Navigation


   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showCharacterDetails" {
            guard let vc = segue.destination as? CharacterDetailsViewController,
                let selectedIndexPath = tableView.indexPathForSelectedRow
                else { return }
            
            navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
            
            vc.character = characters[selectedIndexPath.row]
            
        }
    }
}

extension MainTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentFor(searchTerm: searchController.searchBar.text)
    }
    
    func filterContentFor(searchTerm: String?) {
        
        guard let searchTerm = searchTerm else {
            clearSearch()
            return
        }
        
        apiClient.getSearchResults(searchTerm: searchTerm) { (characters, error) in
            self.characters = characters
            self.tableView.reloadData()
        }
    }
    
    func clearSearch() {
        
    }
}

//extension MainTableViewController: UISearchBarDelegate {
//
//}


