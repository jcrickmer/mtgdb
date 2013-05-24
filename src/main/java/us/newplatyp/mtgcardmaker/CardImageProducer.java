package us.newplatyp.mtgcardmaker;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Font;
import java.awt.FontMetrics;
import java.awt.GradientPaint;
import java.awt.Graphics2D;
import java.awt.RenderingHints;
import java.awt.geom.Ellipse2D;
import java.awt.geom.Rectangle2D;
import java.awt.image.BufferedImage;
import java.util.*;
import java.io.File;
import java.io.IOException;
import java.awt.*;
import java.awt.geom.*;
import java.awt.image.*;
import javax.swing.*;
import javax.swing.text.*;
import javax.swing.text.html.*;

import javax.imageio.ImageIO;
import javax.imageio.IIOImage;
import javax.imageio.metadata.IIOMetadata;
import javax.imageio.metadata.IIOMetadataNode;
import javax.imageio.metadata.IIOInvalidTreeException;
import javax.imageio.stream.ImageOutputStream;
import javax.imageio.ImageTypeSpecifier;
import javax.imageio.ImageWriteParam;
import javax.imageio.ImageWriter;

import us.newplatyp.framework.MainProgram;
import us.newplatyp.util.Configuration;

public class CardImageProducer {

    private MainProgram master;
    private String symbolsPath;
    private TemplateSet tset;

    public CardImageProducer(MainProgram master, TemplateSet tset) {
	this.master = master;
	this.tset = tset;

	File symbDir = new File(this.master.getConfiguration().getProperty("path.symbols","symbols"));
	this.symbolsPath = symbDir.getAbsolutePath();

    }

    public void produce(Card card) throws IOException {
	System.out.println("Making \"" + card.getTitle() + "\".");		
		BufferedImage bi = loadBackgroundImage(card);

		int dpi = 150;
		int width = 5 * dpi / 2;
		int height = 7 * dpi / 2;

		Graphics2D ig2 = bi.createGraphics();
		ig2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
		ig2.setRenderingHint(RenderingHints.KEY_DITHERING, RenderingHints.VALUE_DITHER_ENABLE);
		ig2.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
		ig2.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);

		// Title
		if (card.getTitle() != null) {
			Font font = new Font("Times", Font.BOLD, 18);
			ig2.setFont(font);
			String message = card.getTitle();
			//FontMetrics fontMetrics = ig2.getFontMetrics();
			//int stringWidth = fontMetrics.stringWidth(message);
			//int stringHeight = fontMetrics.getAscent();
			ig2.setPaint(Color.black);
			// CENTER //ig2.drawString(message, (width - stringWidth) / 2, height / 2 + stringHeight / 4);
			ig2.drawString(message, 34, 49);
		}

		// Cost
		{
			java.util.List manaList = card.getManaList();
			int end = 340;
			int symbCount = manaList.size();
			ListIterator it = card.getManaList().listIterator();
			Mana mana;
			int add = end - (symbCount * 17);
			while (it.hasNext()) {
				mana = (Mana)(it.next());
				try {
					File manaImage_F = new File(this.symbolsPath + "/" + mana.getSymbolFilename());
					//System.err.println("File: " + manaImage_F.getName());
					BufferedImage manaImage = ImageIO.read(manaImage_F);
					ig2.drawImage(manaImage, add, 36, null);
				} catch (IOException ioe) {
					ioe.printStackTrace();
				}
				add = add + 17;
			}
		}

