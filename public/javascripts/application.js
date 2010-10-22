// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function countLeftChars(){
    var textField = document.getElementById('micropost_content');
    var countChar = 140 - textField.value.length
    document.getElementById('charCounter').innerHTML = countChar;
}