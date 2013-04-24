package app.controllers;

import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.DELETE;
import org.javalite.activeweb.annotations.POST;
import app.models.ExpansionSet;

/**
 * 
 */
public class ExpansionSetsController extends AppController {                

    public void index(){
        view("expansionsets", ExpansionSet.findAll());
    }

    public void show(){
        //this is to protect from URL hacking
        ExpansionSet b = (ExpansionSet) ExpansionSet.findById(getId());
        if(b != null){
            view("expansionset", b);
        }else{
            view("message", "are you trying to hack the URL?");
            render("/system/404");
        }
    }
    
    @POST
    public void create(){
        ExpansionSet expansionset = new ExpansionSet();
        expansionset.fromMap(params1st());
        if(!expansionset.save()){
            flash("message", "Something went wrong, please  fill out all fields");
            flash("errors", expansionset.errors());
            flash("params", params1st());
            redirect(ExpansionSetsController.class, "new_form");
        }else{
            flash("message", "New expansionset was added: " + expansionset.get("name"));
            redirect(ExpansionSetsController.class);
        }
    }

    @DELETE
    public void delete(){

        ExpansionSet b = (ExpansionSet)ExpansionSet.findById(getId());
        String name = b.getString("name");
        b.delete();
        flash("message", "ExpansionSet: '" + name + "' was deleted");
        redirect(ExpansionSetsController.class);
    }

    public void newForm(){}
}
