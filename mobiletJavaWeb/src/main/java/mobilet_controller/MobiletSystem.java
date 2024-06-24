package mobilet_controller;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Entity.Product;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import java.util.Date;
import mobiletDAO.ProductDAO;

import org.apache.commons.text.StringEscapeUtils;

public class MobiletSystem {

    private static Connection conn;
    private static final String DB_URL = "jdbc:mysql://localhost:3306/mobilet";
    private static final String DB_USER = "root";
    private static final String DB_PASSWORD = "";

    private static String username;
    private static String password;
    private static Cookie[] Cookies;
    public static final String mainURL = "/mobiletJavaWeb/index.jsp";
    public static Optional<Object> Null = Optional.ofNullable(null);
    public static String mainPath = "/mobiletJavaWeb/index.jsp?path=/";

    public static Connection connectDB() {
        try {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            // System.out.println("connecting to the database");
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
            return conn;
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return null;
    }

    public static HashMap<String, Object> menu(HttpServletRequest req, HttpServletResponse res) {
        HashMap<String, Object> menu;
        Object session = req.getSession().getAttribute("cart");
        if (session != null) {
            error("session: " + session.toString());
        } else {
            error("no session");
        }
        if (MobiletSystem.isUser(req)) {
            menu = getMenus(Optional.of(1));
            HashMap<String, String> temp_cart = MobiletSystem.has_tempcart(req);
            if (temp_cart != null) {
                MobiletSystem.addtocart(req, temp_cart);
                MobiletSystem.removeTempCart(req);
            }
            HashMap<String, String> carts = MobiletSystem.hasCart(req);
            if (carts != null) {
                int i = MobiletSystem.getCounts(req);
                HashMap<String, Object> cartMenu = (HashMap<String, Object>) menu.get("cart");
                String t = (String) cartMenu.get("title");
                t += String.format("(%s)", i);
                cartMenu.put("title", t);
                menu.put("cart", cartMenu);
            }
            // die('session has been set');
        } else {
            menu = getMenus(Optional.of(0));
        }
        return menu;
    }

    public static Integer getCountInCart(HttpServletRequest req, String pid) {
        Integer t = -1;
        error("getCountInCart: pid: " + pid);
        HashMap<String, String> carts = getCart(req);
        if (carts.containsKey(pid)) {
            String[] info = carts.get(pid).split("-");
            return Integer.valueOf(info[0]);
        }
        return -1;
    }

    public static void removeFromCart(HttpServletRequest req, String pid) {
        HashMap<String, String> cart = getCart(req);
        if (cart.containsKey(pid)) {
            cart.remove(pid);
        } else {
            error(pid + " is not in cart[session]");
        }
    }

    public static HashMap<String, String> getRequests(HttpServletRequest req) {
        HashMap<String, String> carts = getCart(req);
        HashMap<String, String> result = new HashMap<>();
        if (carts != null) {
            for (String pid : carts.keySet()) {
                Product p = getProductByID(pid);
                String info = carts.get(pid);
                info += "-" + p.getTitle("persian")+"{"+p.getName()+"}";
                info += "-" + p.getPrice();
                result.put(pid, info);
            }
        }
        return result;
    }

    public static HashMap<String, String> getCart(HttpServletRequest req) {
        // TODO Auto-generated method stub
        return (HashMap<String, String>) req.getSession().getAttribute("cart");
    }

    public static void error(String message) {
        // TODO Auto-generated method stub
        System.err.println("T:" + new Date().toString());
        System.err.println("H: " + message);
    }

    public static Boolean setTempCart(HttpServletRequest req, HashMap<String, String> order) {
        try {
            req.getSession().setAttribute("temp_cart", order);
            return true;
        } catch (Exception e) {
            error("mobilet:setTempCart:error");
        }
        return false;
    }

    public static HashMap<String, String> has_tempcart(HttpServletRequest req) {
        return (HashMap<String, String>) req.getSession().getAttribute("temp_cart");
    }

    public static HashMap<String, String> hasCart(HttpServletRequest req) {
        return (HashMap<String, String>) req.getSession().getAttribute("cart");
    }

    public static Boolean hasCartOfProduct(HttpServletRequest req, String pid) {
        HashMap<String, String> carts = getCart(req);
        if (carts != null) {
            error("has: " + carts.containsKey(pid) + " => " + pid);
            return carts.containsKey(pid);
        } else {
            return false;
        }
    }

    public static void addtocart(HttpServletRequest req, HashMap<String, String> order) {
        // TODO Auto-generated method stub
        if (MobiletSystem.isUser(req)) {
            HashMap<String, String> c = MobiletSystem.hasCart(req);
            if (c == null) {
                c = new HashMap<>();
            }
            for (String ok : order.keySet()) {
                c.put(ok, order.get(ok));
            }
            req.getSession().setAttribute("cart", c);
        } else {
            System.err.println("addtocart:error");
        }

    }

    public static void removeTempCart(HttpServletRequest req) {
        req.getSession().removeAttribute("temp_cart");
    }

    private static void addCart(HttpServletRequest req, Cookie temp_cart) {
        HttpSession sess = req.getSession();
        if (sess.getAttribute("cart") == null) {

        }
        sess.setAttribute("cart", temp_cart);
    }

    private static Object hasSessionName(HttpServletRequest req, String string) {
        // TODO Auto-generated method stub
        return req.getSession().getAttribute(string);
    }

    private static Cookie hasCookieName(HttpServletRequest req, String c_name) {
        Cookies = req.getCookies();
        for (int i = 0; i < Cookies.length; i++) {
            Cookie c = Cookies[i];
            if (c.getName().equals(c_name)) {
                return c;
            }
        }
        return null;
    }

    public static int mustLogin(HttpServletRequest req) {
        if (isUser(req)) {
            return 1;
        } else {
            return 0;
        }
    }

    public static HashMap<String, Object> getMenus(Optional<Integer> mustLogin) {
        HashMap<String, Object> result = new HashMap<String, Object>();

        try (Connection conn = MobiletSystem.connectDB(); Statement stmt = conn.createStatement()) {
            String mainSql = "SELECT m1.title, m1.name, m2.name AS pname FROM menus m1 LEFT JOIN menus m2 ON m1.parentId=m2.id";
            String sql;
            if (mustLogin.isPresent()) {
                sql = mainSql + " WHERE m1.mustLogin = " + mustLogin.get();
            } else {
                sql = mainSql + " WHERE m1.mustLogin IS NULL";
            }

            ResultSet rs = stmt.executeQuery(sql);
            while (rs.next()) {
                HashMap<String, Object> nestedList = new HashMap<>();
                HashMap<String, Object> submenu = new HashMap<>();
                HashMap<String, Object> menuItem = new HashMap<>();
                HashMap<String, Object> newItem = new HashMap<>();
                HashMap<String, Object> subItem = new HashMap<String, Object>();
                String title = rs.getString("title");
                String name = rs.getString("name");
                String pname = rs.getString("pname");

                if (pname == null) {
                    nestedList.put("title", title);
                    result.put(name, nestedList);
                } else {
                    if (result.containsKey(pname)) {
                        nestedList = (HashMap<String, Object>) result.get(pname);
                        newItem.put("title", title);
                        if (nestedList.getOrDefault("sub", null) == null) {
                            subItem = new HashMap<String, Object>();
                        } else {
                            subItem = (HashMap<String, Object>) nestedList.get("sub");
                        }
                        subItem.put(name, newItem);
                        nestedList.put("sub", subItem);
                        result.put(pname, nestedList);
                    } else {
                        for (String subName : result.keySet()) {
                            submenu = (HashMap<String, Object>) result.get(subName);
                            subItem = (HashMap<String, Object>) submenu.get("sub");
                            if (subItem == null) {
                                continue;
                            }
                            for (String k : subItem.keySet()) {
                                HashMap<String, Object> item = (HashMap<String, Object>) subItem.get(k);
                                if (item.containsKey(pname)) {
                                    nestedList = (HashMap<String, Object>) item.get(pname);
                                    newItem.put("title", title);
                                    if (nestedList.getOrDefault("sub", null) == null) {
                                        subItem = new HashMap<String, Object>();
                                    } else {
                                        subItem = (HashMap<String, Object>) nestedList.get("sub");
                                    }
                                    item.put(pname, nestedList);
                                    subItem.put(name, item);
                                    break;
                                }

                            }
                            submenu.put("sub", subItem);
                            result.put(subName, submenu);
                        }
                    }
                }

            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        if (mustLogin.isPresent()) {
            Map<String, Object> additionalMenus = getMenus(Optional.ofNullable(null));
            result.putAll(additionalMenus);
        }
        return result;
    }

    public static String showMenu(HashMap<String, Object> menu, Optional<String> parentMenu) {
        String pp;
        HashMap<String, Object> menuItem;
        StringBuilder result;

        result = new StringBuilder("<ul>");
        if (menu.getOrDefault("sub", null) != null) {
            menu = (HashMap<String, Object>) menu.get("sub");
        }
        for (String key : menu.keySet()) {
            if (key == "title" || key == "sub") {
                continue;
            }

            if (parentMenu.isPresent()) {
                pp = parentMenu.get() + "/" + key;
            } else {
                pp = mainPath + key;
            }

            menuItem = (HashMap<String, Object>) menu.get(key);
            result.append("<li><a href='").append(pp).append("'>").append(menuItem.get("title")).append("</a>");

            if (menuItem.getOrDefault("sub", null) != null) {
                result.append(MobiletSystem.showMenu(menuItem, Optional.ofNullable(pp)));
            }
            result.append("</li>");
        }

        result.append("</ul>");

        return result.toString();

    }

    private static boolean checkUser() {
        try {
            Connection c = MobiletSystem.connectDB();
            if (c != null) {
                Statement stmt = c.createStatement();
                String query = "SELECT * FROM users WHERE phone = '" + username + "' AND password = '" + password + "'";
                ResultSet rs = stmt.executeQuery(query);
                if (rs.next()) {
                    return true;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
//		System.err.print("*********error");
        return false;
    }

    public static boolean checkUser(String phoneNumber, String pass) {
        // TODO Auto-generated method stub
        username = phoneNumber;
        password = pass;
        return checkUser();
    }

    public static boolean isUser(HttpServletRequest req) {
        error("user is " + req.getSession().getAttribute("user"));
        if (req.getSession().getAttribute("user") != null) {
            return true;
        }

        return false;
    }

    public static boolean addUser(String name, String family, String username, String password) {
        try {
            Connection c = MobiletSystem.connectDB();
            if (c != null) {
                Statement stmt = c.createStatement();
                String query = "INSERT INTO users (name,family,phone, password) values ('" + name + "', '" + family
                        + "', '" + username + "', '" + password + "')";
                stmt.execute(query);
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public static String formatPrice(double number) {

        number = Math.floor(number);
        return String.format("%.1f", number);
    }

    public static Product getProductByID(String pid) {
        ProductDAO p = new ProductDAO();
        return p.getProductsByID(pid);
    }

    private static int getCounts(HttpServletRequest req) {
        HashMap<String, String> carts = getCart(req);
        return carts.keySet().size();
    }

    public void getC() {
        Product p = new Product(mainURL, username, DB_URL, DB_USER, DB_PASSWORD, null);
        ArrayList<HashMap<String, String>> comments = p.getComments();
        for (HashMap<String, String> comment : comments) {
            String name = comment.get("name");
            String text = comment.get("text");
            Double rate = Double.valueOf(comment.get("rate"));
        }
    }

    public static List<Product> getBestProduct(String type) {
        ProductDAO p = new ProductDAO();
        return p.getProductsByTypeAndSubtype(true, type);

    }

    public static List<Product> getProductsByTypeAndSubType(String stype, String ssubtype) {
        error("subtype is:" + ssubtype);
        Optional<String> subtype = Optional.ofNullable(ssubtype);
        Optional<String> type = Optional.ofNullable(stype);
        return getProductsByTypeAndSubType(type, subtype);
    }

    public static List<Product> getProductsByTypeAndSubType(Optional<String> type, Optional<String> subtype) {
        ProductDAO p = new ProductDAO();
        return p.getProductsByTypeAndSubtype(false, type, subtype);
    }
}
