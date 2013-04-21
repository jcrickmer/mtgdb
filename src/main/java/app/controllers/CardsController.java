package app.controllers;

import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.DELETE;
import org.javalite.activeweb.annotations.POST;
import app.models.Card;

/**
 * 
 */
public class CardsController extends AppController {                

    public void index(){
        view("cards", Card.findAll());
    }

    public void show(){
        //this is to protect from URL hacking
        Card c = (Card) Card.findById(getId());
        if(c != null){
            view("card", c);
        }else{
            view("message", "are you trying to hack the URL?");
            render("/system/404");
        }
    }
    
    @POST
    public void create(){
        Card card = new Card();
        card.fromMap(params1st());
        if(!card.save()){
            flash("message", "Something went wrong, please  fill out all fields");
            flash("errors", card.errors());
            flash("params", params1st());
            redirect(CardsController.class, "new_form");
        }else{
            flash("message", "New card was added: " + card.get("name"));
            redirect(CardsController.class);
        }
    }

    @DELETE
    public void delete(){

        Card b = (Card)Card.findById(getId());
        String name = b.getString("name");
        b.delete();
        flash("message", "Card: '" + name + "' was deleted");
        redirect(CardsController.class);
    }

    public void newForm(){}
}
