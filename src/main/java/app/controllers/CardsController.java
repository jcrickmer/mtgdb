package app.controllers;

import org.javalite.activejdbc.Base;
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
	//setRequestEncoding("UTF-8");
	//setResponseEncoding("UTF-8");
	setEncoding("UTF-8");

        view("cards", Card.findAll());
    }

    public void show(){
	//setRequestEncoding("UTF-8");
	//setResponseEncoding("UTF-8");
	setEncoding("UTF-8");

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
	//setRequestEncoding("UTF-8");
	//setResponseEncoding("UTF-8");
	setEncoding("UTF-8");

	Gson gson = (Gson)(this.appContext().get("json"));
	Map map = new HashMap();
	if (this.requestHas("name")) {
	    BaseCard bc = (BaseCard) BaseCard.first("name = ?", this.param("name"));
	    map.put("BaseCard", bc);
	}
	respond(gson.toJson(map)).contentType("application/json").status(200);
    }

    private class RollItBackException extends Exception {
	RollItBackException() {
	    super();
	}
	RollItBackException(String msg) {
	    super(msg);
	}
    }

    @POST
    /**
     * Create a new Card, and create the BaseCard in the process, if it does not already exist.
     *
     * NOTE - I have not tested the transaction wrappers failure
     * conditions.  Nor, have I tested violation of unique indices.
     */
    public void create(){
	//setRequestEncoding("UTF-8");
	//setResponseEncoding("UTF-8");
	setEncoding("UTF-8");
	try {
	    Base.connection().setAutoCommit(false);
	    org.javalite.activejdbc.Errors errs = new org.javalite.activejdbc.Errors();
	    try {
		BaseCard bcard = null;
		// let's check the "must have" fields.  We are goign to do tis here rather than in the model controllers because we are building an aggregate.
		{
		    if (this.requestHas("basecard_id") && ! this.param("basecard_id").equals("")) {
			// we are building from an existing base card!!!  Woot!
			bcard = BaseCard.findById(new Integer(this.param("basecard_id")));
			if (bcard == null) {
			    errs.put("message","Well, this is a problem.  It looks like you specified a card as the base card, but I don't know what card that is.");
			}
		    } else {
			if (! this.requestHas("name") || this.param("name").equals("")) {
			    errs.put("name","Name is a required field.");
			}
			if (! this.requestHas("mana_cost") || this.param("mana_cost").equals("")) {
			    if (this.requestHas("type_id") && this.param("type_id").equals(Type.Land().getString("type"))) {
				// ok! If they don't put a mana cost for Land, that is ok.
			    } else {
				errs.put("mana_cost","Mana Cost is a required field unless the type is Land.  For no mana cost on nonland cards, use {0}.");
			    }
			}
			if (! this.requestHas("as_values_as_type_node") || this.param("as_values_as_type_node").equals("")) {
			    errs.put("type_id","Type is a required field.");
			}
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
			throw new RollItBackException();
		    }
		}
	    
		if (bcard == null) {
		    bcard = new BaseCard();
		    bcard.set("name", this.param("name"));
		    bcard.set("rules_text", this.param("rules_text"));
		    try {
			bcard.setManaCost(this.param("mana_cost"));
		    } catch (ManaCostFormatException mcfe) {
			throw new RollItBackException(mcfe.getMessage());
		    }
		    bcard.set("power", this.param("power"));
		    bcard.set("toughness", this.param("toughness"));
		    bcard.set("loyalty", this.param("loyalty"));
		
		    if (! bcard.save()){
			errs = bcard.errors();
			throw new RollItBackException("Something went wrong, please fill out all fields");
		    } else {
			// with the base card saved, we need to fill in the dependencies.
			String[] typeIds = this.param("as_values_as_type_node").split(",");
			for (int uu = 0; uu < typeIds.length; uu++) {
			    CardType cardType = new CardType();
			    cardType.set("basecard_id", bcard.get("id"));
			    cardType.set("type_id", Integer.parseInt(typeIds[uu]));
			    cardType.set("position", uu);
			    if (! cardType.save()) {
				throw new RollItBackException("Error saving new card's type.");
			    }
			}
		    
			if (this.requestHas("as_values_as_subtype_node") && ! this.param("as_values_as_subtype_node").equals("")) {
			    String[] subtypeIds = this.param("as_values_as_subtype_node").split(",");
			    for (int uu = 0; uu < subtypeIds.length; uu++) {
				CardSubtype cardSubtype = new CardSubtype();
				cardSubtype.set("basecard_id", bcard.get("id"));
				cardSubtype.set("subtype_id", Integer.parseInt(subtypeIds[uu]));
				cardSubtype.set("position", uu);
				if (! cardSubtype.save()) {
				    throw new RollItBackException("Error saving new card's subtype.");
				}
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
				logError(eee);
				// That's cool.  I just need to make my colorsetting algo's better.  I wish Color.hasCode() was working like I first thought it might...
			    }
			}
		    }
		}

		Card card = new Card();
		card.set("basecard_id", bcard.get("id"));
		card.set("expansionset_id", this.param("expansionset_id"));
		card.set("multiverseid", this.param("multiverseid"));
		card.set("flavor_text", this.param("flavor_text")); // REVISIT - Looks like there may be a character encoding issue here.  I tried an emdash from UTF8 and it looks like it broke somewhere.
		card.set("rarity", this.param("rarity_id"));
	    
		if (! card.save()) {
		    throw new RollItBackException("Error saving new card's card.");
		}

		Base.commitTransaction();
		flash("message", "New card was added: " + bcard.get("name"));
/*	    } catch (java.sql.SQLException e) {
		logError(e);
		Base.rollbackTransaction();
		flash("errors", errs);
		flash("params", params1st());
		flash("message", e.getMessage());
		redirect(CardsController.class, "new_form");
*/
	    } catch (RollItBackException e) {
		Base.rollbackTransaction();
		flash("errors", errs);
		flash("params", params1st());
		flash("message", e.getMessage());
		redirect(CardsController.class, "new_form");
	    }
	    Base.connection().setAutoCommit(true);
	} catch(java.sql.SQLException sqle) {
	    logError(sqle);
	}

	redirect(CardsController.class, org.javalite.common.Collections.map("action", "show", "id", this.param("multiverseid")));
    }


    @DELETE
    public void delete(){
	//setRequestEncoding("UTF-8");
	//setResponseEncoding("UTF-8");
	setEncoding("UTF-8");

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
	//setRequestEncoding("UTF-8");
	//setResponseEncoding("UTF-8");
	setEncoding("UTF-8");

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
	//setRequestEncoding("UTF-8");
	//setResponseEncoding("UTF-8");
	setEncoding("UTF-8");

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
