package mobiletDAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashMap;
import java.util.List;
import java.util.Optional;

import Entity.Product;
import java.util.function.Consumer;
import java.util.logging.Level;
import java.util.logging.Logger;
import mobilet_controller.MobiletSystem;

public class ProductDAO {

    private Optional<String> nullOpt = Optional.ofNullable(null);

    public List<Product> getProducts(Optional<String> pid, Optional<String> pType, Optional<String> pSubtype, Optional<Boolean> bestProduct) {
        String sql = "";
        List<Product> result = new ArrayList<>();
        try (Connection conn = MobiletSystem.connectDB()) {
            sql = "SELECT products.id, products.product_name, products.img, subtypes.type, subtypes.subtype FROM `products` JOIN `subtypes` ON products.subtype = subtypes.id";
            boolean setOpt = false;
            if (pid.isPresent()) {
                if (!setOpt) {
                    sql += " where products.id= ? ";
                } 
                setOpt = true;
            }
            if (pType.isPresent()) {
                if (!setOpt) {
                    sql += " where subtypes.type= ? ";
                } else {
                    sql += " AND subtypes.type= ? ";
                }
                setOpt = true;
            }
            
            if (pSubtype.isPresent()) {
                if (!setOpt) {
                    sql += " where subtypes.subtype= ? ";
                } else {
                    sql += " AND subtypes.subtype= ? ";
                }
                setOpt = true;
            }
            if (bestProduct.isPresent() && bestProduct.get()) {
                String wsql = "products.id in "
                        + "(SELECT min(products.id) "
                        + "from products join subtypes ON products.subtype = subtypes.id "
                        + "group BY type)";
                if (!setOpt) {
                    sql += " where " + wsql;
                } else {
                    sql += " AND " + wsql;
                }
                setOpt = true;
            }

            sql += ";";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                int i = 1;
                if (pid.isPresent()) {
                    stmt.setString(i++, pid.get());
                }
                if (pType.isPresent()) {
                    stmt.setString(i++, pType.get());
                }
                if (pSubtype.isPresent()) {
                    stmt.setString(i++, pSubtype.get());
                }                
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        int id = rs.getInt("id");
                        String productName = rs.getString("product_name");
                        String img = rs.getString("img");
                        String type = rs.getString("type");
                        String subtype = rs.getString("subtype");
                        HashMap<String, String> titles = getTitles(id);
                        String about = getAbout(id);
                        String expertabout = getExpertAbout(id);
                        Product product = new Product(id, productName, type, subtype, img, titles, about, expertabout);
                        HashMap<String, List<String>> quantities = getQuantities(id);
//						System.out.println(id + " has # q:" + quantities.size());
                        for (String qname : quantities.keySet()) {
                            String a = quantities.get(qname).get(0);
                            String b = quantities.get(qname).get(1);
                            String c = quantities.get(qname).get(2);
                            product.setQuantities(qname, a, b, c);
                        }
                        HashMap<String, ArrayList<ArrayList<String>>> features = getFeatures(id);
                        for (String fname : features.keySet()) {
                            ArrayList<ArrayList<String>> a = features.get(fname);
                            product.setFeatureCollection(fname, a);
                        }
                        product.setComments(getComments(id));
                        result.add(product);
                    }
                }
            }
        } catch (SQLException e) {
            MobiletSystem.error("getProducts:" + e.getMessage());
            MobiletSystem.error("sql:" + sql);
            return new ArrayList<>();
        }
        MobiletSystem.error("number of product:" + result.size());
        if(result.isEmpty()){
            MobiletSystem.error("sql:" + sql);
        }
        return result;
    }

    private ArrayList<HashMap<String, String>> getComments(int productId) {
        // TODO Auto-generated method stub
        ArrayList<HashMap<String, String>> result = new ArrayList<>();
        try (Connection conn = MobiletSystem.connectDB()) {
            String sql = "SELECT * FROM `comments` JOIN `users` ON `comments`.`uid`=`users`.`id` WHERE pid = ?;";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, productId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        HashMap<String, String> comment = new HashMap<>();
                        String name = rs.getString("name") + rs.getString("family");
                        String text = rs.getString("message");
                        Double rate = rs.getDouble("rate");
                        comment.put("name", name);
                        comment.put("text", text);
                        comment.put("rate", rate.toString());
                        result.add(comment);
                    }
                }
            }
        } catch (SQLException e) {
            MobiletSystem.error("getComments" + e.getMessage());
            return new ArrayList<>();
        }

        return result;
    }

    private String getExpertAbout(int productId) {
        // TODO Auto-generated method stub
        String about = "";
        try (Connection conn = MobiletSystem.connectDB()) {
            String sql = "SELECT * FROM `tests` WHERE pid = ?;";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, productId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        about = rs.getString("test");
                    }
                }
            }
        } catch (SQLException e) {
            MobiletSystem.error("getExpertAbout:" + e.getMessage());
            return "";
        }

        return about;
    }

    private String getAbout(int productId) {
        // TODO Auto-generated method stub
        String about = "";
        try (Connection conn = MobiletSystem.connectDB()) {
            String sql = "SELECT * FROM `abouts` WHERE pid = ?;";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, productId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        about = rs.getString("about");
                    }
                }
            }
        } catch (SQLException e) {
            MobiletSystem.error("getAbout:" + e.getMessage());
            return "";
        }

        return about;
    }

    private HashMap<String, ArrayList<ArrayList<String>>> getFeatures(int productId) {
        // TODO Auto-generated method stub
        ArrayList<ArrayList<String>> newF;
        HashMap<String, ArrayList<ArrayList<String>>> features = new HashMap<>();
        try (Connection conn = MobiletSystem.connectDB()) {
            String sql = "SELECT * FROM `features` WHERE pid = ? order by featureType;";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, productId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        ArrayList<String> f;
                        String featureName = rs.getString("featureName");
                        String featureValue = rs.getString("featureValue");
                        String featureDescription = rs.getString("featureDescription");
                        if (features.getOrDefault(featureName, null) == null) {
                            newF = new ArrayList<>();
                        } else {
                            newF = features.get(featureName);
                        }
                        f = new ArrayList<>(Arrays.asList(featureDescription, featureValue));

                        newF.add(f);
                        features.put(featureName, newF);
                    }
                }
            }
        } catch (SQLException e) {
            MobiletSystem.error("getFeatures:" + e.getMessage());
            return new HashMap<>();
        }

        return features;
    }

    private HashMap<String, String> getTitles(int productId) {
        HashMap<String, String> titles = new HashMap<>();

        try (Connection conn = MobiletSystem.connectDB()) {
            String sql = "SELECT * FROM `titles` WHERE pid = ?;";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, productId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        String persian = rs.getString("persian");
                        titles.put("persian", persian);
                        String english = rs.getString("english");
                        titles.put("english", english);
                    }
                }
            }
        } catch (SQLException e) {
            MobiletSystem.error("getTitles:" + e.getMessage());
            return new HashMap<>();
        }

        return titles;
    }

    private HashMap<String, List<String>> getQuantities(int productId) {
        HashMap<String, List<String>> twoDArrayList = new HashMap<String, List<String>>();
        List<String> keys = Arrays.asList("garenty", "stock", "price", "off");
        try (Connection conn = MobiletSystem.connectDB()) {
            String sql = "SELECT * FROM `quantities` WHERE pid = ?;";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, productId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        keys.forEach((String key) -> {
                            try {
                                String a;
                                a = rs.getString(key);
                                ArrayList<String> explodedStrings = new ArrayList<>();
                                String[] explodedArray = a.split("-");
                                explodedStrings.addAll(Arrays.asList(explodedArray));
                                twoDArrayList.put(key, explodedStrings);
                            } catch (SQLException ex) {
                                Logger.getLogger(ProductDAO.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        });
                    }
                }
            }
        } catch (SQLException e) {
            MobiletSystem.error("getQuantities:" + e.getMessage());
            return new HashMap<>();
        }

        return twoDArrayList;
    }

    public List<Product> getProductsByType(boolean bestProduct, Optional<String> type, Optional<String> subtype) {
        // TODO Auto-generated method stub
        return getProducts(null, type);
    }

    public Product getProductsByID(String pid) {
        // TODO Auto-generated method stub
        List<Product> ps = getProducts(pid);
        return ps.get(0);
    }

    private List<Product> getProducts(Optional<String> pid, Optional<String> type) {
        nullOpt = Optional.ofNullable(null);
        if (pid == null) {
            return getProducts(nullOpt, type, nullOpt, Optional.of(null));
        } else if (type == null) {
            return getProducts(pid, nullOpt, nullOpt, Optional.of(null));
        } else {
            return getProducts(pid, type, nullOpt, Optional.of(null));
        }
    }

    private List<Product> getProducts(String pid) {
        return getProducts(Optional.ofNullable(pid), nullOpt, nullOpt, Optional.ofNullable(null));
    }

    public List<Product> getProductsByTypeAndSubtype(boolean b, String type) {
        return getProducts(nullOpt, Optional.of(type), nullOpt, Optional.of(b));
    }

    public List<Product> getProductsByTypeAndSubtype(boolean b, Optional<String> type, Optional<String> subtype) {
        return getProducts(nullOpt, type, subtype, Optional.of(b));
    }
}
