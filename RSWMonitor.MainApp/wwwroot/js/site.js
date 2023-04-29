const successToast = document.getElementById('success-toast');
const errorToast = document.getElementById('error-toast');

$(document).ready(function () {
});

function fillConfiguration(elementId) {
    //debugger;
    var configurationId = $('#' + elementId)[0].value;
    var selector = 'tr:has(#' + elementId + ')';

    var name = $(selector + '>td.configuration-entry-name')[0].innerText;
    var uri = $(selector + '>td.configuration-entry-uri')[0].innerText;
    var type = $(selector + '>td.configuration-entry-type')[0].attributes['data-type'].value;
    var hasControls = ($(selector + '>td.configuration-entry-has-controls')[0].attributes['data-has-controls'].value == 'True' ? true : false);
    var roles = JSON.parse($(selector + '>td.configuration-entry-roles')[0].attributes['data-configuration-roles'].value);

    $('#configuration-name')[0].value = name;
    $('#configuration-uri')[0].value = uri;
    $('#configuration-type')[0].value = type;
    $('#configuration-has-controls')[0].checked = hasControls;
    $('#configuration-db-id')[0].value = configurationId;

    var addConfigurationRoles = document.querySelectorAll('input.add-configuration-roles');
    addConfigurationRoles.forEach(element => {
        if (roles.includes((element.id).replaceAll('role-', ''))) {
            element.checked = true;
        }
    });

}

function removeConfiguration(elementId) {
    //debugger;
    var element = $('#' + elementId)[0];
    var configurationId = element.value;

    $.ajax({
        url: '/ManageRemoteMonitors/RemoveConfiguration',
        type: 'POST',
        data: { configurationId: configurationId },
        success: function (response) {
            location.reload();
            showToast();
        },
        error: function (response) {
            //debugger;
            showExceptionToast(response);
        }
    });
}

function updateUserRole(checkbox) {
        const isChecked = checkbox.checked;
        const name = checkbox.name;
        const value = checkbox.value;

        $.ajax({
            url: '/ManageUsers/SaveUsersRoles',
            type: 'POST',
            data: { name: name, value: value, isChecked: isChecked },
            success: function (result) {
                if (value == 'EmailConfirmed') {
                    checkbox.disabled = true;
                }
                showToast();

            },
            error: function (response) {
                //debugger;
                showExceptionToast(response);
            }
        });
}

function createRole(element) {
    var roleName = element.parentElement.firstElementChild.value;
    if (roleName == '' || roleName == null || roleName == undefined) {

    }

    $.ajax({
        url: '/ManageUsers/CreateRole',
        type: 'POST',
        data: { roleName: roleName },
        success: function (response) {
            location.reload();
            showToast();
        },
        error: function (response) {
            //debugger;
            showExceptionToast(response);
        }
    });
}

function removeRole(elementId) {
    var element = $('#' + elementId)[0];
    //debugger;
    var roleName = element.parentElement.parentElement.children[1].innerHTML;

    $.ajax({
        url: '/ManageUsers/RemoveRole',
        type: 'POST',
        data: { roleName: roleName },
        success: function (response) {
            location.reload();
            showToast();
        },
        error: function (response) {
            //debugger;
            showExceptionToast(response);
        }
    });
}

function showToast(isError = false, errorText = '') {
    var toastBootstrap;
    if (!isError) {
        toastBootstrap = bootstrap.Toast.getOrCreateInstance(successToast);
    } else {
        let elem = $('#error-toast-text')[0];
        elem.innerHTML = errorText;
        toastBootstrap = bootstrap.Toast.getOrCreateInstance(errorToast);
    }

    toastBootstrap.show();
}

$('#confirm-deletion').on('show.bs.modal', function (e) {
    //debugger;
    $(this).find('.btn-ok').attr('onclick', $(e.relatedTarget).data('onclick'));
});

//$('#add-configuration').on('show.bs.modal', function (e) {
//    debugger;
//    $(this).find('.btn-ok').attr('onclick', $(e.relatedTarget).data('onclick'));
//});

$('#add-configuration').on('hidden.bs.modal', function (e) {
    $('#configuration-name')[0].value = '';
    $('#configuration-uri')[0].value = '';
    $('#configuration-type')[0].value = 1;
    $('#configuration-has-controls')[0].checked = false;
    document.querySelectorAll('input.add-configuration-roles').forEach(elem => elem.checked = false)
});

function showExceptionToast(ex) {
    try {
        showToast(true, ex.responseJSON.value.value);
    } catch {
        showToast(true, ex.responseText);
    }
}