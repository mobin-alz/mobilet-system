package mobilet_controller;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.codehaus.plexus.util.StringUtils;

/**
 * Servlet implementation class Home
 */
@WebServlet("/index.jsp")
public class Home extends HttpServlet {

    private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Home() {
        super();
        // TODO Auto-generated constructor stub
    }

    /**
     * @param request
     * @param response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        // TODO Auto-generated method stub

        if (request.getParameter("path") == null) {
            request.getRequestDispatcher("/header.jsp").include(request, response);
            request.getRequestDispatcher("/pages/index-p.jsp").include(request, response);
            request.getRequestDispatcher("/footer.jsp").include(request, response);
        } else {
            String path_get = request.getParameter("path");
            String f = "/pages" + path_get + ".jsp";
            String filePath = request.getSession().getServletContext().getRealPath(f);
            Path path = Paths.get(filePath);
            if (Files.exists(path)) {
                request.getRequestDispatcher(f).forward(request, response);
            } else {
                f = "/pages" + path_get + "-p.jsp";
                filePath = request.getSession().getServletContext().getRealPath(f);
                path = Paths.get(filePath);
                if (Files.exists(path)) {
                    request.getRequestDispatcher("/header.jsp").include(request, response);
                    request.getRequestDispatcher(f).include(request, response);
                    request.getRequestDispatcher("/footer.jsp").include(request, response);
                } else {

                    String[] path_parts = path_get.split("/");
                    switch (path_parts.length) {
                        case 2: {
                            String pid = path_parts[1];
                            //                        MobiletSystem.error("pid: "+pid);
                            if (StringUtils.isNumeric(pid)) {
                                request.setAttribute("pid", pid);
                                request.getRequestDispatcher("/header.jsp").include(request, response);
                                request.getRequestDispatcher("/pages/product.jsp").include(request, response);
                                request.getRequestDispatcher("/footer.jsp").include(request, response);
                            } else {
                                request.setAttribute("type", pid);
                                request.getRequestDispatcher("/header.jsp").include(request, response);
                                request.getRequestDispatcher("/pages/products.jsp").include(request, response);
                                request.getRequestDispatcher("/footer.jsp").include(request, response);
                            }
                            break;
                        }
                        case 3: {
                            String pid = path_parts[2];
                            //                        MobiletSystem.error("pid: "+pid);
                            if (StringUtils.isNumeric(pid)) {
                                request.setAttribute("pid", pid);
                                request.getRequestDispatcher("/header.jsp").include(request, response);
                                request.getRequestDispatcher("/pages/product.jsp").include(request, response);
                                request.getRequestDispatcher("/footer.jsp").include(request, response);
                            } else {
                                request.setAttribute("type", path_parts[1]);
                                request.setAttribute("subtype", path_parts[2]);
                                request.getRequestDispatcher("/header.jsp").include(request, response);
                                request.getRequestDispatcher("/pages/products.jsp").include(request, response);
                                request.getRequestDispatcher("/footer.jsp").include(request, response);
                            }
                            break;
                        }
                        case 4: {
                            String pid = path_parts[3];
                            //                        MobiletSystem.error("pid: "+pid);
                            request.setAttribute("pid", pid);
                            request.getRequestDispatcher("/header.jsp").include(request, response);
                            request.getRequestDispatcher("/pages/product.jsp").include(request, response);
                            request.getRequestDispatcher("/footer.jsp").include(request, response);
                            break;
                        }
                        default:
                            response.getWriter().append("page Not found\nServed at: ").append(request.getContextPath())
                                    .append("\npath is: ").append(path.toString()).append("\nparts path is: ")
                                    .append(path_parts[1]);
                            break;
                    }
                }
            }
        }

//		response.getWriter().append("Served at: ").append(request.getContextPath());
    }

    /**
     * @param request
     * @param response
     * @throws javax.servlet.ServletException
     * @throws java.io.IOException
     * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
     * response)
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // TODO Auto-generated method stub
        doGet(request, response);
    }

}
