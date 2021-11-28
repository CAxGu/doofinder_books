//Fichero javascript con todo el código custom que utilizaremos en la aplicación

/**
 * Funcion que dará funcionalidad al botón "Acceder" del home.
 */
function accederListadoLibros() {
    if (window.location.pathname == '/') {
        let btnAccess = document.getElementById('btnAcceso_lista');
        if (btnAccess != null && btnAccess != undefined) {
            btnAccess.addEventListener("click", () => window.location.pathname = '/books');
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

function mostrarDetalle() {
    $(document).on('click', '.content-showhide', function(event) {
        let idDetail = 'cardDetailsId_' + event.currentTarget.id.split("_")[1];
        $("#" + idDetail).toggle('slow', 'swing');
        $("#showDetailsId_" + event.currentTarget.id.split("_")[1]).toggle();
        $("#hideDetailsId_" + event.currentTarget.id.split("_")[1]).toggle();
    });
}

window.onload = mostrarDetalle();
window.onload = accederListadoLibros();
window.onload = detectarBusqueda();