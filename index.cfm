<!DOCTYPE html>
<html>
    <head>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/jquery.validation/1.16.0/jquery.validate.min.js"></script>

        
        <style>
            .container {
                width: 100%;
                margin: 0 auto;
                padding: 20px;
                background-color: #f2f2f2;
                border-radius: 5px;
            }
            label {
                font-weight: bold;
            }
            input[type="text"],
            input[type="email"],
            select,
            textarea {
                width: 100%;
                padding: 8px;
                margin: 6px 0;
                box-sizing: border-box;
                border: 1px solid #ccc;
                border-radius: 4px;
            }
            #button {
                background-color: #4CAF50;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 50%;
            }
            #updateButton {
                background-color:blue;
                color: white;
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                width: 50%;
            }
            #customerTable {
                display: block;
                padding: 20px;
            }
            #customerTable table {
                border-collapse: collapse;
                width: 100%;
                font-family: Arial, sans-serif;
            }
            #customerTable th,
            #customerTable td {
                padding: 10px;
            }
            #customerTable th {
                background-color: #f2f2f2;
            }
    
            #DelButton {
                background-color: blue;
                color: white;
            }
            .btn-secondary {
                color: #fff;
                background-color: #6c757d;
                border-color: #6c757d;
                padding: 10px 20px;
            }
            .error-message {
                color: red;
                display:block;
            }
            .error-message-border{
                border: 2px solid red !important;
            }
            .valid {
                border: 2px solid green !important;
            }
        </style>
    </head>
    
    <body>
        <cfoutput>
            <!--- Set Columns Values --->
            <cfset columnNames = "ID, firstName, lastName, userName, email, phone, country, city, state, zipCode, address1, address2, comments" />
            <cfset columnTypes = "integer,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar,varchar" />

            <!--- Create a new query object --->
            <cfset usersQuery = queryNew(columnNames, columnTypes) />

            <!--- Define arrays with different values for each field --->
            <cfset firstNames = ["John", "Jane", "Jim", "Jill", "Jack", "Jenny", "Joe", "Joy", "Jake", "Judy"] />
            <cfset lastNames = ["Doe", "Smith", "Brown", "Johnson", "White", "Taylor", "Anderson", "Thomas", "Jackson", "Harris"] />
            <cfset cities = ["New York", "Los Angeles", "Chicago", "Houston", "Phoenix", "Philadelphia", "San Antonio", "San Diego", "Dallas", "San Jose"] />
            <cfset states = ["NY", "CA", "IL", "TX", "AZ", "PA", "TX", "CA", "TX", "CA"] />
            <cfset addresses = ["101 Main St", "202 Broad St", "303 Elm St", "404 Oak St", "505 Pine St", "606 Cedar St", "707 Maple St", "808 Birch St", "909 Walnut St", "1000 Ash St"] />
            <cfset phones = ["123-456-7891", "234-567-8902", "345-678-9013", "456-789-0124", "567-890-1235", "678-901-2346", "789-012-3457", "890-123-4568", "901-234-5679", "012-345-6780"] />


            <!--- Loop to create 10 records --->
            <cfloop from="1" to="10" index="i">
                <!--- Add a new row --->
                <cfset queryAddRow(usersQuery) />

                <!--- Set values for the row --->
                <cfset querySetCell(usersQuery, "ID", i) />
                <cfset querySetCell(usersQuery, "firstName", firstNames[i]) />
                <cfset querySetCell(usersQuery, "lastName", lastNames[i]) />
                <cfset querySetCell(usersQuery, "userName", "user" & i) />
                <cfset querySetCell(usersQuery, "email", "user" & i & "@example.com") />
                <cfset querySetCell(usersQuery, "phone", phones[i]) />
                <cfset querySetCell(usersQuery, "country", "USA") />
                <cfset querySetCell(usersQuery, "city", cities[i]) />
                <cfset querySetCell(usersQuery, "state", states[i]) />
                <cfset querySetCell(usersQuery, "zipCode", "9000" & i) />
                <cfset querySetCell(usersQuery, "address1", addresses[i]) />
                <cfset querySetCell(usersQuery, "address2", "Suite " & i) />
                <cfset querySetCell(usersQuery, "comments", "Comment " & i) />
            </cfloop>


            <!--- Output the simulated query --->
