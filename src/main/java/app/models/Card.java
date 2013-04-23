package app.models;

import org.javalite.activejdbc.Model;
import org.javalite.activejdbc.annotations.BelongsTo;

/**
 * 
 */
@BelongsTo(parent = Rarity.class, foreignKeyName = "rarity")
public class Card extends Model {
}
