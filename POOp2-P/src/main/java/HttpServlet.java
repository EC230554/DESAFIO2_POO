public class HttpServlet {
    public HttpServlet() {
    }

    public class Estudiante {
        private String carnet;
        private String nombre;
        private String apellidos;
        private String fechaNacimiento;
        private String direccion;

        public Estudiante(String carnet, String nombre, String apellidos, String fechaNacimiento, String direccion) {
            this.carnet = carnet;
            this.nombre = nombre;
            this.apellidos = apellidos;
            this.fechaNacimiento = fechaNacimiento;
            this.direccion = direccion;
        }

        public String getCarnet() {
            return this.carnet;
        }

        public String getNombre() {
            return this.nombre;
        }

        public String getApellidos() {
            return this.apellidos;
        }

        public String getFechaNacimiento() {
            return this.fechaNacimiento;
        }

        public String getDireccion() {
            return this.direccion;
        }

        public void setCarnet(String carnet) {
            this.carnet = carnet;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

        public void setApellidos(String apellidos) {
            this.apellidos = apellidos;
        }

        public void setFechaNacimiento(String fechaNacimiento) {
            this.fechaNacimiento = fechaNacimiento;
        }

        public void setDireccion(String direccion) {
            this.direccion = direccion;
        }
    }

    public class Materia {
        private String codigoMateria;
        private String nombre;
        private String descripcion;
        private String fechaCreacion;

        public Materia(String codigoMateria, String nombre, String descripcion, String fechaCreacion) {
            this.codigoMateria = codigoMateria;
            this.nombre = nombre;
            this.descripcion = descripcion;
            this.fechaCreacion = fechaCreacion;
        }

        public String getCodigoMateria() {
            return this.codigoMateria;
        }

        public String getNombre() {
            return this.nombre;
        }

        public String getDescripcion() {
            return this.descripcion;
        }

        public String getFechaCreacion() {
            return this.fechaCreacion;
        }

        public void setCodigoMateria(String codigoMateria) {
            this.codigoMateria = codigoMateria;
        }

        public void setNombre(String nombre) {
            this.nombre = nombre;
        }

        public void setDescripcion(String descripcion) {
            this.descripcion = descripcion;
        }

        public void setFechaCreacion(String fechaCreacion) {
            this.fechaCreacion = fechaCreacion;
        }
    }
}