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

/**
 * Función que permite detectar en tiempo real, lo escrito en la barra de filtrado/busqueda
 */
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

/**
 * Función que ocultará o mostrará la tarjeta detalle del libro seleccionado
 */
function mostrarDetalle() {
    $(document).on('click', '.content-showhide', function(event) {
        let idDetail = 'cardDetailsId_' + event.currentTarget.id.split("_")[1];
        $("#" + idDetail).toggle('slow', 'swing');
        $("#showDetailsId_" + event.currentTarget.id.split("_")[1]).toggle();
        $("#hideDetailsId_" + event.currentTarget.id.split("_")[1]).toggle();
    });
}

//Datepickers Form Alta/Modif
$("#datepicker_ret").attr('disabled', true);
$(function() {
    $("#datepicker_pub").datepicker({
        defaultDate: new Date(),
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateStr) {
            $("#datepicker_ret").attr('disabled', false);
            $("#datepicker_ret").datepicker("option", { dateFormat: 'yy-mm-dd', defaultDate: new Date(dateStr), minDate: new Date(dateStr) })
                //$('#datepicker_pub').val(returnFormatDateAsStr(dateStr));
        }
    });
});

$(function() {
    $('#datepicker_ret').datepicker({
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateStr) {
            //$('#datepicker_ret').val(returnFormatDateAsStr(dateStr));
        }
    });
});

//Datepicker Regional ES
/**
 * Función que nos permite cargar en los datepicker, el locale_ES
 */
$.datepicker.regional['es'] = {
    closeText: 'Cerrar',
    prevText: '< Ant',
    nextText: 'Sig >',
    currentText: 'Hoy',
    monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
    monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
    dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
    dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb'],
    dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
    weekHeader: 'Sm',
    firstDay: 1,
    isRTL: false,
    dateFormat: 'yy-mm-dd',
    showMonthAfterYear: false,
    yearSuffix: ''
};
$.datepicker.setDefaults($.datepicker.regional['es']);

/**
 * Función que permite evitar el problema de formato en la fecha en ambos datepickers al mismo tiempo
 * @param {new Date() obtenido desde el datepicker #datepicker_pub} date 
 */
function returnFormatDateAsStr(date) {
    let dateToFormat = new Date(date);
    let day = dateToFormat.getDate();
    let dayStr = day.toString();

    if (day < 10) {
        dayStr = "0".concat(dayStr);
    }
    return dayStr + '/' + dateToFormat.getMonth().toString() + '/' + dateToFormat.getFullYear().toString();
}

$("p.alert").on("show", function() {
    setTimeout(function() { console.log("hola juaporr"); }, 3000);

});

$(document).on('show', '.p.alert.alert-info', function(event) {
    console.log("hola preshiosho");
});


window.onload = mostrarDetalle();
window.onload = accederListadoLibros();
window.onload = detectarBusqueda();