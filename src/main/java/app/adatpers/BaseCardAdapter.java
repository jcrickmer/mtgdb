package app.adapters;

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonWriter;
import com.google.gson.stream.JsonReader;
import java.io.IOException;

import app.models.BaseCard;

/**
 * Turns a BaseCard into a JSON string.
 */
public class BaseCardAdapter extends TypeAdapter<BaseCard> {

     public BaseCard read(JsonReader reader) throws IOException {
	 /* not implemented yet.
	 if (reader.peek() == JsonToken.NULL) {
	     reader.nextNull();
	     return null;
	 }
	 String xy = reader.nextString();
	 String[] parts = xy.split(",");
	 int x = Integer.parseInt(parts[0]);
	 int y = Integer.parseInt(parts[1]);
	 return new Point(x, y);
	 */
	 return new BaseCard();
     }

     public void write(JsonWriter writer, BaseCard value) throws IOException {
	 if (value == null) {
	     writer.nullValue();
	     return;
	 }
	 writer.beginObject();
	 //writer.name("multiserverid").value(value.getInteger("multiverseid"));
	 writer.name("name").value(value.getString("name"));
	 writer.name("power").value(value.getString("power"));
	 writer.name("toughness").value(value.getString("toughness"));
	 writer.name("loyalty").value(value.getString("loyalty"));
	 writer.name("rules_text").value(value.getString("rules_text"));
	 writer.name("mana_cost").value(value.getString("mana_cost"));
	 writer.name("cmc").value(value.getString("cmc"));
	 writer.endObject();
	 return;
     }
 }