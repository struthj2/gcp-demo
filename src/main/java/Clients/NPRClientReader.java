package Clients;

import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;
import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.net.URL;
import java.net.URLConnection;
import java.util.ArrayList;
import java.util.List;

public class NPRClientReader {
    static final String URL = "http://api.npr.org/list?id=3018";

    public static List<String> parseXml() throws ParserConfigurationException, IOException, SAXException {
        ArrayList<String> genres = new ArrayList<>();
        try {
            URL url = new URL(URL);
            URLConnection conn = url.openConnection();
            System.out.println("Fetch Genres from api at: " + url.toString());

            DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
            DocumentBuilder builder = factory.newDocumentBuilder();
            Document document = builder.parse(conn.getInputStream());

            NodeList genreList = document.getElementsByTagName("item");
            Element element;
            System.out.println("Fetched Genres: ");
            for (int i = 0; i < genreList.getLength(); i++) {
                element = (Element) genreList.item(i);
                NodeList nodeList = element.getElementsByTagName("title");
                System.out.println(nodeList.item(0).getFirstChild().getTextContent());
                genres.add(nodeList.item(0).getFirstChild().getTextContent());
            }
        }
        catch (Exception ex) {
            System.out.printf(ex.toString());
        }
        return genres;
    }
}