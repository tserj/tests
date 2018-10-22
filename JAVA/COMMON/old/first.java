import java.awt.BorderLayout;
import java.awt.CheckboxGroup;
import java.awt.Container;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.GraphicsEnvironment;
import java.awt.GridBagConstraints;
import java.awt.GridBagLayout;
import java.awt.GridLayout;
import java.awt.Insets;
import java.awt.Toolkit;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.ItemEvent;
import java.awt.event.ItemListener;
import java.awt.event.WindowAdapter;
import java.awt.event.WindowEvent;
import java.awt.image.BufferedImage;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.util.StringTokenizer;

import javax.swing.*;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageDecoder;

public final class first extends JPanel {
	private final JFrame parent;
	private JDialog Dialog;

	///private String text;

	public first()
	{
	}

	public static void main(String argv[]) {
		///text = "hello world!";

		final JFrame parent = new JFrame("Test");

		///Dialog = new JDialog(parent, "Text", false);
		///Dialog.pack();
		///Dialog.show();
		parent.pack();
		parent.show();
	}
}