//
//  NoteTableViewCell.swift
//  Animatify
//
//  Created by Shubham Singh on 11/02/21.
//  Copyright © 2021 Shubham Singh. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell, UINibInstantiable {
    
    // MARK:- outlets
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var noteTitleLabel: UILabel!
    @IBOutlet weak var noteDateLabel: UILabel!
    @IBOutlet weak var noteDescriptionLabel: UILabel!
    
    // MARK:- variables
    override class func description() -> String {
        return "NoteTableViewCell"
    }

    let rowHeight: CGFloat = 117
    
    // MARK:- lifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none

        DispatchQueue.main.async {
            self.containerView.roundCorners(cornerRadius: 4)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    // MARK:- functions
    func setupCell(note: Note) {
        self.noteTitleLabel.text = note.title
        self.noteDateLabel.text = note.dateString
        self.noteDescriptionLabel.text = note.content
        
        self.containerView.backgroundColor = note.noteColor
    }
}
