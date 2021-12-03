//Fichero javascript con todo el código custom que utilizaremos en la aplicación

/**
 * Función que permite detectar en tiempo real, lo escrito en la barra de filtrado/busqueda
 * (FUNCIONALIDAD SIN IMPLEMENTAR.)
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


//Datepickers Form Nac/Muerte
$("#datepicker_death").attr('disabled', true);
$(function() {
    $("#datepicker_birth").datepicker({
        defaultDate: new Date(),
        dateFormat: 'yy-mm-dd',
        onSelect: function(dateStr) {
            $("#datepicker_death").attr('disabled', false);
            $("#datepicker_death").datepicker("option", { dateFormat: 'yy-mm-dd', defaultDate: new Date(dateStr), minDate: new Date(dateStr) })
                //$('#datepicker_pub').val(returnFormatDateAsStr(dateStr));
        }
    });
});

$(function() {
    $('#datepicker_death').datepicker({
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



function prueba() {
    /*
    $(window).on('load', '#hidden_counter_author', function(event) {
        console.log("holiwis");
    });

    $(window).on('load', '#hidden_counter_categories', function(event) {
        console.log("holiueeeeeeeepa");
    });
*/
    $(document).ready(function() {
        document.getElementById
        console.log("holiwis");
    });

    $(document).ready(function() {
        console.log("holiueeeeeeeepa");
    });
}

/**
 * Habilita o deshabilita el botón de Alta de Libros, si no existen un mínimo de 1 Autor y 1 Categoría creadas anteriormente
 */
$(document).ready(function(event) {
    if (document.body.contains(document.getElementById('btn_alta_book_list'))) {
        var listCategoriesLength = document.getElementById('hidden_counter_categories');
        var listAutoresLength = document.getElementById('hidden_counter_author');
        var buttonAltaBooks = document.getElementById('btn_alta_book_list');

        if (listCategoriesLength != undefined && listAutoresLength != undefined) {
            if (listCategoriesLength.value > 0 && listAutoresLength.value > 0) {
                buttonAltaBooks.disabled = false;
            } else {
                buttonAltaBooks.disabled = true;
            }

        }
    }
});


window.onload = mostrarDetalle();
window.onload = detectarBusqueda();