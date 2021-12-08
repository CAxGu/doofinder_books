# DoofinderBooks
![alt text](https://github.com/CAxGu/doofinder_books/blob/main/priv/static/images/logodoofinderBooks.png)

Prueba Técnica CAxGu para [`Doofinder`](https://www.doofinder.com/es/?mktcod=A002&utm_term=doofinder&utm_campaign=%5Bes_ES%5D&utm_source=adwords&utm_medium=ppc&hsa_acc=7122150564&hsa_cam=1714185576&hsa_grp=67113883575&hsa_ad=333410644207&hsa_src=g&hsa_tgt=kwd-49586846652&hsa_kw=doofinder&hsa_mt=b&hsa_net=adwords&hsa_ver=3&gclid=CjwKCAiAwKyNBhBfEiwA_mrUMp1OE02yy_Y47iLnGEajCCgQGMNXP2TX4-aj6oX-d9mSAMgj85TqTBoC9AkQAvD_BwE)


## BREVE DESCRIPCIÓN
Este proyecto ha sido programado con Elixir y su framework Phoenix.
La prueba consistía en crear un CRUD funcional para una biblioteca, en la cual el usuario pudiese dar de alta libros, autores y categorías para el mismo.

*(La aplicación solamente cuenta con vista de administrado por el momento)*


## ARRANCAR EL PROYECTO

### REQUISITOS PREVIOS

* Tener instalado [Elixir](https://elixir-lang.org/install.html)
  *  Instala o actualiza Hex con el comando `mix local.hex`
* Tener instalado [Erlang VM](https://www.erlang.org/downloads)
* Tener instalado [postgreSQL](https://www.postgresql.org/download/)
* Preparar Phoenix con el comando `mix archive.install hex phx_new`
* (Opcional) Tener instalado [Docker](https://www.docker.com)

Si quieres más info para generar un nuevo proyecto, puedes visitar la doc de [Phoenix](https://hexdocs.pm/phoenix)



### INICIAR DESDE LOCAL

 * Instala las dependencias con `mix deps.get`
 * Crea y migra tu base de datos con `mix ecto.setup`
   * (opcional) Utiliza el script [`createDB.sh`](https://github.com/CAxGu/doofinder_books/blob/main/database_entry/createDB.sh) y crea el usuario ,BD y tablas necesarias para el proyecto en tu base de datos local.
 * Inicia Phoenix con `mix phx.server` o desde IEx con `iex -S mix phx.server`

Visita [`localhost:4000`](http://localhost:4000) desde tu navegador.


### INICIAR DESDE CONTENEDOR DOCKER (Requiere Docker)
 
 * Crea una imagen propia del código en el proyecto con el comando `docker build -t doofinder_books:1.0.0 .`
   * (opcional) Puedes utilizar el [launcher docker](https://github.com/CAxGu/doofinder_books/raw/main/launcher_docker_doofinder_books.zip) y omitir el resto de pasos.
 * Ejecuta el comando `docker swarm init`
 * Crea tu contenedor con el comando `docker compose up`
 
 
Visita [`localhost:4000`](http://localhost:4000) desde tu navegador.


Para mas info de ejecución en producción, visita la [guía de desarrollo](https://hexdocs.pm/phoenix/deployment.html).


## NAVEGACIÓN

* Al acceder a la aplicación nos recicibirá con un "home" de bienvenida. Dándole al botón "Acceder" nos llevará al listado de libros.

**IMPORTANTE: Si no contamos con al menos 1 Autor y 1 Categoría creada, no se nos habilitará el botón de "Alta Libro"**

* El usuario podrá dar de alta autores o categorías en el orden que quiera.
* La modificación de datos de las mismas, al igual que las del libro relacionado, estarán interconectadas. Es decir, cuando cambiemos el nombre del autor, se reflejará dicho cambio también en el desplegable disponible en el alta de un libro. (Lo mismo para categorías)
* Por último, en la cabecera, se cuenta con 3 enlaces:
  * Un enlace a este repositorio del proyecto
  * Un About, donde se excplica brevemente el propósito del mismo, junto con información referente al framework, librerías y o documentación
  * El banner, nos devolverá a la página del Home.



## MEJORAS
Dado que este proyecto ha sido realizado para una prueba técnica, el tiempo de entrega ha sido importante, por ello, muchas cosas se han quedado en el tintero, a pesar de haber sido contempladas.

Cómo primer punto, mencionar que desconocía completamente el framework/tecnología Elixir Phoenix, por lo que a pesar de haberseme indicado que podía utilizar otro más afín, decidí utilizar el propio lenguaje con el que trabaja la empresa para la que realizaba esta prueba. Esto implica que el tiempo de desarrollo se ha estirado un poco más de la cuenta, contando con que he tenido que "formarme" en su funcionamiento a la vez que la realizaba.

Algunas de ellas:
* Sistema de Login. Permitir un acceso en modo usuario genérico solo lectura, y un modo admin donde poder gestionar todo.
* Control de errores para la eliminación de autores y o categorías, cuando existe un libro asociado a a las mismas todavía y solamente existe 1 autor y 1 categoría creadas en ese momento.
* Refactorizado de vistas, para utilizar más cuidadosamente el responsive.
* Refactorizado de botones alta para ser una barra independiente y evitar el duplciado de código en las vistas.
* Upload de imágenes para los libros. Poder seleccioanr una carátula independiente por libro, sin necesidad de tener una imagen básica.
* Mensajes Alert para altas, errores y o avisos de manera emergente y no fija
* Sistema de deploy automatizado. Tanto en Docker cómo en un servidor dedicado.
* Posible integración con backend en otro lenguaje (Ejemplo Django, Spring, Node.js....)
...


## Aprende más | Learn more 

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
