package app.models;

import org.javalite.activejdbc.Model;
import org.javalite.activejdbc.annotations.Table;
import org.javalite.activejdbc.annotations.Many2Many;

/**
 * 
 */
@Table("colors")
@Many2Many(other = BaseCard.class, join = "cardcolors", sourceFKName = "color_id", targetFKName = "basecard_id")
public class Color extends Model {

    public static Color W() {
	return Color.first("id = ?", "W");
    };
    public static Color U() {
	return Color.first("id = ?", "U");
    };
    public static Color B() {
	return Color.first("id = ?", "B");
    };
    public static Color R() {
	return Color.first("id = ?", "R");
    };
    public static Color G() {
	return Color.first("id = ?", "G");
    };

    public int hashCode() {
	Object id = this.get("id");
	if (id != null
	    && ! id.toString().equals("")) {
	    return id.toString().hashCode();
	} else {
	    return super.hashCode();
	}
    }
}
