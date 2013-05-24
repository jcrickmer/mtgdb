package app.models;

import org.javalite.activejdbc.Model;

/**
 * 
 */
public class Type extends Model {

    public static Type Land() {
	return Type.first("type = ?", "Land");
    }

}
