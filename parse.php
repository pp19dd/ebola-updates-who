<?php

// works in either browser or CLI
// takes an entire page and spits out a few links
if( isset( $_GET['file']) ) {
    $file = $_GET['file'];
} else {
    $file = $argv[1];
}

$t = trim(file_get_contents($file));

$doc = new DOMDocument();
@$doc->loadHTML($t);
$xpath = new DOMXpath($doc);

$links = $xpath->query("//span[@class='field-content']//a");

foreach( $links as $link ) {
    echo $link->nodeValue . "\n";
}
