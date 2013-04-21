package app.models;

import org.javalite.activejdbc.Model;

/**
 * 
 */
public class Card extends Model {
    static {
        validatePresenceOf("name"); //.message("Author must be provided");
        validatePresenceOf("rules_text");
    }
}
