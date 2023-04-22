// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.
function updateUserRole(checkbox) {
        const liveToast = document.getElementById('liveToast');

        const isChecked = checkbox.checked;
        const name = checkbox.name;
        const value = checkbox.value;
        //debugger;
        // здесь можно отправить AJAX-запрос на сервер, чтобы обновить состояние пользователя
        $.ajax({
            url: '/ManageUsers/SaveUsersRoles',
            type: 'POST',
            data: { name: name, value: value, isChecked: isChecked },
            success: function (result) {
                if (value == 'EmailConfirmed') {
                    checkbox.disabled = true;
                }
                const toastBootstrap = bootstrap.Toast.getOrCreateInstance(liveToast);
                toastBootstrap.show();

            },
            error: function (xhr, status, error) {
                // обработка ошибки при выполнении AJAX-запроса
            }
        });

    }
$(document).ready(function () {
    $('input.user-settings').click(function (obj) {
        $('#save-changes-button').prop('disabled', false);
    });
});