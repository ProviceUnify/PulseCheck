const successToast = document.getElementById('success-toast');
const errorToast = document.getElementById('error-toast');

function delay(time) {
    return new Promise(resolve => setTimeout(resolve, time));
}

$(document).ready(function () {
    //$("input.add-configuration-roles").change(function () {
    //    $.each($("input.add-configuration-roles"), function () {
    //        this.setCustomValidity('');
    //    });
    //    var checked = $("input.add-configuration-roles:checked").length;
    //    if (checked == 0) {
    //        alert('Please select at least 1 role');
    //    }
    //});
    //$("#add-configuration-form").submit(function () {
    //    var checked = $("input.add-configuration-roles:checked").length;
    //    if (checked == 0) {
    //        alert('Please select at least 1 role');
    //        return false;
    //    } else {
    //        return true;
    //    }
    //});
    //$('#healthcheck-iframe').on('load', function () {
    //    $('#healthcheck-iframe').contents().find('body').append('<script>var t = document.querySelector("#outer-container"); t.addEventListener("load", (event) => {console.log(".tag")})</script>');
    //    //debugger;
    //    //var iframe = document.querySelectorAll('#healthcheck-iframe')[0].contentDocument.documentElement;
    //    //console.log(iframe);
    //});
    //debugger;
    
    $('input.init').on('keypress', function () {
        //debugger;
        if ($('input#components-count')[0].value == 0) {
            $('input#components-count')[0].value = 1;
        }
    });
});

function removeOtherRolesEntries(currentRoles) {
    var roles = JSON.parse(currentRoles); // HOFFMAN, KSD
    delay(200).then(() => {
        var t = $("#healthcheck-iframe").contents().find(".tag");
        //console.log(t.length);
        //debugger;
        for (var i = 0; i < t.length; i++) {

            //console.log(roles.includes(t[i].innerText));
            if (roles.includes(t[i].innerText)) {
                t[i].parentElement.parentElement.classList.add('keep')
            } else {
                //t[i].parentElement.parentElement.classList.remove('delete')
            }
        }
        //delay(100).then(() => {
            var healthCheckRowsToRemove = $("#healthcheck-iframe").contents().find('.hc-checks-table__body > tr:not(.keep)');
            healthCheckRowsToRemove.remove();
            //healthCheckRowsToRemove.forEach(elem => { elem.remove() })
        //});
        //t.forEach(tag => {
        //});
    });
    //delay(1000).then(() => $("#healthcheck-iframe").contents().find(".tag").remove());
}
function removeComponentRow(row) {
    //debugger;
    var rowToDelete = document.querySelectorAll('tr:has(#' + row.id + ')');
    rowToDelete[0].remove();
    $('input#components-count')[0].value = $('input#components-count')[0].value - 1;
}

function addComponentRow() {
    //debugger;
    var lastRow = $('#component-table > tbody')[0].lastElementChild;
    var lastRowNumber = lastRow.attributes['data-row'].value;
    var newRowNumber = +lastRowNumber.split('-')[1] + 1;
    var newRow = ('<tr class="delete-on-close" data-row="row-' + newRowNumber + '">' + (lastRow.innerHTML.replaceAll(lastRowNumber, 'row-' + newRowNumber).replaceAll(("'row':" + lastRowNumber), ("'row':" + newRowNumber))) + '</tr>');
    newRow = $(newRow.replaceAll(("'row':" + lastRowNumber.split('-')[1]), ("'row':" + newRowNumber)).replaceAll('disabled', ''));
    $('#component-table > tbody')[0].append(newRow[0]);
    $('#row-index-row-' + newRowNumber)[0].innerText = newRowNumber;
    $('input#components-count')[0].value = newRowNumber;
    $('#component-db-id-row-' + newRowNumber)[0].value = -1;
}

function fillConfiguration(elementId) {
    //debugger;
    var selector = 'tr:has(#' + elementId + ')';
    var componentsCount = $(selector)[0].attributes['data-components-count'].value;
    for (var i = 0; i < componentsCount - 1; i++) {
        addComponentRow();
    }

    var configurationId = $('#' + elementId)[0].value;
    var name = $(selector + '>td.configuration-entry-name')[0].attributes['data-name'].value;
    var uri = $(selector + '>td.configuration-entry-uri')[0].innerText;

    var rowsData = [];

    var componentsTableOfConfiguration = $(selector + ' + tr.collapse > td > table > tbody');
    for (var i = 1; i <= componentsCount; i++) {
        var rowData = {
            'componentId': -1,
            'componentTypeId': 0,
            'componentName': '',
            'componentQuery': '',
            'componentRoletags': ''
        };
       //debugger;
        var row = $(selector + ' + tr.collapse > td > table > tbody')[0].rows[i];
        rowData.componentId = row.attributes['data-component-db-id'].value;
        rowData.componentTypeId = row.querySelectorAll('td.component-type')[0].attributes['data-type-id'].value;
        rowData.componentName = row.querySelectorAll('td.component-name')[0].attributes['data-name'].value;
        rowData.componentQuery = row.querySelectorAll('td.component-query')[0].innerText;
        rowData.componentRoletags = row.querySelectorAll('td.component-roletags')[0].attributes['data-roletags'].value;
        rowsData.push(rowData);
    }
   //debugger;
    $('#configuration-name')[0].value = name;
    $('#configuration-uri')[0].value = uri;
    $('#configuration-db-id')[0].value = configurationId;

    rowsData.forEach(function(row, index) {
        $("#component-type-row-" + (index + 1))[0].value = row.componentTypeId;
        $("#component-name-row-" + (index + 1))[0].value = row.componentName;
        $("#component-query-row-" + (index + 1))[0].value = row.componentQuery;
        $("#component-db-id-row-" + (index + 1))[0].value = row.componentId;
        var addConfigurationRoles = document.querySelectorAll('input.add-configuration-roles-row-' + (index + 1));
        addConfigurationRoles.forEach(element => {
            if (row.componentRoletags.includes((element.id).replaceAll('role-', '').replaceAll('-row-' + (index + 1), ''))) {
                element.checked = true;
            }
        });
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

$('#add-configuration').on('hidden.bs.modal', function (e) {
    $('#configuration-name')[0].value = '';
    $('#configuration-uri')[0].value = '';
    document.querySelectorAll('select.configuration-types').forEach(elem => elem.value = 1);
    document.querySelectorAll('input.add-configuration-roles').forEach(elem => elem.checked = false);
    document.querySelectorAll('input.component-names').forEach(elem => elem.value = '');
    document.querySelectorAll('input.component-queries').forEach(elem => elem.value = '');

    $('input#components-count')[0].value = 0;
    //debugger;
    document.querySelectorAll('tr.delete-on-close').forEach(elem => elem.remove());
});

function showExceptionToast(ex) {
    try {
        showToast(true, ex.responseJSON.value.value);
    } catch {
        showToast(true, ex.responseText);
    }
}