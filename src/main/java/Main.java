import Clients.NPRClientReader;
import Models.Users;
import org.hibernate.Session;
import org.hibernate.Transaction;
import Clients.NPRClientReader.*;
import org.xml.sax.SAXException;

import javax.xml.parsers.ParserConfigurationException;
import java.io.IOException;
import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Stream;

import static Clients.NPRClientReader.parseXml;

public class Main {
    static final String GENRE = "Rock";

    public static void main(String[] args) throws IOException, SAXException, ParserConfigurationException {

        System.out.println("Fetching Genres from API...\n");
        List<String> genres = parseXml();

        System.out.println("Running queries on Database...\n");

        Session session = HibernateConfig.getSessionFactory().openSession();
        if (session.isOpen()) {
            System.out.println("Session Connected...");
        }
        Transaction transaction = null;

        try {
            transaction = session.beginTransaction();

            System.out.println("From DB query, Stream users:");
            Stream<Users> stream1 = session.createQuery("select u from Users u").stream();
            stream1.map(users -> "Id: " + users.getId() + "\nName: " + users.getFirstName() + "\nFavorite genre:" + users.getFavoriteGenre())
                    .forEach(users -> { System.out.println(users); });

            String genreFromAPI = genres.get(genres.size() - 2);

            System.out.printf("Searching for: " + genres.get(genres.size() - 2));

            System.out.println("Using Stream filter users with favorite genre matching: " + genreFromAPI);
            Stream<Users> streamFilter = session.createQuery("select u from Users u").stream();
            streamFilter.filter(users -> users.getFavoriteGenre().equals(genreFromAPI))
                        .map(users -> "Id: " + users.getId() + "\nName: " + users.getFirstName() + "\nFavorite genre:" + users.getFavoriteGenre())
                        .forEach(users -> { System.out.println(users); });

            transaction.commit();
        } catch (Exception e) {
            if (transaction != null) {
                transaction.rollback();
            }
        } finally {
            session.close();
        }
    }
}