<!---             <cfdump var="#usersQuery#" abort="1"/> --->

        </cfoutput>

        <!-- Button trigger modal -->
        <button type="button" class="btn btn-primary" id="addNewUser" data-bs-toggle="modal" data-bs-target="#exampleModal" onclick="addNewUser(event)">
            Add New User
        </button>
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true" data-bs-backdrop="static" data-bs-keyboard="false">
            <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel"></h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <form action="javascript:void(1)" method="post" id="registrationForm">
                        <div class="container">
                            <h3 align="center">Registration Form</h3>
                            <div>
                                <label for="fname">First Name<span style="color:red">*</span></label>
                                <input type="text" name="fname" id="fname" class="error-hide">
                                <div class="error-message-container">
                                    <span class="error-message" id="fname-error"></span>
                                </div>
                            </div>
                            <div>
                                <label for="lname">Last Name<span style="color:red">*</span></label>
                                <input type="text" name="lname" id="lname" class="error-hide">
                                <div class="error-message-container">
                                    <span class="error-message" id="lname-error"></span>
                                </div>
                            </div>
                            <div>
                                <label for="username">User Name<span style="color:red">*</span></label>
                                <input type="text" name="username" id="username" class="error-hide">
                                <div class="error-message-container">
                                    <span class="error-message" id="username-error"></span>
                                </div>
                            </div>
                            <div>
                                <label for="email">Email<span style="color:red">*</span></label>
                                <input type="email" name="email" id="email" class="error-hide">
                                <div class="error-message-container">
                                    <span class="error-message" id="email-error"></span>
                                </div>
                            </div>
                            <div>
                                <label for="Phone">Phone<span style="color:red">*</span></label>
                                <input type="text" name="phone" id="phone" class="error-hide">
                                <div class="error-message-container">
                                    <span class="error-message" id="phone-error"></span>
                                </div>

                            </div>
                            <div>
                                <label for="Address1">Address 1<span style="color:red">*</span></label>
                                <input type="text" name="Address1" id="Address1" class="error-hide">
                                <div class="error-message-container">
                                    <span class="error-message" id="address-error"></span>
                                </div>
                            </div>
                            <div>
                                <label for="Address2">Address 2</label>
                                <input type="text" name="Address2" id="Address2">
                            </div>
                            <div>
                                <label for="country">Select a Country</label>
                                <select name="country" id="country"  onchange="checkCountry()">
                                    <option value="">Please choose</option>
                                    <option value="Pakistan">Pakistan</option>
                                    <option value="USA">USA</option>
                                </select>
                            </div>
                            <div>
                                <label for="city">City</label>
                                <select name="city" id="city">
                                    <option value="" selected="selected">Please select a City</option>
                                </select>
            
                                <label for="state">Select a State</label>
                                <select name="state" id="state">
                                    <option value="" selected="selected">Please select a State</option>
                                </select>
                            
                                <label for="zipcode">Zipcode</label>
                                <input type="text" name="zipcode" id="zipcode" class="error-hide">
                                <div class="error-message-container">
                                    <span class="error-message" id="zipcode-error"></span>
                                </div>

                            </div>
                            <div>
                                <label for="textBox">Comments</label>
                                <textarea rows="10" maxlength="500" id="textBox" name="textBox"></textarea> 
                            </div>
            
                            <div>
                                <button type="submit" class="btn btn-secondary submitForm" id="button">Submit</button>
                                <button type="button" class="btn btn-secondary" id="cancel1" data-bs-dismiss="modal">Cancel</button>
                            </div>
                            <div>
                                <button type="button" class="btn btn-secondary" id="updateButton" onclick="updateRow(event)">Update</button>
                                <button type="button" class="btn btn-secondary" id="cancel2" data-bs-dismiss="modal">Cancel</button>
                            </div> 
                        </div>
                    </form>
                </div>
                <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                </div>
            </div>
            </div>
        </div>

        <div id="customerTable" style="display: block;">
            <table border="1">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>User Name</th>
                        <th>Email</th>
                        <th>Phone</th>
                        <th>Country</th>
                        <th>City</th>
                        <th>State</th>
                        <th>Zip Code</th>
                        <th>Address 1</th>
                        <th>Address 2</th>
                        <th>Comments</th>
                        <th>Action</th>
                        <th>Edit</th>
                    </tr>
                </thead>
                <tbody>
                    <cfoutput>
                        <cfloop query="usersQuery"> 
                        <tr>
                            <td><span id="#ID#">#ID#</span></td>
                            <td>#firstName#</td>
                            <td>#lastName#</td>
                            <td>#userName#</td>
                            <td>#email#</td>
                            <td>#phone#</td>
                            <td>#country#</td>
                            <td>#city#</td>
                            <td>#state#</td>
                            <td>#zipCode#</td>
                            <td>#address1#</td>
                            <td>#address2#</td>
                            <td>#comments#</td>
                            <td>
                                <button type="button" class="btn btn-primary edit-btn" id="DelButton" onclick="deleteRow(#ID#,event)">Delete</button>
                            </td>
                            <td>
                                <button type="button" class="btn btn-primary edit-btn" id="editButton" onclick="editRow(#ID#,event)">Edit</button> 
                            </td>
                        </tr>
                        </cfloop> 
                    </cfoutput>
                </tbody>
            </table>    
        </div>

        <script type='text/javascript'>

            var currentUserID;

            $(document).ready(function() {
              
                $.validator.addMethod("nameRegex", function(value, element) {
                    return /^[a-zA-Z]+$/.test(value);
                }, "Invalid name");

                $.validator.addMethod("nameRegex", function(value, element) {
                    return /^[a-zA-Z]+$/.test(value);
                }, "Invalid Last name");

                $.validator.addMethod("usernameRegex", function(value, element) {
                    return /^[a-zA-Z0-9]+$/.test(value);
                }, "Invalid Username");

                $.validator.addMethod("emailRegex", function(value, element) {
                    return /^([a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,})$/.test(value);
                }, "Invalid Email Address");

                $.validator.addMethod("phoneRegex", function(value, element) {
                    return /^(\d{3})[- ]?(\d{3})[- ]?(\d{4})$/.test(value);
                }, "Invalid phone number");

                $.validator.addMethod("addressRegex", function(value, element) {
                    return /^[_A-z0-9]*((-|\s)*[_A-z0-9])*$/.test(value);
                }, "Invalid address");

                $.validator.addMethod("zipcodeRegex", function(value, element) {
                    return /^[0-9]{5}$/.test(value);
                }, "Invalid zipcode");

                $('.error-hide').on('focus', function() {
                    $(this).siblings('.error-message, .error-message-border').hide();
                });

                $("#registrationForm").validate({
                    rules: {
                        fname: {
                            required: true,
                            nameRegex: true
                        },
                        lname: {
                            required: true,
                            nameRegex: true
                        },
                        username: {
                            required: true,
                            usernameRegex: true
                        },
                        email: {
                            required: true,
                            emailRegex: true
                        },
                        phone: {
                            required: true,
                            phoneRegex: true
                        },
                        Address1: {
                            required: true,
                            addressRegex: true
                        },
                        zipcode: {
                            required: true,
                            zipcodeRegex: true
                        },
                    },
                    messages: {
                        fname: {
                            required: "First name cannot be empty",
                            nameRegex: "Invalid First name"
                        },
                        lname: {
                            required: "Last name cannot be empty",
                            nameRegex: "Invalid Last name"
                        },
                        username: {
                            required: "Username cannot be empty",
                            usernameRegex: "Invalid Username"
                        },
                        email: {
                            required: "Email cannot be empty",
                            emailRegex: "Invalid Email Address"
                        },
                        phone: {
                            required: "Phone number cannot be empty",
                            phoneRegex: "Invalid Phone Number"
                        },
                        Address1: {
                            required: "Address cannot be empty",
                            addressRegex: "Invalid Address"
                        },
                        zipcode: {
                            required: "Zipcode canot be empty",
                            zipcodeRegex: "Invalid zipcode"
                        }
                    },
                    errorPlacement: function(error, element) {
                        error.appendTo('#' + element.attr('id') + '-error');
                    },
                    success: function(label, element) {
                        $(element).addClass("valid").removeClass("error-message");
                    },
                    highlight: function(element, errorClass, validClass) {
                        $(element).addClass("error-message").removeClass("valid").addClass("error-message-border");
                    },
                    unhighlight: function(element, errorClass, validClass) {
                        $(element).removeClass("error-message").addClass("valid").removeClass("error-message-border");
                    },
                    submitHandler: function(form) {
                        checkCountry();
                        submitForm();
                        $(form).find(':input').blur();
                        form.submit();
                    }
                });
            });
            const checkCountry = ()=> {
                let countrySelected = document.getElementById("country");
                let citySelected = document.getElementById("city");
                let stateSelected = document.getElementById("state");

                let previousCountry;
                
                let countryData = {
                    "Pakistan": {
                    "Cities": ["Lahore", "Karachi", "Islamabad"],
                    "States": ["Punjab", "Sindh"]
                    },
                    "USA": {
                    "Cities": ["Los Vegas", "Los Angeles", "San Francisco"],
                    "States": ["California", "Nevada"]
                    }
                };
                let selectedCountry = countryData[countrySelected.value];
                
                <!--- condition to check the previous country in the edit functionality --->
                if (countrySelected.value !== previousCountry) {
                    citySelected.innerHTML = "<option value=''>Select City</option>";
                    stateSelected.innerHTML = "<option value=''>Select State</option>";
                    previousCountry = countrySelected.value;
                }

                for (let i = 0; i < selectedCountry["Cities"].length; i++) {
                    citySelected.options[citySelected.options.length] = new Option(selectedCountry["Cities"][i], selectedCountry["Cities"][i]);
                }                
                for (let j = 0; j < selectedCountry["States"].length; j++) {
                    stateSelected.options[stateSelected.options.length] = new Option(selectedCountry["States"][j], selectedCountry["States"][j]);
                }
            }
            const submitForm = () => {
                const formData = {
                    fname: document.getElementById("fname").value,
                    lname: document.getElementById("lname").value,
                    username: document.getElementById("username").value,
                    email: document.getElementById("email").value,
                    phone: document.getElementById("phone").value,
                    address1: document.getElementById("Address1").value,
                    address2: document.getElementById("Address2").value,
                    country: document.getElementById("country").value,
                    city: document.getElementById("city").value,
                    state: document.getElementById("state").value,
                    zipcode: document.getElementById("zipcode").value,
                    comments: document.getElementById("textBox").value
                };
                $.ajax({
                    url: 'Index.cfc?method=insertUpdateIntoCustomer&str=insert',
                    type: 'POST',
                    data: formData,
                    datatype: 'JSON',
                    success: function(r) {
                        $('#exampleModal').modal('toggle');
                        //console.log(r.DATA[0]);

                        var key = r.DATA[0];
                        
                        let newRow = "<tr>";
                        var counter = 1;
                        for (let index = 0; index < key.length; index++) {
                            //console.log(key);
                            if(counter === 1){
                                newRow += "<td><span id="+key[index]+">" + key[index] + "</span></td>";       
                            }
                            else{
                                newRow += "<td>" + key[index] + "</td>";       
                            }
                            counter++;
                        }
                        newRow += "<td><button type='button' class='btn btn-primary edit-btn' id='DelButton' onclick='deleteRow(" + key[0] + ", event)'>Delete</button></td>";
                        newRow += "<td><button type='button' class='btn btn-primary edit-btn' id='editButton' onclick='editRow(" + key[0] + ",event)'>Edit></td>";
                        newRow  += "</tr>";
                        //console.log('New Row Data',newRow);
                        $('#customerTable tbody').append(newRow);
                    },
                    error: function(xhr, status, error) {
                        console.error(error);
                    }
                });
            }
            const resetForm = () => { 
              document.getElementById("registrationForm").reset();
              
              $('#exampleModal').on('hidden.bs.modal', function (e) {
                $('.error-hide').removeClass('valid');
                $('.error-hide').removeClass('error-message-border');
                $('.error').hide();
              })
            }
            const deleteRow = (ID,event) =>{
                if(event){
                    event.preventDefault();
                }
                const formData = {
                    id : ID
                }
                $.ajax({
                    url: "Index.cfc?method=deleteFromCustomer",
                    type:'POST',
                    data:formData,
                    datatype:'JSON',
                    success:function(r){

                        var response = JSON.parse(r);
                        if(response){
                            $('#'+ID).closest('tr').remove();
                            console.log("Row Deleted");
                        } else {
                            console.log("Deletion unsuccessful.");
                        }
                    },
                    error: function(xhr, status, error) {
                        console.error(error);
                    }

                });

            }
            const editRow = (ID,event)=>{
                if(event){
                    event.preventDefault();
                }
                $('#exampleModal').modal('show');

                currentUserID = ID;
                const formData = {
                    id:ID
                };

                $.ajax({
                    url:"index.cfc?method=getCustomerByID",
                    method:"POST",
                    data:formData,
                    datatype:'JSON',
                    success:function (r) {
                        //console.log(r);
                        var key = r.DATA[0];
                        $('#fname').val(key[1]); 
                        $('#lname').val(key[2]); 
                        $('#username').val(key[3]); 
                        $('#email').val(key[4]); 
                        $('#phone').val(key[5]);
                        $('#country').val(key[6]); 
                        checkCountry();
                        $('#city').val(key[7]); 
                        $('#zipcode').val(key[8]);  
                        $('#Address1').val(key[9]); 
                        $('#Address2').val(key[10]); 
                        $('#state').val(key[11]); 
                        $('#textBox').val(key[12]);                      


                        <!--- submit and cancel button --->
                        $('#button').hide();
                        $('#cancel1').hide();

                        <!---update and cancel button--->
                        $('#updateButton').show();
                        $('#cancel2').show();

                    },
                    error: function(xhr, status, error) {
                        console.error(error);
                    }

                });
            }
            const updateRow = (event) => {
                if(event){
                    event.preventDefault();
                }
                const formData = {
                    id:currentUserID,
                    fname: document.getElementById("fname").value,
                    lname: document.getElementById("lname").value,
                    username: document.getElementById("username").value,
                    email: document.getElementById("email").value,
                    phone: document.getElementById("phone").value,
                    address1: document.getElementById("Address1").value,
                    address2: document.getElementById("Address2").value,
                    country: document.getElementById("country").value,
                    city: document.getElementById("city").value,
                    state: document.getElementById("state").value,
                    zipcode: document.getElementById("zipcode").value,
                    comments: document.getElementById("textBox").value
                };

                $.ajax({
                    url: "index.cfc?method=insertUpdateIntoCustomer&str=update",
                    method: "POST",
                    data: formData,
                    dataType: 'JSON',
                    success: function (r) {
                        //console.log(r.DATA[0]);
                        $('#exampleModal').modal('toggle');
                        var data = r.DATA[0];
                        data.forEach((item, index)=>{
                            var td = $('#'+currentUserID).parent().parent().children().eq(index);
                            <!--- if index is not ID --->
                            if(index !== 0){
                                td[0].innerHTML = item;
                            }
                        })  
                    },
                    error: function (xhr, status, error) {
                        console.error(error);
                    }
                });
            }
            const addNewUser = ()=>{
                resetForm();
                <!--- submit and cancel button --->
                $('#button').show();
                $('#cancel1').show();
                <!---update and cancel button--->
                $('#updateButton').hide();
                $('#cancel2').hide();   
            }
        </script>
    </body>
</html>