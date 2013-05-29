package app.controllers;

import org.javalite.activeweb.AppController;
import org.javalite.activeweb.annotations.DELETE;
import org.javalite.activeweb.annotations.GET;
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
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import com.google.gson.Gson;

import org.javalite.activeweb.freemarker.SelectOption;

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
    public void getBaseCardByName() {
	Gson gson = (Gson)(this.appContext().get("json"));
	Map map = new HashMap();
	if (this.requestHas("name")) {
	    BaseCard bc = (BaseCard) BaseCard.first("name = ?", this.param("name"));
	    logError("BASECARD TYPE IS " + bc.get("type").getClass());
	    map.put("BaseCard", bc);
	}
	respond(gson.toJson(map)).contentType("application/json").status(200);
    }

    @POST
    public void create(){
	// let's check the "must have" fields.  We are goign to do tis here rather than in the model controllers because we are building an aggregate.
	{
	    org.javalite.activejdbc.Errors errs = new org.javalite.activejdbc.Errors();
	    if (! this.requestHas("name") || this.param("name").equals("")) {
		errs.put("name","Name is a required field.");
	    }
	    if (! this.requestHas("mana_cost") || this.param("mana_cost").equals("")) {
		if (this.requestHas("type_id") && this.param("type_id").equals(Type.Land().getString("type"))) {
		    // ok! If they don't put a mana cost for Land, that is ok.
		} else {
		    errs.put("mana_cost","Mana Cost is a required field unless the type is Land.");
		}
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

    /**
     * Convience method to get the "params" value out of Flasher.
     */
    Map getFParams() {
	Map result = null;
	Object flashMap = (Map) session().get("flasher");
	if (flashMap != null && flashMap instanceof Map) {
	    Object obj = ((Map) flashMap).get("params");
	    if (obj != null && obj instanceof Map) {
		result = (Map)obj;
	    }
	}
	if (result == null) {
	    result = new HashMap();
	}
	return result;
    }


    @POST
    public void nameLookup() {
	int limit = 15;
	try {
	    limit = Integer.parseInt(this.param("limit"));
	} catch (Exception e) { }

	ArrayList<String> vals = new ArrayList();
	if (this.requestHas("namePartial")) {
	    List<BaseCard> cards = BaseCard.where("LOWER(name) LIKE ?", this.param("namePartial").toLowerCase() + "%") // ASSUMPTION - the ActiveJDBC where function will SQL-escape the data.
		.limit(15)
		.orderBy("name ASC");
	    Iterator<BaseCard> it = cards.iterator();
	    while (it.hasNext()) {
		BaseCard bc = it.next();
		vals.add(bc.getString("name"));
	    }
	}
	Gson gson = (Gson) (this.appContext().get("json"));
	Map map = new HashMap();
	map.put("terms", vals);
	respond(gson.toJson(map)).contentType("application/json").status(200);
    }

    public void newForm() {
	Map fParams = getFParams();
        view("expansionsets", ExpansionSet.findAll());
        view("rarities", Rarity.findAll());
        view("colors", Color.findAll());

	List<Type> types = Type.findAll();
        view("types", types);
	List<SelectOption> typesList = new ArrayList();
	Iterator<Type> it = types.iterator();
	while (it.hasNext()) {
	    Type cType = it.next();
	    int cTypeId = cType.getInteger("id").intValue();
	    SelectOption so = new SelectOption(cTypeId, cType.getString("type"));
	    //logError("param is " + fParams.get("type_id"));
	    so.setSelected(fParams.get("type_id") != null && fParams.get("type_id").equals("" + cTypeId));
	    typesList.add(so);
	}
	view("typesList", typesList);

        view("subtypes", Subtype.findAll());
	/* andy piece ofcode to see what is the in context.  I have not had much luck finding debug tools for Freemarker
	Map<String,Object> bbb = values();
	Iterator<String> cit = bbb.keySet().iterator();
	while (cit.hasNext()) {
	    logError("context: " + cit.next());
	}
	*/
    }
}
