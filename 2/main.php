#!/bin/php7.4
<?php

/*
    https://adventofcode.com/2023/day/2
*/

$bag = [
    'red' => 12,
    'green' => 13,
    'blue' => 14,
];

$indices = 0;
$powers = 0;

$input = file_get_contents('input.txt');

$lines = explode("\n", $input);
array_pop($lines);

foreach ($lines as $line) {
    [$index, $sets] = explode(':', $line);

    $index = explode(' ', $index)[1];
    $sets = explode('; ', $sets);

    $max = [];

    foreach ($sets as $set) {
        $values = explode(', ', $set);

        foreach ($values as $value) {
            [$count, $color] = explode(' ', trim($value));

            if (!isset($max[$color]) || $count > $max[$color]) {
                $max[$color] = $count; 
            }
        }
    }

    $power = null;
    $possible = true;

    foreach ($max as $color => $count) {
        $power = $power === null ? $count : $power * $count;

        if ($bag[$color] < $count) {
            $possible = false;
        }
    }

    if ($possible) {
        $indices += $index;
    }

    $powers += $power;
}

$answers = [
    'Sum of indices' => $indices,
    'Sum of powers' => $powers,
];

foreach ($answers as $info => $answer) {
    echo str_pad($info, 18, ' ').str_pad($answer, 6, ' ', STR_PAD_LEFT)."\n";
}

?>
