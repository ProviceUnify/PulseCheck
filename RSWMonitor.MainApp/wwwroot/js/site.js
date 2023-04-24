const successToast = document.getElementById('success-toast');
const errorToast = document.getElementById('error-toast');

$(document).ready(function () {
    //if ((location.href).includes('/ManageUsers')) {

    //}
    //$('input.user-settings').click(function (obj) {
    //    $('#save-changes-button').prop('disabled', false);
    //});
});

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
            error: function (xhr, status, error) {

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
            showToast(true, response.responseJSON.value.value);
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
            debugger;
            try {
                showToast(true, response.responseJSON.value.value);
            } catch {
                showToast(true, response.responseText);
            }
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