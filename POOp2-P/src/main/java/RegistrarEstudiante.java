import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet({"/RegistrarEstudiante", "/RegistrarMateria"})
public class RegistrarEstudiante extends HttpServlet {
    private static final long serialVersionUID = 1L;

    public RegistrarEstudiante() {
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath();
        Connection conn = null;
        String url = "jdbc:mysql://localhost:3306/school";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn = DriverManager.getConnection(url, "username", "password");

            if (path.equals("/RegistrarEstudiante")) {
                registrarEstudiante(request, response, conn);
            } else if (path.equals("/RegistrarMateria")) {
                registrarMateria(request, response, conn);
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            response.getWriter().println("Error al registrar.");
        } finally {
            try {
                if (conn != null) {
                    conn.close();
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }

    private void registrarEstudiante(HttpServletRequest request, HttpServletResponse response, Connection conn) throws SQLException, IOException {
        String carnet = request.getParameter("carnet");
        String nombre = request.getParameter("nombre");
        String apellidos = request.getParameter("apellidos");
        String fechaNacimiento = request.getParameter("fechaNacimiento");
        String direccion = request.getParameter("direccion");

        String sql = "INSERT INTO estudents (carnet, nombre, apellidos, fecha_nacimiento, direccion) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, carnet);
        statement.setString(2, nombre);
        statement.setString(3, apellidos);
        statement.setString(4, fechaNacimiento);
        statement.setString(5, direccion);

        int rowsInserted = statement.executeUpdate();
        if (rowsInserted > 0) {
            response.getWriter().println("¡Registro de estudiante exitoso!");
        }
    }

    private void registrarMateria(HttpServletRequest request, HttpServletResponse response, Connection conn) throws SQLException, IOException {
        String codigo = request.getParameter("codigo");
        String nombre = request.getParameter("nombre");
        String descripcion = request.getParameter("descripcion");

        String sql = "INSERT INTO materias (codigo, nombre, descripcion) VALUES (?, ?, ?)";
        PreparedStatement statement = conn.prepareStatement(sql);
        statement.setString(1, codigo);
        statement.setString(2, nombre);
        statement.setString(3, descripcion);

        int rowsInserted = statement.executeUpdate();
        if (rowsInserted > 0) {
            response.getWriter().println("¡Registro de materia exitoso!");
        }
    }
}