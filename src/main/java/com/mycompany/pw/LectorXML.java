package com.mycompany.pw;

import java.io.File;
import java.util.ArrayList;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

/**
 *
 * @author EsthelaHC
 */

public class LectorXML {

    public ArrayList<item> leerMenu(String rutaAbsoluta) {
        ArrayList<item> listaItems = new ArrayList<>();

        try {
            File archivoXML = new File(rutaAbsoluta);
            DocumentBuilderFactory dbFactory = DocumentBuilderFactory.newInstance();
            DocumentBuilder dBuilder = dbFactory.newDocumentBuilder();
            Document doc = dBuilder.parse(archivoXML);

            doc.getDocumentElement().normalize();

            // Obtenemos todos los nodos <item> del documento
            NodeList nList = doc.getElementsByTagName("item");

            for (int i = 0; i < nList.getLength(); i++) {
                Node nNode = nList.item(i);

                if (nNode.getNodeType() == Node.ELEMENT_NODE) {
                    Element eElement = (Element) nNode;

                    // Extraemos el texto de las etiquetas <nombre> y <precio>
                    String nombre = eElement.getElementsByTagName("nombre").item(0).getTextContent();
                    double precio = Double.parseDouble(eElement.getElementsByTagName("precio").item(0).getTextContent());

                    // Creamos un objeto ItemMenu y lo añadimos a la lista
                    listaItems.add(new item(nombre, precio));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return listaItems;
    }
}
