package com.websocket;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/login")
public class UserServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	static RequestDispatcher rd;
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");
		PrintWriter printWriter=response.getWriter();

		HttpSession session=request.getSession(true);
		String username=request.getParameter("username").toLowerCase();
		session.setAttribute("username",username);

		if(username!=null )
		{
			if(username.equals("doctor"))
			{
				request.setAttribute("data",username);
				rd=request.getRequestDispatcher("/doctor.jsp");
				rd.forward(request,response);
			}
			else if(username.equals("ambulance"))
			{
				request.setAttribute("data",username);
				rd=request.getRequestDispatcher("/ambulance.jsp");
				rd.forward(request, response);
			}
			else
			{
				request.setAttribute("data", username);
				rd=request.getRequestDispatcher("/patient.jsp");
				rd.forward(request, response);
			}
		}
	}
}