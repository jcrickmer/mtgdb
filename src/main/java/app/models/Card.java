package app.models;

import org.javalite.activejdbc.Model;
import org.javalite.activejdbc.annotations.BelongsTo;
import org.javalite.activejdbc.annotations.IdName;

/**
 * 
 */
@BelongsTo(parent = Rarity.class, foreignKeyName = "rarity")
@IdName("multiverseid")
public class Card extends Model {
}
