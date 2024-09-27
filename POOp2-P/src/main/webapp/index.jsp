<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page session="true" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Gestión de Alumnos y Materias</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eceff1;
        }
        h2 {
            color: #37474f;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 20px;
        }
        table, th, td {
            border: 1px solid #ccc;
        }
        th, td {
            padding: 10px;
            text-align: left;
        }
        th {
            background-color: #b0bec5;
        }
        .btn {
            padding: 8px 16px;
            text-decoration: none;
            color: white;
            border-radius: 4px;
            margin: 5px;
            cursor: pointer;
        }
        .btn-primary {
            background-color: #3f51b5;
        }
        .btn-success {
            background-color: #4caf50;
        }
        .btn-warning {
            background-color: #ffeb3b;
            color: black;
        }
        .btn-danger {
            background-color: #f44336;
        }
        .btn:hover {
            opacity: 0.9;
        }
        .form-group {
            margin-bottom: 15px;
            text-align: center;
        }
        label {
            margin-right: 10px;
        }
        input {
            padding: 8px;
            width: 300px;
            margin-bottom: 10px;
            text-align: center;
        }
        form {
            display: flex;
            flex-direction: column;
            align-items: center;
        }
        button {
            width: 320px;
        }
    </style>
</head>
<body>
<div>
    <h2>Alumnos</h2>
    <table>
        <thead>
        <tr>
            <th>Carnet</th>
            <th>Nombre</th>
            <th>Apellidos</th>
            <th>Fecha de Nacimiento</th>
            <th>Dirección</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (session.getAttribute("alumnos") == null) {
                session.setAttribute("alumnos", new ArrayList<String[]>());
            }
            List<String[]> alumnos = (List<String[]>) session.getAttribute("alumnos");

            if (request.getParameter("eliminarAlumno") != null) {
                int index = Integer.parseInt(request.getParameter("eliminarAlumno"));
                alumnos.remove(index);
            }

            if (request.getParameter("carnet") != null) {
                if (request.getParameter("editIndex") != null && !request.getParameter("editIndex").isEmpty()) {
                    int index = Integer.parseInt(request.getParameter("editIndex"));
                    alumnos.set(index, new String[]{
                            request.getParameter("carnet"),
                            request.getParameter("nombre"),
                            request.getParameter("apellidos"),
                            request.getParameter("fechaNacimiento"),
                            request.getParameter("direccion")
                    });
                } else {
                    String[] nuevoAlumno = {
                            request.getParameter("carnet"),
                            request.getParameter("nombre"),
                            request.getParameter("apellidos"),
                            request.getParameter("fechaNacimiento"),
                            request.getParameter("direccion")
                    };
                    alumnos.add(nuevoAlumno); // Añadir nuevo alumno
                }
            }

            if (alumnos.isEmpty()) {
                out.println("<tr><td colspan='6' style='text-align: center;'>No hay alumnos registrados</td></tr>");
            } else {
                for (int i = 0; i < alumnos.size(); i++) {
                    String[] alumno = alumnos.get(i);
                    out.println("<tr>");
                    out.println("<td>" + alumno[0] + "</td>");
                    out.println("<td>" + alumno[1] + "</td>");
                    out.println("<td>" + alumno[2] + "</td>");
                    out.println("<td>" + alumno[3] + "</td>");
                    out.println("<td>" + alumno[4] + "</td>");
                    out.println("<td class='action-buttons'>");
                    out.println("<a href='index.jsp?editIndex=" + i + "' class='btn btn-warning'>Editar</a>");
                    out.println("<a href='index.jsp?eliminarAlumno=" + i + "' class='btn btn-danger'>Eliminar</a>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            }
        %>
        </tbody>
    </table>

    <%
        String editIndex = request.getParameter("editIndex");
        String carnet = "";
        String nombre = "";
        String apellidos = "";
        String fechaNacimiento = "";
        String direccion = "";

        if (editIndex != null && !editIndex.isEmpty()) {
            int index = Integer.parseInt(editIndex);
            String[] alumno = alumnos.get(index);
            carnet = alumno[0];
            nombre = alumno[1];
            apellidos = alumno[2];
            fechaNacimiento = alumno[3];
            direccion = alumno[4];
        }
    %>

    <form method="POST" action="index.jsp">
        <input type="hidden" name="editIndex" value="<%= editIndex != null ? editIndex : "" %>">
        <div class="form-group">
            <label for="carnet">Carnet:</label>
            <input type="text" name="carnet" value="<%= carnet %>" required />
        </div>
        <div class="form-group">
            <label for="nombre">Nombre:</label>
            <input type="text" name="nombre" value="<%= nombre %>" required />
        </div>
        <div class="form-group">
            <label for="apellidos">Apellidos:</label>
            <input type="text" name="apellidos" value="<%= apellidos %>" required />
        </div>
        <div class="form-group">
            <label for="fechaNacimiento">Fecha de Nacimiento:</label>
            <input type="date" name="fechaNacimiento" value="<%= fechaNacimiento %>" required />
        </div>
        <div class="form-group">
            <label for="direccion">Dirección:</label>
            <input type="text" name="direccion" value="<%= direccion %>" required />
        </div>
        <button type="submit" class="btn btn-primary"><%= editIndex != null ? "Guardar Cambios" : "Agregar Alumno" %></button>
    </form>

    <h2>Materias</h2>
    <table>
        <thead>
        <tr>
            <th>Código</th>
            <th>Nombre</th>
            <th>Descripción</th>
            <th>Fecha de Creación</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (session.getAttribute("materias") == null) {
                session.setAttribute("materias", new ArrayList<String[]>());
            }
            List<String[]> materias = (List<String[]>) session.getAttribute("materias");

            if (request.getParameter("eliminarMateria") != null) {
                int index = Integer.parseInt(request.getParameter("eliminarMateria"));
                materias.remove(index);
            }

            if (request.getParameter("codigo") != null) {
                if (request.getParameter("editMateriaIndex") != null && !request.getParameter("editMateriaIndex").isEmpty()) {
                    int index = Integer.parseInt(request.getParameter("editMateriaIndex"));
                    materias.set(index, new String[]{
                            request.getParameter("codigo"),
                            request.getParameter("nombreMateria"),
                            request.getParameter("descripcionMateria"),
                            request.getParameter("fechaCreacion")
                    });
                } else {
                    String[] nuevaMateria = {
                            request.getParameter("codigo"),
                            request.getParameter("nombreMateria"),
                            request.getParameter("descripcionMateria"),
                            request.getParameter("fechaCreacion")
                    };
                    materias.add(nuevaMateria);
                }
            }

            if (materias.isEmpty()) {
                out.println("<tr><td colspan='5' style='text-align: center;'>No hay materias registradas</td></tr>");
            } else {
                for (int i = 0; i < materias.size(); i++) {
                    String[] materia = materias.get(i);
                    out.println("<tr>");
                    out.println("<td>" + materia[0] + "</td>");
                    out.println("<td>" + materia[1] + "</td>");
                    out.println("<td>" + materia[2] + "</td>");
                    out.println("<td>" + materia[3] + "</td>");
                    out.println("<td class='action-buttons'>");
                    out.println("<a href='index.jsp?editMateriaIndex=" + i + "' class='btn btn-warning'>Editar</a>");
                    out.println("<a href='index.jsp?eliminarMateria=" + i + "' class='btn btn-danger'>Eliminar</a>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            }
        %>
        </tbody>
    </table>

    <%
        String editMateriaIndex = request.getParameter("editMateriaIndex");
        String codigo = "";
        String nombreMateria = "";
        String descripcionMateria = "";
        String fechaCreacion = "";

        if (editMateriaIndex != null && !editMateriaIndex.isEmpty()) {
            int index = Integer.parseInt(editMateriaIndex);
            String[] materia = materias.get(index);
            codigo = materia[0];
            nombreMateria = materia[1];
            descripcionMateria = materia[2];
            fechaCreacion = materia[3];
        }
    %>

    <form method="POST" action="index.jsp">
        <input type="hidden" name="editMateriaIndex" value="<%= editMateriaIndex != null ? editMateriaIndex : "" %>">
        <div class="form-group">
            <label for="codigo">Código:</label>
            <input type="text" name="codigo" value="<%= codigo %>" required />
        </div>
        <div class="form-group">
            <label for="nombreMateria">Nombre:</label>
            <input type="text" name="nombreMateria" value="<%= nombreMateria %>" required />
        </div>
        <div class="form-group">
            <label for="descripcionMateria">Descripción:</label>
            <input type="text" name="descripcionMateria" value="<%= descripcionMateria %>" required />
        </div>
        <div class="form-group">
            <label for="fechaCreacion">Fecha de Creación:</label>
            <input type="date" name="fechaCreacion" value="<%= fechaCreacion %>" required />
        </div>
        <button type="submit" class="btn btn-success"><%= editMateriaIndex != null ? "Guardar Cambios" : "Agregar Materia" %></button>
    </form>

    <h2>Inscripción a Materias</h2>
    <table>
        <thead>
        <tr>
            <th>Carnet del Estudiante</th>
            <th>Código de la Materia</th>
            <th>Acciones</th>
        </tr>
        </thead>
        <tbody>
        <%
            if (session.getAttribute("inscripciones") == null) {
                session.setAttribute("inscripciones", new ArrayList<String[]>());
            }
            List<String[]> inscripciones = (List<String[]>) session.getAttribute("inscripciones");

            if (request.getParameter("eliminarInscripcion") != null) {
                int index = Integer.parseInt(request.getParameter("eliminarInscripcion"));
                inscripciones.remove(index);
            }

            if (request.getParameter("carnetEstudiante") != null && request.getParameter("codigoMateriaInscripcion") != null) {
                String carnetEstudiante = request.getParameter("carnetEstudiante");
                String codigoMateriaInscripcion = request.getParameter("codigoMateriaInscripcion");

                // Verificar si el estudiante ya está inscrito en la materia
                boolean yaInscrito = inscripciones.stream().anyMatch(inscripcion -> inscripcion[0].equals(carnetEstudiante) && inscripcion[1].equals(codigoMateriaInscripcion));

                if (!yaInscrito) {
                    inscripciones.add(new String[]{carnetEstudiante, codigoMateriaInscripcion});
                } else {
                    out.println("<tr><td colspan='3' style='text-align: center;'>El estudiante ya está inscrito en esta materia</td></tr>");
                }
            }

            if (inscripciones.isEmpty()) {
                out.println("<tr><td colspan='3' style='text-align: center;'>No hay inscripciones registradas</td></tr>");
            } else {
                for (int i = 0; i < inscripciones.size(); i++) {
                    String[] inscripcion = inscripciones.get(i);
                    out.println("<tr>");
                    out.println("<td>" + inscripcion[0] + "</td>");
                    out.println("<td>" + inscripcion[1] + "</td>");
                    out.println("<td class='action-buttons'>");
                    out.println("<a href='index.jsp?eliminarInscripcion=" + i + "' class='btn btn-danger'>Eliminar</a>");
                    out.println("</td>");
                    out.println("</tr>");
                }
            }
        %>
        </tbody>
    </table>

    <form method="POST" action="index.jsp">
        <div class="form-group">
            <label for="carnetEstudiante">Carnet del Estudiante:</label>
            <input type="text" name="carnetEstudiante" required />
        </div>
        <div class="form-group">
            <label for="codigoMateriaInscripcion">Código de la Materia:</label>
            <input type="text" name="codigoMateriaInscripcion" required />
        </div>
        <button type="submit" class="btn btn-primary">Inscribir Estudiante</button>
    </form>

    <h2>Conteo de Estudiantes por Materia</h2>
    <table>
        <thead>
        <tr>
            <th>Código de Materia</th>
            <th>Total Estudiantes Inscritos</th>
        </tr>
        </thead>
        <tbody>
        <%
            // Conteo de estudiantes por materia
            if (!inscripciones.isEmpty()) {
                List<String> codigosMaterias = new ArrayList<>();
                for (String[] inscripcion : inscripciones) {
                    String codigoMateria = inscripcion[1];
                    if (!codigosMaterias.contains(codigoMateria)) {
                        codigosMaterias.add(codigoMateria);
                    }
                }

                for (String codigoMateria : codigosMaterias) {
                    long conteo = inscripciones.stream().filter(inscripcion -> inscripcion[1].equals(codigoMateria)).count();
                    out.println("<tr>");
                    out.println("<td>" + codigoMateria + "</td>");
                    out.println("<td>" + conteo + "</td>");
                    out.println("</tr>");
                }
            } else {
                out.println("<tr><td colspan='2' style='text-align: center;'>No hay inscripciones registradas</td></tr>");
            }
        %>
        </tbody>
    </table>
</div>
</body>
</html>
