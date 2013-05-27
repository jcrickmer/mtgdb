package app.util;

import org.javalite.activeweb.AppController;
import org.javalite.activeweb.ControllerFactory;
import org.javalite.activeweb.Router;
import org.javalite.activeweb.freemarker.*;
import freemarker.template.*;

import java.io.Writer;
import java.util.HashMap;
import java.util.Map;

import static org.javalite.common.Util.blank;

/**
 * This is a FreeMarker directive which is registered as  <code>&lt;@controller_link ... /&gt;</code> tag.
 * This tag generates a string that is a link to a controller with params.
 * <p/>
 * Please, see below for attributes and their usage.
 * <p/>
 * <ul>
 * <li> <strong>controller</strong>: path to controller, such as: <code>/admin/permissions</code> where "admin" is a
 * sub-package and "permissions" is a name of a controller. In this example, the controller class name would be:
 * <code>app.controllers.admin.PermissionsController</code>. If a controller path is specified, the preceding slash is mandatory.
 * Optionally this could be a name of a controller from a default package: "permissions", and in this case,
 * the controller class name is expected to be <code>app.controllers.PermissionsController</code>.
 * If a name of controller is specified, the preceding slash can be omitted.
 * This attribute is optional. If this attribute is omitted, the
 * tag will use the controller which was used to generate the current page. This makes it convenient to write links on pages
 * for the same controller.
 * <li> <strong>action</strong>: name of a controller action, not HTML form action. Optional. If this attribute is omitted, the action will default to "index".
 * <li> <strong>id</strong>: id, as in a route: /controller/action/id. Optional.
 * <li> <strong>query_string</strong>: query string as is usually used in GET HTTP calls - the part of a URL
 * after the question mark. Optional. Either query_string or query_params allowed, but not both.
 * <li> <strong>query_params</strong>: java.util.Map with key/value pairs to be converted to query string. Optional.
 * Either query_string or query_params allowed, but not both.
 * </ul>
 * <p/>
 */
public class ControllerLinkTag extends FreeMarkerTag {
    @Override
    protected void render(Map params, String body, Writer writer) throws Exception {

        String controller;
        Boolean restful;
        if (params.get("controller") != null) {
            controller = params.get("controller").toString();
            AppController controllerInstance = (AppController) Class.forName(ControllerFactory.getControllerClassName(controller)).newInstance();
            restful = controllerInstance.restful();
        } else if (get("activeweb") != null) {
            Map activeweb = (Map) getUnwrapped("activeweb");
            controller = activeweb.get("controller").toString();
            restful = (Boolean) activeweb.get("restful");
        } else {
            throw new IllegalArgumentException("link_to directive is missing: 'controller', and no controller found in context");
        }

        if (!controller.startsWith("/")) {
            controller = "/" + controller;
        }

        if (controller.contains(".")) {
            throw new IllegalArgumentException("'controller' attribute cannot have dots in value, use slashes: '/'");
        }

        if (params.get("query_params") != null && params.get("query_string") != null) {
            throw new IllegalArgumentException("Cannot define query_params and query_string. Choose either one or another");
        }

        String action = params.containsKey("action") ? params.get("action").toString() : null;
        String id = blank(params.get("id")) ? null : params.get("id").toString();

        Map queryParams = getQueryParams(params);
        String href = getContextPath();
        href += Router.generate(controller, action, id, restful, queryParams);
        href += params.containsKey("query_string") ? "?" + params.get("query_string") : "";

        writer.write(href);
    }

    private Map getQueryParams(Map params) throws TemplateModelException {


        TemplateHashModelEx modelEx = (TemplateHashModelEx) params.get("query_params");

        if(modelEx == null) return new HashMap();

        TemplateCollectionModel keys = modelEx.keys();
        TemplateModelIterator keysIt = keys.iterator();
        Map queryParams = new HashMap();
        while (keysIt.hasNext()) {
            TemplateModel key = keysIt.next();
            queryParams.put(key.toString(), modelEx.get(key.toString()).toString());
        }
        return queryParams;
    }
}
