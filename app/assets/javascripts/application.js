// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
  function split( val ) {
    return val.split( /,\s*/ );
  }
  function extractLast( term ) {
    return split( term ).pop();
  }

  $("#stat_actors")
  .bind( "keydown", function( event ) {
    if ( event.keyCode === $.ui.keyCode.TAB &&
      $( this ).autocomplete( "instance" ).menu.active ) {
        event.preventDefault();
      }
    })
    .autocomplete({
      source: function( request, response ) {
        $.getJSON( "/query", {
          name: extractLast( request.term )
        }, response );
      },
      search: function() {
        var term = extractLast( this.value );
        if ( term.length < 2 ) {
          return false;
        }
      },
      focus: function() {
        return false;
      },
      select: function( event, ui ) {
        var terms = split( this.value );
        terms.pop();
        terms.push( ui.item.value );
        terms.push( "" );
        this.value = terms.join( ", " );
        return false;
      }
    });
  });
