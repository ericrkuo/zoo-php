# CPSC 304 Project - Our Zoo 🐎🦄🦓🙉🦍🦁🦒🐨🐼🐢🦉

## Setting up the repo

> Important: these steps assume you're using the cs department servers

1. Set your environment variables
     - Create the file `environment.php` in `~/public_html` and copy the following code:
        ```php
        <?php
        putenv("ORA_USERNAME=ora_(CWL_ID)");
        putenv("ORA_PASSWORD=a(student number)");
        ?>
        ```
    - modify the variables with your correct CWL and student number
        -  note these are the exact same credentials used in tutorial 7 in the php file
2. Copy the `zoo.php` file to the `~/public_html` directory and go to https://www.students.cs.ubc.ca/~YOUR_CWL/zoo.php to see the file

## Workflow for zoo.php file

1. Since the cs department provides the apache server running for us, copy our `zoo.php` file to the `~/public_html` directory, make the changes there.
2. Once you are happy with the changes, copy the `zoo.php` file back into our repository
     - make sure you did not erase anyone's changes by accident
3. Checkout to a new branch.
4. Commit and push your changes.
5. Create a PR (pull request) and tag all of us to review your PR