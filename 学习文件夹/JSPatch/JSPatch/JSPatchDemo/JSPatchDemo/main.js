
//main.js
require('JPViewController')
defineClass("XRTableViewController", {
            tableView_didSelectRowAtIndexPath: function(tableView, indexPath) {
            var row = indexPath.row()
            if (self.dataSource().count() > row) {  //fix the out of bound bug here
                var content = self.dataSource().objectAtIndex(row);
                var ctrl = JPViewController.alloc().initWithContent(content);
                self.navigationController().pushViewController_animated(ctrl, YES)
                 }
            }
})