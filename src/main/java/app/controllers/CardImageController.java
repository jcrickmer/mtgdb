package app.controllers;

import org.javalite.activeweb.AppController;
import java.awt.image.BufferedImage;
import javax.imageio.ImageIO;
import java.awt.Graphics2D;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.io.IOException;
import us.newplatyp.util.Configuration;


/**
 * @author Igor Polevoy
 */
public class CardImageController extends AppController {
    public void index() {

		String mid_s = this.param("multiverseid");
		int mid = 0;
		try {
			mid = Integer.parseInt(mid_s);
		} catch (NullPointerException npe) {
			view("message", npe.toString());
            render("/system/404");
		} catch (NumberFormatException pe) {
			view("message", pe.toString());
            render("/system/404");
		}
		try {
			/*
			File ttt = new File("this_is_to_see_where_i_am.txt");
			FileOutputStream ttto = new FileOutputStream(ttt);
			ttto.write("test".getBytes());
			ttto.close();
			*/
			File cif = new File("/tmp/card_image_cache/" + mid + ".png");
			if (cif.exists()) {
				// use the one from cache!
				//File file = new File("/home/jason/projects/mtgdb/src/main/templates/basic/mtg_card_std_colorless_150dpi.png");
				FileInputStream fis = new FileInputStream(cif);
				byte[] b = new byte[(int) cif.length()];
				fis.read(b);
				//Graphics2D ig2 = bi.createGraphics();
				OutputStream out = outputStream("image/png");
				out.write(b);
			} else {
				// we need to make one
				File file = new File("/home/jason/projects/mtgdb/src/main/templates/basic/mtg_card_std_colorless_150dpi.png");
				FileInputStream fis = new FileInputStream(file);
				byte[] b = new byte[(int) file.length()];
				fis.read(b);
				// to the file - REVISIT - this is not threadsafe!
				FileOutputStream fos = new FileOutputStream(cif);
				fos.write(b);
				// to the browser
				OutputStream out = outputStream("image/png");
				out.write(b);
			}
		} catch (IOException ioe) {
			view("message", ioe.toString());
            render("/system/404");
		}
    }
    protected String getContentType() {
		return "image/png";
    }
}
