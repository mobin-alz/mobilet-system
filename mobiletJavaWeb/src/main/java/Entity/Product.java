package Entity;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.HashMap;
import java.util.Optional;


public class Product {

    int id;
    String name;
    String ptype;
    String subtype;
    String img;
    HashMap<String, String> title;
    ArrayList<String> colors;
    HashMap<String, ArrayList<String>> quantities;
    HashMap<String, ArrayList<ArrayList<String>>> features;
    String about;
    String expertabout;
    ArrayList<HashMap<String, String>> comments;
    Double price;

    public Product(int i, String pName, String t, String s, String im, HashMap<String, String> ts, String a,
	    String ea) {
	id = i;
	name = pName;        
	ptype = t;
	subtype = s;
	img = im;
	title = ts;
	title.put("English", "");
	title.put("Persian", "");
	colors = new ArrayList<String>();
	colors.add("black");
	colors.add("blue");
	colors.add("yellow");
	colors.add("red");
	quantities = new HashMap<String, ArrayList<String>>();
	features = new HashMap<String, ArrayList<ArrayList<String>>>();
	about = a;
	expertabout = ea;
    }

    public Product(String i, String pName, String t, String s, String im, HashMap<String, String> ts) {
	name = pName;
	ptype = t;
	subtype = s;
	img = im;
	title = ts;
	title.put("English", "");
	title.put("Persian", "");
	colors = new ArrayList<String>();
	colors.add("black");
	quantities = new HashMap<String, ArrayList<String>>();
	ArrayList<String> ga = new ArrayList<String>(Arrays.asList("گارانتی", "6", "ماه"));
	quantities.put("garenty", ga);
	ArrayList<String> off = new ArrayList<String>(Arrays.asList("تخفیف", "10", "درصد"));
	quantities.put("off", off);
	ArrayList<String> price = new ArrayList<String>(Arrays.asList("قیمت", "21000000", "تومان"));
	quantities.put("price", price);
	features = new HashMap<String, ArrayList<ArrayList<String>>>();
	features.put("details", new ArrayList<ArrayList<String>>());
    }

    public void setComment(String userName, String Message, Optional<Double> rate) {
	HashMap<String, String> c = new HashMap<String, String>();
	c.put("name", userName);
	c.put("text", Message);
	if (rate.isPresent()) {
	    c.put("rate", rate.get().toString());
	} else {
	    c.put("rate", "5");
	}
	comments.add(c);
    }

    public void setQuantities(String qName, String qTitle, String qValue, String qPostfix) {
	ArrayList<String> newQ = new ArrayList<>(Arrays.asList(qTitle, qValue, qPostfix));
        if("price".equals(qName)){
            price=Double.valueOf(qValue);
        }
	quantities.put(qName, newQ);
//		System.out.println(qName + " has been set for product:" + id);
    }

    public void setFeature(String fName, String fValue, String fDescription) {
	ArrayList<ArrayList<String>> newF;
	ArrayList<String> feature = new ArrayList<String>(Arrays.asList(fDescription, fValue));
	if (features.getOrDefault(fName, null) == null) {
	    newF = new ArrayList<ArrayList<String>>();
	} else {
	    newF = features.get(fName);
	}
	newF.add(feature);
	features.put(fName, newF);
	System.out.println(fName + " has been set for product:" + id);
    }

    public ArrayList<String> getQuantities(String type) {
	return quantities.get(type);
    }

    public HashMap<String, ArrayList<String>> getQuantities() {
	return quantities;
    }

    public String getTitle(String type) {
	return title.get(type);
    }

    public String getSubtype() {
	return subtype;
    }

    public String getType() {
	return ptype;
    }

    public String getID() {
	return String.valueOf(id);
    }

    public String getImg() {
	return img;
    }

    public String getName() {
	return name;
    }

    public String getAbout() {
	return about;
    }

    public String getExpertAbout() {
	return expertabout;
    }

    public ArrayList<String> getColors() {
	return colors;
    }

    public HashMap<String, ArrayList<ArrayList<String>>> getFeatures() {
	return features;
    }

    public ArrayList<ArrayList<String>> getFeature(String type) {
	if (type.equals("main")) {
	    ArrayList<ArrayList<String>> result = new ArrayList<ArrayList<String>>();
	    for (String s : features.keySet()) {
		result.add(features.get(s).get(0));
	    }
	    return result;
	}
	if (features.containsKey(type)) {
	    return features.get(type);
	} else {
	    System.out.println("f1:type " + type + " is not avaiable");
	    return new ArrayList<ArrayList<String>>();
	}
    }

    public ArrayList<ArrayList<String>> getMainFeatures() {
	return getFeature("main");
    }

    public HashMap<String, String> getInfos() {
	HashMap<String, String> result = new HashMap<String, String>();
	if (features.size() > 0) {
	    result.put("details", "ویژگی‌ها");
	}

	if (about != "") {
	    result.put("about", "درباره‌ی محصول");
	}

	if (expertabout != "") {
	    result.put("test", "بررسی تخصصی");
	}

	if (comments.size() > 0) {
	    result.put("commentsBuy", "نظرات");
	}

	return result;
    }

    public void setFeatureCollection(String fname, ArrayList<ArrayList<String>> a) {
	// TODO Auto-generated method stub
	for (ArrayList<String> f : a) {
	    setFeature(fname, f.get(1), f.get(0));
	}
    }

    public void setComments(ArrayList<HashMap<String, String>> comments2) {
	// TODO Auto-generated method stub
	comments = comments2;
    }

    public ArrayList<HashMap<String, String>> getComments() {
	// TODO Auto-generated method stub
	return comments;
    }

    public Double getPrice() {
        return price;
    }

}
