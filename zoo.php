<!--Test Oracle file for UBC CPSC304 2018 Winter Term 1
  Created by Jiemin Zhang
  Modified by Simona Radu
  Modified by Jessica Wong (2018-06-22)
  This file shows the very basics of how to execute PHP commands
  on Oracle.  
  Specifically, it will drop a table, create a table, insert values
  update values, and then query for values
 
  IF YOU HAVE A TABLE CALLED "demoTable" IT WILL BE DESTROYED

  The script assumes you already have a server set up
  All OCI commands are commands to the Oracle libraries
  To get the file to work, you must place it somewhere where your
  Apache server can run it, and you must rename it to have a ".php"
  extension.  You must also change the username and password on the 
  OCILogon below to be your ORACLE username and password -->

  <html>
    <head>
        <title>CPSC 304 Project - Zoo</title>
    </head>

    <body>
        <h2>Drop all tables</h2>
        <p>Run <code>start DDL.sql</code> to add all the tables and tuples again.</p>

        <form method="POST" action="zoo.php">
            <!-- if you want another page to load after the button is clicked, you have to specify that page in the action parameter -->
            <input type="hidden" id="resetTablesRequest" name="resetTablesRequest">
            <p><input type="submit" value="Reset" name="reset"></p>
        </form>

        <hr />

        <h2>Insert Values into Animals</h2>
        <form method="POST" action="zoo.php"> <!--refresh page when submitted-->
            <input type="hidden" id="insertQueryRequest" name="insertQueryRequest">
            <style type="text/css">
            .tg  {border-collapse:collapse;border-spacing:0;}
            .tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
            overflow:hidden;padding:10px 5px;word-break:normal;}
            .tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
            font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
            .tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
            .tg .tg-0lax{text-align:left;vertical-align:top}
            </style>
            <table class="tg">
            <thead>
            <tr>
                <th class="tg-0pky">AnimalID</th>
                <th class="tg-0pky"><input type="number" name="animalID" value="12345"></th>
            </tr>
            </thead>
            <tbody>
            <tr>
                <td class="tg-0pky">Name</td>
                <td class="tg-0pky"><input type="text" name="name" value="SAMPLE_NAME"></td>
            </tr>
            <tr>
                <td class="tg-0pky">BreedID</td>
                <td class="tg-0pky">
                <select name="breedID">
                    <?php
                        include('environment.php');
                        handleRequest('handleGetBreedsRequest');
                    ?>
                </select>
                </td>
            </tr>
            <tr>
                <td class="tg-0pky">EnclosureID</td>
                <td class="tg-0pky">
                <select name="enclosureID">
                    <?php
                        // https://stackoverflow.com/questions/18409531/php-drop-down-list-populated-by-oracle-database-rows
                        include('environment.php');
                        handleRequest('handleGetEnclosuresRequest');
                    ?>
                </select>
                </td>
            </tr>
            <tr>
                <td class="tg-0pky">Birthdate</td>
                <td class="tg-0pky"><input type="date" name="birthDate" value="2000-01-01"></td>
            </tr>
            <tr>
                <td class="tg-0pky">Sex</td>
                <td class="tg-0pky">
                    <select name="sex">
                        <option value="F">Female</option>
                        <option value="M">Male</option>
                        <option value="U">Not known</option>
                        <option value="NA">Not applicable</option>
                    </select>
                </td>
            </tr>
            <tr>
                <td class="tg-0pky">Age</td>
                <td class="tg-0pky"><input type="number" name="age" value="100"></td>
            </tr>
            <tr>
                <td class="tg-0pky">Weight</td>
                <td class="tg-0pky"><input type="number" name="weight" value="70"></td>
            </tr>
            <tr>
                <td class="tg-0pky">Arrival Date</td>
                <td class="tg-0pky"><input type="date" name="arrivalDate" value="2000-01-01"></td>
            </tr>
            <tr>
                <td class="tg-0pky">Deceased Date</td>
                <td class="tg-0pky"><input type="date" name="deceasedDate"></td>
            </tr>
            <tr>
                <td class="tg-0pky">Biological Data</td>
                <td class="tg-0pky"><input type="text" name="bioData"></td>
            </tr>
            </tbody>
            </table>
            <br/>

            <input type="submit" value="Insert" name="insertSubmit"></p>
        </form>

        <hr />

        <h2>Update Name in Animals - NOT DONE</h2>
        <p>The values are case sensitive and if you enter in the wrong case, the update statement will not do anything.</p>

        <form method="POST" action="zoo.php"> <!--refresh page when submitted-->
            <input type="hidden" id="updateQueryRequest" name="updateQueryRequest">
            Old Name: <input type="text" name="oldName"> <br /><br />
            New Name: <input type="text" name="newName"> <br /><br />

            <input type="submit" value="Update" name="updateSubmit"></p>
        </form>

        <hr />

        <h2>Count the Tuples in Animals</h2>
        <form method="GET" action="zoo.php"> <!--refresh page when submitted-->
            <input type="hidden" id="countTupleRequest" name="countTupleRequest">
            <input type="submit" name="countTuples"></p>
        </form>

        <hr />

        <h2>Display the Tuples in Animals</h2>
        <form method="GET" action="zoo.php"> <!--refresh page when submitted-->
            <input type="hidden" id="displayTupleRequest" name="displayTupleRequest">
            <input type="submit" name="displayTuples"></p>
        </form>
        
        <hr />

        <h2>JOIN - Find who feeds an animal, what the animal eats, and when they need to be fed - filter amongst specific dates</h2>
        <form method="GET" action="zoo.php"> <!--refresh page when submitted-->
            <input type="hidden" id="joinTupleRequest" name="joinTupleRequest">

            <style type="text/css">
            .tg  {border-collapse:collapse;border-spacing:0;}
            .tg td{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
            overflow:hidden;padding:10px 5px;word-break:normal;}
            .tg th{border-color:black;border-style:solid;border-width:1px;font-family:Arial, sans-serif;font-size:14px;
            font-weight:normal;overflow:hidden;padding:10px 5px;word-break:normal;}
            .tg .tg-0pky{border-color:inherit;text-align:left;vertical-align:top}
            .tg .tg-0lax{text-align:left;vertical-align:top}
            </style>
            <table class="tg">
            <thead>
            <tr>
                <td class="tg-0pky">From</td>
                <td class="tg-0pky"><input type="date" name="fromDate" value="2021-10-01"></td>
            </tr>
            <tr>
                <td class="tg-0pky">To</td>
                <td class="tg-0pky"><input type="date" name="toDate" value="2021-12-31"></td>
            </tr>
            </thead>
            </table>
            <br/>

            <input type="submit" name="joinTuples"></p>
        </form>

        <hr />

        <h2>Delete an Event</h2>
        <form method="POST" action="zoo.php"> <!--refresh page when submitted-->
            <input type="hidden" id="deleteRequest" name="deleteRequest">
            <label for="deleteMenu">Choose an Event to Delete</label>
            <select name="eventID">
                        <?php
                            include('environment.php');
                            handleRequest('handleGetEventsRequest');
                        ?>
               
            </select>
            <input type="submit" name="deleteTuple"></p>
        </form>

        <hr />


        
        <h2>Division - Find visitors who reserved all events</h2>
        <form method="GET" action="zoo.php"> <!--refresh page when submitted-->
            <input type="hidden" id="divisionRequest" name="divisionRequest">
            <input type="submit" name="divisionTuples"></p>
        </form>

        <hr />

        <h2> Find Oldest Animal of Each Breed</h2>
        <form method="GET" action="zoo.php"> <!--refresh page when submitted-->
            <input type="hidden" id="oldestAnimalPerBreedRequest" name="oldestAnimalPerBreedRequest">
            <input type="submit" name="oldestAnimalPerBreedTuples"></p>
        </form>

        <hr />

        <?php
        include('environment.php');

		//this tells the system that it's no longer just parsing html; it's now parsing PHP

        $success = True; //keep track of errors so it redirects the page only if there are no errors
        $db_conn = NULL; // edit the login credentials in connectToDB()
        $show_debug_alert_messages = False; // set to True if you want alerts to show you which methods are being triggered (see how it is used in debugAlertMessage())

        function debugAlertMessage($message) {
            global $show_debug_alert_messages;

            if ($show_debug_alert_messages) {
                echo "<script type='text/javascript'>alert('" . $message . "');</script>";
            }
        }

        function executePlainSQL($cmdstr) { //takes a plain (no bound variables) SQL command and executes it
            //echo "<br>running ".$cmdstr."<br>";
            global $db_conn, $success;

            $statement = OCIParse($db_conn, $cmdstr); 
            //There are a set of comments at the end of the file that describe some of the OCI specific functions and how they work

            if (!$statement) {
                echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
                $e = OCI_Error($db_conn); // For OCIParse errors pass the connection handle
                echo htmlentities($e['message']);
                $success = False;
            }

            $r = OCIExecute($statement, OCI_DEFAULT);
            if (!$r) {
                echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
                $e = oci_error($statement); // For OCIExecute errors pass the statementhandle
                echo htmlentities($e['message']);
                $success = False;
            }

			return $statement;
		}

        function executeBoundSQL($cmdstr, $list) {
            /* Sometimes the same statement will be executed several times with different values for the variables involved in the query.
		In this case you don't need to create the statement several times. Bound variables cause a statement to only be
		parsed once and you can reuse the statement. This is also very useful in protecting against SQL injection. 
		See the sample code below for how this function is used */

			global $db_conn, $success;
			$statement = OCIParse($db_conn, $cmdstr);

            if (!$statement) {
                echo "<br>Cannot parse the following command: " . $cmdstr . "<br>";
                $e = OCI_Error($db_conn);
                echo htmlentities($e['message']);
                $success = False;
            }

            foreach ($list as $tuple) {
                foreach ($tuple as $bind => $val) {
                    //echo $val;
                    //echo "<br>".$bind."<br>";
                    OCIBindByName($statement, $bind, $val);
                    unset ($val); //make sure you do not remove this. Otherwise $val will remain in an array object wrapper which will not be recognized by Oracle as a proper datatype
				}

                $r = OCIExecute($statement, OCI_DEFAULT);
                if (!$r) {
                    echo "<br>Cannot execute the following command: " . $cmdstr . "<br>";
                    $e = OCI_Error($statement); // For OCIExecute errors, pass the statementhandle
                    echo htmlentities($e['message']);
                    echo "<br>";
                    $success = False;
                }
            }

            return $statement;
        }

        function printResult($result, $message) { //prints results from a select statement
            echo "<br>" . $message . "<br>";

            // https://stackoverflow.com/questions/2970936/how-to-echo-out-table-rows-from-the-db-php
            echo("<table border='1'>");
            $first_row = true;
            while ($row = OCI_Fetch_Array($result, OCI_ASSOC + OCI_RETURN_NULLS)) {
                if ($first_row) {
                    $first_row = false;
                    // Output header row from keys.
                    echo '<tr>';
                    foreach($row as $key => $field) {
                        echo '<th>' . htmlspecialchars($key) . '</th>';
                    }
                    echo '</tr>';
                }
                echo '<tr>';
                foreach($row as $key => $field) {
                    echo '<td>' . htmlspecialchars($field) . '</td>';
                }
                echo '</tr>';
            }
            echo("</table>");
        }

        function connectToDB() {
            global $db_conn;
            
            // Your username is ora_(CWL_ID) and the password is a(student number). For example, 
			// ora_platypus is the username and a12345678 is the password.
            $db_conn = OCILogon(getenv("ORA_USERNAME"), getenv("ORA_PASSWORD"), "dbhost.students.cs.ubc.ca:1522/stu");

            if ($db_conn) {
                debugAlertMessage("Database is Connected");
                return true;
            } else {
                debugAlertMessage("Cannot connect to Database");
                $e = OCI_Error(); // For OCILogon errors pass no handle
                echo htmlentities($e['message']);
                return false;
            }
        }

        function disconnectFromDB() {
            global $db_conn;

            debugAlertMessage("Disconnect from Database");
            OCILogoff($db_conn);
        }

        function handleUpdateRequest() {
            global $db_conn;

            $old_name = $_POST['oldName'];
            $new_name = $_POST['newName'];

            // you need the wrap the old name and new name values with single quotations
            executePlainSQL("UPDATE demoTable SET name='" . $new_name . "' WHERE name='" . $old_name . "'");
            OCICommit($db_conn);
        }

        function handleResetRequest() {
            global $db_conn;
            // Drop old table
            executePlainSQL("drop table RESPONSIBLEFOR cascade constraints");
            executePlainSQL("drop table TRAINEDBY cascade constraints");
            executePlainSQL("drop table MEDICALRECORDS cascade constraints");

            executePlainSQL("drop table VETERINARIANS cascade constraints");
            executePlainSQL("drop table FOODSUPPLIES cascade constraints");
            executePlainSQL("drop table FEEDINGSCHEDULES cascade constraints");
            executePlainSQL("drop table MADEUPOF cascade constraints");
            executePlainSQL("drop table FEED cascade constraints");
            executePlainSQL("drop table VISITORS cascade constraints");
            executePlainSQL("drop table VISITORRECORDS cascade constraints");
            executePlainSQL("drop table EVENTS cascade constraints");
            executePlainSQL("drop table RESERVE cascade constraints");
            executePlainSQL("drop table FEATUREDIN cascade constraints");
            executePlainSQL("drop table HOSTEDBY cascade constraints");

            executePlainSQL("drop table BIOMES cascade constraints");
            executePlainSQL("drop table ENCLOSUREDIMENSIONS cascade constraints");
            executePlainSQL("drop table ENCLOSURES cascade constraints");
            executePlainSQL("drop table SPECIES cascade constraints");
            executePlainSQL("drop table BREEDS cascade constraints");
            executePlainSQL("drop table ANIMALS cascade constraints");
            executePlainSQL("drop table PARENTOF cascade constraints");
            executePlainSQL("drop table EMPLOYEES cascade constraints");
            executePlainSQL("drop table FEEDERS cascade constraints");
            executePlainSQL("drop table TRAINERS cascade constraints");
            executePlainSQL("drop table KEEPERS cascade constraints");

            OCICommit($db_conn);
        }

        function handleInsertRequest() {
            global $db_conn;

            //Getting the values from user and insert data into the table
            $tuple = array (
                ":bind1" => $_POST['animalID'],
                ":bind2" => $_POST['name'],
                ":bind3" => $_POST['breedID'],
                ":bind4" => $_POST['enclosureID'],
                ":bind5" => $_POST['birthDate'],
                ":bind6" => $_POST['sex'],
                ":bind7" => $_POST['age'],
                ":bind8" => $_POST['weight'],
                ":bind9" => $_POST['arrivalDate'],
                ":bind10" => $_POST['deceasedDate'],
                ":bind11" => $_POST['bioData']
            );

            $alltuples = array (
                $tuple
            );

            executeBoundSQL(
                "INSERT INTO ANIMALS(animalID , name , breedID , enclosureID ,
                                     birthDate , sex , age , weight ,
                                     arrivalDate , deceasedDate , bioData)
                VALUES (:bind1, :bind2, :bind3, :bind4,
                (TO_DATE(:bind5 , 'yyyy/mm/dd')), :bind6, :bind7, :bind8,
                (TO_DATE(:bind9 , 'yyyy/mm/dd')), (TO_DATE(:bind10 , 'yyyy/mm/dd')), :bind11)"
                , $alltuples);
            OCICommit($db_conn);
        }

        function handleGetBreedsRequest() {
            // https://stackoverflow.com/questions/18409531/php-drop-down-list-populated-by-oracle-database-rows
            global $db_conn;
            $result = executePlainSQL("SELECT breedID, breed FROM BREEDS ORDER BY breed");
            while ($row = oci_fetch_array($result, OCI_RETURN_NULLS+OCI_ASSOC))
            {
                echo "<option value=\" ". $row['BREEDID'] . " \">" . $row['BREED'] . "</option>";
            }
        }

        function handleGetEnclosuresRequest() {
            global $db_conn;
            $result = executePlainSQL("SELECT enclosureID, name FROM ENCLOSURES ORDER BY name");
            while ($row = oci_fetch_array($result, OCI_RETURN_NULLS+OCI_ASSOC))
            {
                echo "<option value=\" ". $row['ENCLOSUREID'] . " \">" . $row['NAME'] . "</option>";
            }
        }

        function handleGetEventsRequest() {
            global $db_conn;
            $result = executePlainSQL("SELECT eventID, name FROM EVENTS ORDER BY name");
            while ($row = oci_fetch_array($result, OCI_RETURN_NULLS+OCI_ASSOC))
            {
                echo "<option value=\" ". $row['EVENTID'] . " \">" . $row['NAME'] . "</option>";
            }
        }

        function handleCountRequest() {
            global $db_conn;

            $result = executePlainSQL("SELECT Count(*) FROM Animals");

            if (($row = oci_fetch_row($result)) != false) {
                echo "<br> The number of tuples in Animals: " . $row[0] . "<br>";
            }
        }

        function handleDisplayRequest() {
            global $db_conn;

            $result = executePlainSQL("SELECT * FROM Animals");

            printResult($result, "Retrieved data from table Animals:");
        }

        function handleJoinRequest() {
            global $db_conn;

            $tuple = array (
                ":bind1" => $_GET['fromDate'],
                ":bind2" => $_GET['toDate'],
            );

            $alltuples = array (
                $tuple
            );

            $result = executeBoundSQL(
                "SELECT A.animalID, E.employeeID, FS.supplyID,
                        A.name as AnimalName,
                        E.firstName, E.lastName,
                        FS.name as SupplyName, 
                        TO_CHAR(M.dateTime, 'yyyy/mm/dd HH24:MI') as dateTime
                FROM Animals A, MadeUpOf M, FoodSupplies FS, Employees E
                WHERE A.animalID = M.animalID
                AND E.employeeID = M.feederID
                AND FS.supplyID = M.supplyID
                AND TRUNC(M.dateTime) >= (TO_DATE(:bind1 , 'yyyy/mm/dd'))
                AND TRUNC(M.dateTime) <= (TO_DATE(:bind2 , 'yyyy/mm/dd'))
                ORDER BY A.animalID, M.dateTime"
                , $alltuples
            );
            
            OCICommit($db_conn);
            printResult($result, "Result of JOIN between " . $_GET['fromDate'] . " and " . $_GET['toDate']);
        }

        function handleDeleteRequest() {
            global $db_conn;
            
 
            $eventToDelete = $_POST['eventID'];
            $eventNameDeleted = executePlainSQL("SELECT name, eventID FROM Events WHERE eventID='$eventToDelete' ORDER BY eventID");
            $remainingEvents = executePlainSQL("SELECT name, eventID FROM Events WHERE eventID <> '$eventToDelete' ORDER BY eventID");
            $reserveBeforeDelete = executePlainSQL("SELECT r.eventID, visitorID, name FROM Reserve r, Events e WHERE r.eventID = e.eventID ORDER BY e.eventID");
            $hostedByBeforeDelete = executePlainSQL("SELECT h.eventID, trainerID, name FROM HostedBy h, Events e WHERE h.eventID = e.eventID ORDER BY e.eventID");
            $featuredInBeforeDelete = executePlainSQL("SELECT f.eventID, animalID, name FROM FeaturedIn f, Events e WHERE f.eventID = e.eventID ORDER BY e.eventID");

            
           executePlainSQL("DELETE FROM Events WHERE eventID='$eventToDelete'");

           $reserveAfterDelete = executePlainSQL("SELECT r.eventID, visitorID, name FROM Reserve r, Events e WHERE r.eventID = e.eventID ORDER BY e.eventID");
           $hostedByAfterDelete = executePlainSQL("SELECT h.eventID, trainerID, name FROM HostedBy h, Events e WHERE h.eventID = e.eventID ORDER BY e.eventID");
           $featuredInAfterDelete = executePlainSQL("SELECT f.eventID, animalID, name FROM FeaturedIn f, Events e WHERE f.eventID = e.eventID ORDER BY e.eventID");
           
            printResult($eventNameDeleted, "Event Deleted:");
            printResult($remainingEvents, "Events Remaining:");
            printResult($reserveBeforeDelete, "Reserve Table Before Deletion of Event:");
            printResult($reserveAfterDelete, "Reserve Table After Deletion of Event:");
            printResult($hostedByBeforeDelete, "HostedBy Table Before Deletion of Event:");
            printResult($hostedByAfterDelete, "HostedBy Table After Deletion of Event:");
            printResult($featuredInBeforeDelete, "FeaturedIn Table Before Deletion of Event:");
            printResult($featuredInAfterDelete, "FeaturedIn Table After Deletion of Event:");
    
            OCICommit($db_conn);
        }

        function handleDivisionRequest() {
            global $db_conn;

            $result = executePlainSQL(
                "SELECT v.visitorID, v.firstName, v.lastName
                FROM Visitors v
                WHERE NOT EXISTS (
                    SELECT eventID FROM Events
                    MINUS
                    SELECT r.eventID
                    FROM Reserve r
                    WHERE r.visitorID = v.visitorID)"
            );

            printResult($result, "Retrieved data for divison query:");

            $result = executePlainSQL(
                "SELECT v.visitorID, e.eventID, v.firstName, v.lastName, e.name
                FROM Visitors v, Events e, Reserve r
                WHERE r.visitorID = v.visitorID AND r.eventID = e.eventID
                ORDER BY v.visitorID, e.eventID"
            );

            printResult($result, "All visitors and the events they reserved:");

            $result = executePlainSQL(
                "SELECT e.eventID, e.name
                FROM Events e
                ORDER BY e.eventID"
            );

            printResult($result, "All events in the zoo:");
        }

        function handleOldestAnimalPerBreedRequest() {
            global $db_conn; 

            $result=executePlainSQL("SELECT b.breed, MAX(age) as \"MAX AGE\" FROM Animals a, Breeds b WHERE a.breedID = b.breedID 
                                    GROUP BY b.breed ORDER BY b.breed");
            $allAges=executePlainSQL("SELECT b.breed, a.age, a.name, a.animalID FROM Animals a, Breeds b WHERE a.breedID = b.breedID ORDER BY b.breed, a.age");

            printResult($result,"Oldest Animal of Each Breed");
            printResult($allAges, "All Ages of Animals of Each Breed");
        }

        // Check whether the name and requestName exist in the array request ($_GET, $_POST, etc.)
        function requestValid(array $request, $name, $requestName) {
            return isset($request[$name]) && array_key_exists($requestName, $request);
        }

        // Pass the name of the function you want to execute, this will connect to the database, execute the query, and disconnect from the DB
        function handleRequest($function) {
            if (connectToDB()) {
                $function();
                disconnectFromDB();
            }
        }
        
        if (requestValid($_POST, 'reset', 'resetTablesRequest')) {
            handleRequest('handleResetRequest');
        }
        else if (requestValid($_GET, 'displayTuples', 'displayTupleRequest')) {
            handleRequest('handleDisplayRequest');
        }
        else if (requestValid($_GET, 'countTuples', 'countTupleRequest')) {
            handleRequest('handleCountRequest');
        }
        else if (requestValid($_POST, 'updateSubmit', 'updateQueryRequest')) {
            handleRequest('handleUpdateRequest');
        }
        else if (requestValid($_POST, 'insertSubmit', 'insertQueryRequest')) {
            handleRequest('handleInsertRequest');
        }
        else if (requestValid($_GET, 'joinTuples', 'joinTupleRequest')) {
            handleRequest('handleJoinRequest');
        }    
        else if (requestValid($_POST, 'deleteTuple', 'deleteRequest')) {
            handleRequest('handleDeleteRequest');
        }
        else if (requestValid($_GET, 'divisionTuples', 'divisionRequest')) {
            handleRequest('handleDivisionRequest');
        } 
        else if (requestValid($_GET, 'oldestAnimalPerBreedTuples', 'oldestAnimalPerBreedRequest')) {
            handleRequest('handleOldestAnimalPerBreedRequest');
        }
		?>
	</body>
</html>