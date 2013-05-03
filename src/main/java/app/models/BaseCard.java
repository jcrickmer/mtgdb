package app.models;

import org.javalite.activejdbc.Model;
import org.javalite.activejdbc.annotations.Table;
import org.javalite.activejdbc.annotations.Many2Many;

import us.newplatyp.mtg.Symbols;
import app.util.BaseCardValidator;
import java.util.Set;
import java.util.HashSet;

/**
 * 
 */
@Table("basecards")
@Many2Many(other = Type.class, join = "cardtypes", sourceFKName = "basecard_id", targetFKName = "type_id")
public class BaseCard extends Model {

    static {
	//validateWith(new BaseCardValidator<BaseCard>());
    }

    protected void beforeValidation() {
	super.beforeValidation();
	if (this.get("power") != null && this.get("power").equals("")) {
	    this.set("power", null);
	}
	if (this.get("toughness") != null && this.get("toughness").equals("")) {
	    this.set("toughness", null);
	}
	if (this.get("loyalty") != null && this.get("loyalty").equals("")) {
	    this.set("loyalty", null);
	}
    }

    /**
     * convenience for getting the colors out.
     */
    public Set<Color> colors = new HashSet<Color>();

    /**
     * Sets the mana cost and the CMC.  Returns the CMC.
     */
    public int setManaCost(String manacost) throws ManaCostFormatException {
	try {
	    // go through the string and parse it...
	    manacost = manacost.toLowerCase();
	    int runningTotal = 0;
	    boolean instate = false;
	    String capt = null;
	    for (int place = 0; place < manacost.length(); place++) {
		if (! instate) {
		    if (manacost.charAt(place) == '{') {
			instate = true;
		    } else if (manacost.charAt(place) == ' ') {
			// just a space... move on...
		    } else {
			throw new ManaCostFormatException("Invalid character at place " + place + ".  Expected '{' instead of '" + manacost.charAt(place) + "'.  Full string is \"" + manacost + "\".");
		    }
		} else {
		    // ok, we are in the brackets!
		    if (manacost.charAt(place) == '}') {
			// ok, closing it out!!!
			if (capt == null) {
			    // What?  They gave us nothing in these curly brackets!
			    throw new ManaCostFormatException("Expected token at place " + place + " ('" + manacost.charAt(place) + "').  Full string is \"" + manacost + "\".");
			} else if (Symbols.symbols.contains(capt)) {
			    // capt should match something we know.  Looks like it did!  Logic for converting to CMC goes here.
			    runningTotal += Symbols.symbolValues.get(capt).intValue();
			    if (capt.contains("w")) { this.colors.add(Color.W()); }
			    if (capt.contains("u")) { this.colors.add(Color.U()); }
			    if (capt.contains("b")) { this.colors.add(Color.B()); }
			    if (capt.contains("r")) { this.colors.add(Color.R()); }
			    if (capt.contains("g")) { this.colors.add(Color.G()); }

			    capt = null;
			    instate = false;
			} else {
			    // lame.  they are trying to give us something that we do not know.			
			    throw new ManaCostFormatException("Invalid character(s) at place " + (place - 1) + " ('" + manacost.charAt(place - 1) + "').  capt is \"" + capt + "\". Full string is \"" + manacost + "\".");
			}
		    } else {
			// let's keep what we got!
			if (capt == null) {
			    char[] ggg = { manacost.charAt(place) };
			    capt = new String(ggg);
			} else {
			    capt = capt + manacost.charAt(place);
			}
		    }
		}
	    }
	    this.set("mana_cost", manacost);
	    this.set("cmc", runningTotal);
	    return Integer.parseInt(this.get("cmc").toString());
	} catch (ManaCostFormatException mcfe) {
	    this.addError("mana_cost", mcfe.getMessage());
	    throw mcfe;
	}
    }
}
