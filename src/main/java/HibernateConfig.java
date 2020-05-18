
import org.hibernate.*;
import org.hibernate.boot.*;
import org.hibernate.boot.registry.*;

public class HibernateConfig {
   private static final SessionFactory sessionFactory;

        static {
            try {
                StandardServiceRegistry standardRegistry = new
                        StandardServiceRegistryBuilder()
                        .configure("hibernate.cfg.xml")
                        .build();
                Metadata metaData = new MetadataSources(
                        standardRegistry)
                        .getMetadataBuilder()
                        .build();
                sessionFactory = metaData.getSessionFactoryBuilder().build();
            } catch (Throwable th) {
                throw new ExceptionInInitializerError(th);
            }
        }

        public static SessionFactory getSessionFactory() {
            return sessionFactory;

        }
}
