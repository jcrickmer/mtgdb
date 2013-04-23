package app.models;

import org.javalite.activejdbc.Model;
import org.javalite.activejdbc.annotations.Table;
import org.javalite.activejdbc.annotations.Many2Many;

/**
 * 
 */
@Table("basecards")
@Many2Many(other = Type.class, join = "cardtypes", sourceFKName = "basecard_id", targetFKName = "type_id")
public class BaseCard extends Model {
}