		// image
		if (card.getImageURI() != null) {
		    try {
			int viewportWidth = 313;
			int viewportHeight = 246;
			BufferedImage cardImage = ImageIO.read(new File(card.getImageURI()));
			float yScale = (float)viewportHeight / (float)(cardImage.getHeight());
			float xScale = (float)viewportWidth / (float)(cardImage.getWidth());
			BufferedImage after = new BufferedImage(viewportWidth, viewportHeight, BufferedImage.TYPE_INT_ARGB);
			AffineTransform at = new AffineTransform();
			//System.out.println("scaling to " + yScale + " x " + xScale);
			at.scale(Math.max(yScale, xScale),Math.max(yScale, xScale));
			AffineTransformOp scaleOp = new AffineTransformOp(at, AffineTransformOp.TYPE_BILINEAR);
			after = scaleOp.filter(cardImage, after);

			ig2.drawImage(after, 32, 57, null);
		    } catch (IOException ioe) {
			System.err.println("For card " + card.getTitle() + ", unable to read in image " + card.getImageURI());
		    }
		}

		// Type
		{
			Font font = new Font("Times", Font.BOLD, 14);
			ig2.setFont(font);
			StringBuffer message = new StringBuffer(card.getType());
			if (card.getSubtype() != null && ! card.getSubtype().equals("")) {
				message.append(" \u2014 ");
				message.append(card.getSubtype());
			}
			FontMetrics fontMetrics = ig2.getFontMetrics();
			int stringWidth = fontMetrics.stringWidth(message.toString());
			int stringHeight = fontMetrics.getAscent();
			ig2.setPaint(Color.black);
			// CENTER //ig2.drawString(message, (width - stringWidth) / 2, height / 2 + stringHeight / 4);
			ig2.drawString(message.toString(), 34, 323);
		}

		// Artist
		{
			Font font = new Font("Times", Font.BOLD, 12);
			ig2.setFont(font);
			String message = card.getArtist();
			if (message == null) {
			    message = "Unknown";
			}
			FontMetrics fontMetrics = ig2.getFontMetrics();
			int stringWidth = fontMetrics.stringWidth(message.toString());
			int stringHeight = fontMetrics.getAscent();
			ig2.setPaint(Color.black);
			// CENTER //ig2.drawString(message, (width - stringWidth) / 2, height / 2 + stringHeight / 4);
			ig2.drawString(message.toString(), 66, 494);
		}

		// Text
		try {
			StringBuffer message = new StringBuffer();
			message.append(card.getTextAsHTML(this.symbolsPath));
			String ft = card.getFlavorText();
			if (ft != null && ! ft.equals("")) {
				if (message.length() > 0) {
					message.append("\n<br/><br/>\n");
				}
				message.append("<i>");
				message.append(ft);
				message.append("</i>");
			}
			System.out.println(message.toString());
			System.out.println("=========================");
			BufferedImage textBI = new BufferedImage(300, 300, BufferedImage.TYPE_INT_ARGB);
			Graphics2D tig2 = textBI.createGraphics();
			tig2.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
			tig2.setRenderingHint(RenderingHints.KEY_DITHERING, RenderingHints.VALUE_DITHER_ENABLE);
			tig2.setRenderingHint(RenderingHints.KEY_FRACTIONALMETRICS, RenderingHints.VALUE_FRACTIONALMETRICS_ON);
			tig2.setRenderingHint(RenderingHints.KEY_INTERPOLATION, RenderingHints.VALUE_INTERPOLATION_BICUBIC);

			//JTextPane textPane = new JTextPane(doc);
			JEditorPane textPane = new JEditorPane("text/html", message.toString());
			//System.out.println("000: " + textPane.getPreferredSize());
			textPane.getPreferredSize();
			textPane.setSize(300, 129);
			//System.out.println("100: " + textPane.getPreferredSize());
			textPane.getPreferredSize();
			textPane.setBackground(new Color(0,0,0,0));
			textPane.paint(tig2);

			ig2.drawImage(textBI, 38, 337, null);
		} catch (Exception eee) {
			eee.printStackTrace();
		}

		// Loyalty
		if (card.getType().equals("Planeswalker")) {
			Font font = new Font("Times", Font.BOLD, 17);
			ig2.setFont(font);
			System.out.println("HHH" + card.getLoyalty());
			String message = "" + card.getLoyalty();
			//FontMetrics fontMetrics = ig2.getFontMetrics();
			//int stringWidth = fontMetrics.stringWidth(message);
			//int stringHeight = fontMetrics.getAscent();
			ig2.setPaint(Color.black);
			// CENTER //ig2.drawString(message, (width - stringWidth) / 2, height / 2 + stringHeight / 4);
			ig2.drawString(message, 325, 483);
		}

