package app.util;

import org.javalite.activejdbc.validation.ValidatorAdapter;
import org.javalite.activejdbc.Model;
import app.models.BaseCard;

public class BaseCardValidator { //extends ValidatorAdapter{
    void validate(Model bcard){
	boolean valid = true;
	//perform whatever validation logic, then add errors to model if validation did not pass:

	if (bcard.get("power") != null) {
	    // work to do here...
	}
	//if(!valid)
	//    m.addValidator(this, "custom_error");
    }
}