//
//  TableViewController.swift
//  CDSample
//
//  Created by Ángel González on 11/10/24.
//

import UIKit
import CoreData

class TableViewController: UITableViewController {
    var personas = [Persona]()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // SELECT * FROM Persona
        let elQuery = NSFetchRequest<NSFetchRequestResult>(entityName:"Persona")
        // Si necesitamos establecer un criterio de busqueda, usamos NSPredicate
        // let elFiltro = NSPredicate (format:"apellidos = %@", "Simpson")
        // let elFiltro = NSPredicate (format:"apellidos <> %@", "Simpson")
        // let elFiltro = NSPredicate (format:"apellidos BEGINSWITH[c] %@", "S")
        let elFiltro = NSPredicate (format:"apellidos CONTAINS[c] %@", "o")
        // SELECT * FROM Persona WHERE apellidos = 'Simpson'
        elQuery.predicate = elFiltro
        if let ad = UIApplication.shared.delegate as? AppDelegate {
            do {
                let tmp = try ad.persistentContainer.viewContext.fetch(elQuery)
                personas = tmp as! [Persona]
            } catch {
                print ("error en el query!")
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return personas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "unaCelda", for: indexPath)
        let tmp = personas[indexPath.row]
        cell.textLabel?.text = "\(tmp.nombre ?? "") \(tmp.apellidos ?? "")"
        return cell
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
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
