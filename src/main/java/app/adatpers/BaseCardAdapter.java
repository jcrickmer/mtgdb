package app.adapters;

import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonWriter;
import com.google.gson.stream.JsonReader;
import java.io.IOException;

import app.models.BaseCard;
import app.models.Type;
import app.models.Subtype;
import app.models.Color;

import java.util.Collection;
import java.util.Iterator;

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

	 writeColorArray(writer, (Collection<Color>) (value.get("color")));
	 writeTypeArray(writer, (Collection<Type>) (value.get("type")));
	 writeSubtypeArray(writer, (Collection<Subtype>) (value.get("subtype")));

	 writer.endObject();
	 return;
     }

     void writeColorArray(JsonWriter writer, Collection<Color> colorList) throws IOException {
	 writer.name("color");
	 writer.beginArray();
	 Iterator<Color> it = colorList.iterator();
	 while (it.hasNext()) {
	     Color cColor = it.next();
	     writer.value(cColor.getString("color"));
	 }
	 writer.endArray();
	 return;
     }

     void writeTypeArray(JsonWriter writer, Collection<Type> typeList) throws IOException {
	 writer.name("type");
	 writer.beginArray();
	 Iterator<Type> it = typeList.iterator();
	 while (it.hasNext()) {
	     Type cType = it.next();
	     writer.value(cType.getString("type"));
	 }
	 writer.endArray();
	 return;
     }

     void writeSubtypeArray(JsonWriter writer, Collection<Subtype> subtypeList) throws IOException {
	 writer.name("subtype");
	 writer.beginArray();
	 Iterator<Subtype> it = subtypeList.iterator();
	 while (it.hasNext()) {
	     Subtype cType = it.next();
	     writer.value(cType.getString("subtype"));
	 }
	 writer.endArray();
	 return;
     }
 }
