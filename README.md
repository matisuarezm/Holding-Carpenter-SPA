# 📘 Proyecto: Holding-Carpenter-SPA - Semana 7

## 📝 Descripción general del sistema

En esta semana se implementa, en Oracle, la base de datos relacional del sistema de gestión de personal del Holding Carpenter SPA.  
El objetivo es crear las tablas, restricciones y poblamiento inicial a partir del modelo relacional entregado, y luego generar consultas para análisis de renta promedio por compañía.

### Objetivo general

Implementar mediante sentencias DDL y DML el modelo relacional normalizado del Holding Carpenter SPA, asegurando integridad referencial, aplicación de reglas de negocio (CHECK, UNIQUE) y soporte para consultas de simulación de rentas.

### Alcance del modelo

- Crear las tablas: `PERSONAL`, `COMPANIA`, `COMUNA`, `REGION`, `ESTADO_CIVIL`, `GENERO`, `TITULO`, `TITULACION`, `DOMINIO`, `IDIOMA`.
- Definir claves primarias, foráneas, únicas y restricciones CHECK (email único, sueldo mínimo, dígito verificador del RUN).
- Configurar columnas IDENTITY para `IDIOMA` y `REGION`, y secuencias para `COMUNA` y `COMPANIA` para el poblamiento.
- Poblar las tablas `IDIOMA`, `REGION`, `COMUNA` y `COMPANIA` con los datos indicados en la guía.
- Desarrollar consultas SQL para los informes 1 y 2 de simulación de renta promedio.

---
## 👤 Autores del proyecto
- **Nombre completo:** Matias Suarez M. / Sebastian Rodriguez R.
- **Ramo:** Modelamiento de Bases de Datos
- **Grupo:** Grupo N°10
- **Sección:** 001A
- **Profesor:** Armando Romero M.
- **Carrera:** Analista Programador Computacional
- **Sede:** Carrera 100% Online