		// Power and Toughness
		if (card.getType().contains("Creature")) {
			Font font = new Font("Times", Font.BOLD, 16);
			ig2.setFont(font);
			String message = "" + card.getPower() + " / " + card.getToughness();
			//FontMetrics fontMetrics = ig2.getFontMetrics();
			//int stringWidth = fontMetrics.stringWidth(message);
			//int stringHeight = fontMetrics.getAscent();
			ig2.setPaint(Color.black);
			// CENTER //ig2.drawString(message, (width - stringWidth) / 2, height / 2 + stringHeight / 4);
			ig2.drawString(message, 318, 483);
		}

		// wite it out...
		File outputFile = new File(this.master.getConfiguration().getProperty("path.output.card",".") + "/" + card.getTitle() + ".png");
		/*
                ImageIO.write(bi, "PNG", outputFile);
		//ImageIO.write(bi, "JPEG", new File("yourImageName.JPG"));
		//ImageIO.write(bi, "gif", new File("yourImageName.GIF"));
		*/

        outputFile.delete();
	String formatName = "png";

	for (Iterator<ImageWriter> iw = ImageIO.getImageWritersByFormatName(formatName); iw.hasNext();) {
	    ImageWriter writer = iw.next();
	    ImageWriteParam writeParam = writer.getDefaultWriteParam();
	    ImageTypeSpecifier typeSpecifier = ImageTypeSpecifier.createFromBufferedImageType(BufferedImage.TYPE_INT_RGB);
	    IIOMetadata metadata = writer.getDefaultImageMetadata(typeSpecifier, writeParam);
	    if (metadata.isReadOnly() || !metadata.isStandardMetadataFormatSupported()) {
		continue;
	    }
		    
	    setDPI(metadata);

	    final ImageOutputStream stream = ImageIO.createImageOutputStream(outputFile);
	    try {
		writer.setOutput(stream);
		writer.write(metadata, new IIOImage(bi, null, metadata), writeParam);
	    } finally {
		stream.close();
	    }
	    break;
	}
    }


    private BufferedImage loadBackgroundImage(Card card) throws IOException {
	// TYPE_INT_ARGB specifies the image format: 8-bit RGBA packed
	// into integer pixels
	//BufferedImage bi = new BufferedImage(width, height, BufferedImage.TYPE_INT_ARGB);
	BufferedImage bi = null;
	Template temp = this.tset.get(card.getType(), card.getManaList());
	bi = ImageIO.read(new File(temp.getFilename()));

	return bi;
    }

    /**
     * from http://stackoverflow.com/questions/321736/how-to-set-dpi-information-in-an-image
     */
    private void setDPI(IIOMetadata metadata) throws IIOInvalidTreeException {
	int dpi = 150;
	int width = 5 * dpi / 2;
	int height = 7 * dpi / 2;
	// for PNG, it's dots per millimeter
	double INCH_2_CM = 2.54;
	double dotsPerMilli = 1.0 * dpi / 10 / INCH_2_CM;



	IIOMetadataNode horiz = new IIOMetadataNode("HorizontalPixelSize");
	horiz.setAttribute("value", Double.toString(dotsPerMilli));

	IIOMetadataNode vert = new IIOMetadataNode("VerticalPixelSize");
	vert.setAttribute("value", Double.toString(dotsPerMilli));

	IIOMetadataNode dim = new IIOMetadataNode("Dimension");
	dim.appendChild(horiz);
	dim.appendChild(vert);
	
	IIOMetadataNode root = new IIOMetadataNode("javax_imageio_1.0");
	root.appendChild(dim);

	metadata.mergeTree("javax_imageio_1.0", root);
    }
}
