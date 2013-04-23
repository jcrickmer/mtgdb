package app.models;

import org.javalite.activejdbc.Model;
import org.javalite.activejdbc.annotations.Many2Many;

/**
 * 
 */
@Many2Many(other = BaseCard.class, join = "cardsubtypes", sourceFKName = "subtype_id", targetFKName = "basecard_id")
public class Subtype extends Model {
}
