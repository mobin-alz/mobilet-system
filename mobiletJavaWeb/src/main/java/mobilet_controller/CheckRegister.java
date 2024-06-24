package mobilet_controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CheckRegister
 */
@WebServlet("/CheckRegister")
public class CheckRegister extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public CheckRegister() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		String name = request.getParameter("name");
		String family = request.getParameter("family");
		String phoneNumber = request.getParameter("phoneNumber");
		String password = request.getParameter("password");

		if (MobiletSystem.addUser(name, family, phoneNumber, password)) {
			request.getSession().setAttribute("user", phoneNumber);
			response.sendRedirect(MobiletSystem.mainURL + "?path=/login&error=5");
		} else {
			response.sendRedirect(MobiletSystem.mainURL + "?path=/register&error=1");
		}
		response.getWriter().append(phoneNumber + "\n" + password);
	}

}
