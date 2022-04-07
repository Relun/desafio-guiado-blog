--1. Crear base de datos llamada blog.
CREATE DATABASE Blog;
\c blog clau
--2. Crear las tablas indicadas de acuerdo al modelo de datos.
CREATE TABLE usuario(
id_user SERIAL,
email VARCHAR(50) NOT NULL UNIQUE,
PRIMARY KEY(id_user));

CREATE TABLE post(
 id_post SERIAL,
usuario_id INT NOT NULL,
titulo VARCHAR(120) NOT NULL UNIQUE,
 fecha DATE,
PRIMARY KEY(id_post),
FOREIGN KEY(usuario_id) REFERENCES usuario(id_user));

CREATE TABLE comentario(
id_com SERIAL,
post_id INT NOT NULL,
usuario_id INT NOT NULL,
texto VARCHAR(500),
fecha DATE,
PRIMARY KEY(id_com),
FOREIGN KEY(post_id) REFERENCES post(id_post),
FOREIGN KEY(usuario_id) REFERENCES usuario(id_user));
--3. Insertar los siguientes registros.
\copy usuario FROM 'C:\Users\claud\Desktop\EmprendimientoRuby\7. Intro-Bases-Datos\Blog\usuario.csv' csv header;
\copy post FROM 'C:\Users\claud\Desktop\EmprendimientoRuby\7. Intro-Bases-Datos\Blog\post.csv' csv header;
\copy comentario FROM 'C:\Users\claud\Desktop\EmprendimientoRuby\7. Intro-Bases-Datos\Blog\comentarios.csv' csv header;
--4. Seleccionar el correo, id y título de todos los post publicados por el usuario 5
SELECT email, id_user, id_post, titulo FROM usuario JOIN post ON id_user = post.usuario_id WHERE id_user = 5;
--5. Listar el correo, id y el detalle de todos los comentarios que no hayan sido realizados por el usuario con email usuario06@hotmail.com.
SELECT email, id_user, id_com, texto, fecha FROM usuario JOIN comentario On id_user = comentario.usuario_id WHERE email != 'usuario06@hotmail.com';
--6. Listar los usuarios que no han publicado ningún post
SELECT id_user, email FROM usuario LEFT JOIN post ON id_user = post.usuario_id WHERE id_post IS NULL;
--7. Listar todos los post con sus comentarios (incluyendo aquellos que no poseen comentarios)
SELECT * FROM post FULL OUTER JOIN comentario ON id_post = comentario.post_id;
--8. Listar todos los usuarios que hayan publicado un post en Junio
SELECT id_user, email FROM usuario JOIN post ON id_user = post.usuario_id WHERE post.fecha BETWEEN '2020-06-01' AND '2020-06-30'; 






