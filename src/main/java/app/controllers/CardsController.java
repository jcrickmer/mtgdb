package app.controllers;

import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.DELETE;
import org.javalite.activeweb.annotations.POST;
import app.models.BaseCard;
import app.models.Card;
import app.models.ExpansionSet;
import app.models.Rarity;
import app.models.Color;
import app.models.CardColor;
import app.models.Type;
import app.models.CardType;
import app.models.CardSubtype;
import app.models.Subtype;
import app.models.ManaCostFormatException;

import java.util.Iterator;

/**
 * 
 */
public class CardsController extends AppController {                

    public void index(){
        view("cards", Card.findAll());
    }

    public void show(){
        //this is to protect from URL hacking
        //Card c = (Card) Card.findById(getId());
	Card c = (Card) Card.first("multiverseid = ?", getId());
	//BaseCard bc = (BaseCard) c.parent(BaseCard.class);
        if(c != null){
            view("card", c);
        }else{
            view("message", "are you trying to hack the URL?");
            render("/system/404");
        }
    }
    
    @POST
    public void create(){
	// let's check the "must have" fields.  We are goign to do tis here rather than in the model controllers because we are building an aggregate.
	{
	    org.javalite.activejdbc.Errors errs = new org.javalite.activejdbc.Errors();
	    if (! this.requestHas("name") || this.param("name").equals("")) {
		errs.put("name","Name is a required field.");
	    }
	    if (! this.requestHas("type_id") || this.param("type_id").equals("")) {
		errs.put("type_id","Type is a required field.");
	    }
	    if (! this.requestHas("rarity_id") || this.param("rarity_id").equals("")) {
		errs.put("rarity_id","Rarity is a required field.");
	    }
	    if (! this.requestHas("multiverseid") || this.param("multiverseid").equals("")) {
		errs.put("multiverseid","Multiverseid is a required field.");
	    }
	    if (! this.requestHas("expansionset_id") || this.param("expansionset_id").equals("")) {
		errs.put("expansionset_id","Expansion Set is a required field.");
	    }
	    if (! errs.isEmpty()) {
		flash("errors", errs);
		flash("params", params1st());
		redirect(CardsController.class, "new_form");
		return;
	    }
	}

	BaseCard bcard = new BaseCard();
	bcard.set("name", this.param("name"));
	bcard.set("rules_text", this.param("rules_text"));
	try {
	    bcard.setManaCost(this.param("mana_cost"));
	} catch (ManaCostFormatException mcfe) {
            flash("message", mcfe.getMessage());
            flash("params", params1st());
            redirect(CardsController.class, "new_form");
	    return;
	}
	bcard.set("power", this.param("power"));
	bcard.set("toughness", this.param("toughness"));
	bcard.set("loyalty", this.param("loyalty"));

        if (! bcard.save()){
            flash("message", "Something went wrong, please fill out all fields");
            flash("errors", bcard.errors());
            flash("params", params1st());
            redirect(CardsController.class, "new_form");
        } else {
	    // with the base card saved, we need to fill in the dependencies.
	    CardType cardType = new CardType();
	    cardType.set("basecard_id", bcard.get("id"));
	    cardType.set("type_id", this.param("type_id"));
	    cardType.set("position", 0);
	    if (! cardType.save()) {
		flash("message", "Error saving new card's type.  Database is probably now in an invalid state for the card you just tried to add.");
		redirect(CardsController.class, "new_form");
		return;
	    }

	    if (this.requestHas("subtype_id") && ! this.param("subtype_id").equals("")) {
		CardSubtype cardSubtype = new CardSubtype();
		cardSubtype.set("basecard_id", bcard.get("id"));
		cardSubtype.set("subtype_id", this.param("subtype_id"));
		cardSubtype.set("position", 0);
		if (! cardSubtype.save()) {
		    flash("message", "Error saving new card's subtype.  Database is probably now in an invalid state for the card you just tried to add.");
		    redirect(CardsController.class, "new_form");
		    return;
		}
	    }

	    Iterator<Color> it = bcard.colors.iterator();
	    while (it.hasNext()) {
		Color tno = it.next();
		CardColor cc = new CardColor();
		cc.set("basecard_id", bcard.get("id"));
		cc.set("color_id", tno.get("id"));
		try {
		    cc.save();
		} catch (org.javalite.activejdbc.DBException eee) {
		    // That's cool.  I just need to make my colorsetting algo's better.  I wish Color.hasCode() was working like I first thought it might...
		}
	    }

	    Card card = new Card();
	    card.set("basecard_id", bcard.get("id"));
	    card.set("expansionset_id", this.param("expansionset_id"));
	    card.set("multiverseid", this.param("multiverseid"));
	    card.set("flavor_text", this.param("flavor_text"));
	    card.set("rarity", this.param("rarity_id"));

	    if (! card.save()) {
		flash("message", "Error saving new card's card.  Database is probably now in an invalid state for the card you just tried to add. base id " + bcard.get("id"));
		redirect(CardsController.class, "new_form");
		return;
	    }
            flash("message", "New card was added: " + bcard.get("name"));
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

    public void newForm() {
        view("expansionsets", ExpansionSet.findAll());
        view("rarities", Rarity.findAll());
        view("colors", Color.findAll());
        view("types", Type.findAll());
        view("subtypes", Subtype.findAll());
    }
}
