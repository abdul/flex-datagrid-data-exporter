<?phpheader('Content-type: text/csv');$csvData = ($_POST['csvdata']) ? $_POST['csvdata'] : $_GET['csvdata'];echo  $csvData;?>