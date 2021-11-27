//Fichero javascript con todo el código custom que utilizaremos en la aplicación

/**
 * Funcion que dará funcionalidad al botón "Acceder" del home.
 */
function accederListadoLibros() {
    if (window.location.pathname == '/') {
        let btnAccess = document.getElementById('btnAcceso_lista');
        if (btnAccess != null && btnAccess != undefined) {
            btnAccess.addEventListener("click", () => window.location.pathname = '/list');
        }
    }
}

function detectarBusqueda() {
    if (window.location.pathname == '/list') {
        let barraBusqueda = document.getElementById('buscador_libros');

        barraBusqueda.oninput = (event) => {
            let value = event.target.value;
            if (value.length > 0) {
                console.log('value: ' + value);
                //return
            }

        }
    }
}



window.onload = accederListadoLibros();
window.onload = detectarBusqueda();