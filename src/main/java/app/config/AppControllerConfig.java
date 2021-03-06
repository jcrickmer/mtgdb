/*
Copyright 2009-2010 Igor Polevoy 

Licensed under the Apache License, Version 2.0 (the "License"); 
you may not use this file except in compliance with the License. 
You may obtain a copy of the License at 

http://www.apache.org/licenses/LICENSE-2.0 

Unless required by applicable law or agreed to in writing, software 
distributed under the License is distributed on an "AS IS" BASIS, 
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. 
See the License for the specific language governing permissions and 
limitations under the License. 
*/
package app.config;


import org.javalite.activeweb.AbstractControllerConfig;
import org.javalite.activeweb.AppContext;
import org.javalite.activeweb.controller_filters.DBConnectionFilter;
import org.javalite.activeweb.controller_filters.TimingFilter;
import app.controllers.ExpansionSetsController;
import app.controllers.CardsController;
import app.controllers.CardImageController;

import us.newplatyp.util.Configuration;

/**
 * 
 */
public class AppControllerConfig extends AbstractControllerConfig {

	public static us.newplatyp.util.Configuration config = new us.newplatyp.util.Configuration();

    public void init(AppContext context) {
		config.setProperty("path.output.card","output");
		config.setProperty("path.symbols","symbols");
		config.setProperty("template.definition.filename","input/templates/basic/basic.xml");

        addGlobalFilters(new TimingFilter());
        add(new DBConnectionFilter()).to(ExpansionSetsController.class);
        add(new DBConnectionFilter()).to(CardsController.class);
        add(new DBConnectionFilter()).to(CardImageController.class);
    }
}
