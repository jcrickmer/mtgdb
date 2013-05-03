package us.newplatyp.mtg;

import java.util.Set;
import java.util.HashMap;
import java.util.Map;

public class Symbols {

    public static Set<String> symbols;

    public static Map<String,Integer> symbolValues;

    static {
	symbolValues = new HashMap();
	symbolValues.put("w", new Integer(1));
	symbolValues.put("u", new Integer(1));
	symbolValues.put("b", new Integer(1));
	symbolValues.put("r", new Integer(1));
	symbolValues.put("g", new Integer(1));
	symbolValues.put("0", new Integer(0));
	symbolValues.put("1", new Integer(1));
	symbolValues.put("2", new Integer(2));
	symbolValues.put("3", new Integer(3));
	symbolValues.put("4", new Integer(4));
	symbolValues.put("5", new Integer(5));
	symbolValues.put("6", new Integer(6));
	symbolValues.put("7", new Integer(7));
	symbolValues.put("8", new Integer(8));
	symbolValues.put("9", new Integer(9));
	symbolValues.put("10", new Integer(10));
	symbolValues.put("11", new Integer(11));
	symbolValues.put("12", new Integer(12));
	symbolValues.put("13", new Integer(13));
	symbolValues.put("14", new Integer(14));
	symbolValues.put("15", new Integer(15));
	symbolValues.put("x", new Integer(0));
	symbolValues.put("w/p", new Integer(1));
	symbolValues.put("u/p", new Integer(1));
	symbolValues.put("b/p", new Integer(1));
	symbolValues.put("r/p", new Integer(1));
	symbolValues.put("g/p", new Integer(1));
	symbolValues.put("w/u", new Integer(1));
	symbolValues.put("w/b", new Integer(1));
	symbolValues.put("u/b", new Integer(1));
	symbolValues.put("u/r", new Integer(1));
	symbolValues.put("b/r", new Integer(1));
	symbolValues.put("b/g", new Integer(1));
	symbolValues.put("r/g", new Integer(1));
	symbolValues.put("r/w", new Integer(1));
	symbolValues.put("g/w", new Integer(1));
	symbolValues.put("g/u", new Integer(1));
	symbolValues.put("2/w", new Integer(2));
	symbolValues.put("2/u", new Integer(2));
	symbolValues.put("2/b", new Integer(2));
	symbolValues.put("2/r", new Integer(2));
	symbolValues.put("2/g", new Integer(2));

	symbols = symbolValues.keySet();
    }
}
