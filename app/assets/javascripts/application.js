// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require activestorage
//= require foundation
//= require turbolinks
//= require_tree .

$(function(){
  $(document).foundation();

  $(document).on('change', "#stocking_product_type", function (){

  });

  $(document).on('keyup', "#stocking_purchase_price", function (){
      stocking_purchase_price = 0
      stocking_shipping_cost = 0
      stocking_use_points = 0

      if ($("#stocking_purchase_price").val()!= "") {
          stocking_purchase_price = parseInt($("#stocking_purchase_price").val())
      }

      if ($("#stocking_shipping_cost").val() != "") {
          stocking_shipping_cost = parseInt($("#stocking_shipping_cost").val())
      }

      if ($("#stocking_use_points").val() != "") {
          stocking_use_points = parseInt($("#stocking_use_points").val())
      }

      purchasing_cost = stocking_purchase_price + stocking_shipping_cost - stocking_use_points

      $("#stocking_purchasing_cost").val(purchasing_cost).change();

      $("#stocking_stocking_products_attributes_0_estimated_price").val(purchasing_cost).change();
  });

  $(document).on('keyup', "#stocking_shipping_cost", function (){
      $('#stocking_purchase_price').trigger('keyup');
  });

  $(document).on('keyup', "#stocking_use_points", function (){
      $('#stocking_purchase_price').trigger('keyup');
  });

  $(document).on('change', "[id^='sale_target']", function (){
      body_price = 0
      lense1_price = 0
      lense2_price = 0

      if ($("#sale_target_body option:selected").text() != "") {
          body_price = parseInt($("#sale_target_body option:selected").text().split('/')[6].replace(",", ""));
      }

      if ($("#sale_target_lense_1 option:selected").text() != "") {
          lense1_price = parseInt($("#sale_target_lense_1 option:selected").text().split('/')[6].replace(",", ""));
      }

      if ($("#sale_target_lense_2 option:selected").text() != "") {
          lense2_price = parseInt($("#sale_target_lense_2 option:selected").text().split('/')[6].replace(",", ""));
      }

      $("#sale_stocking_price").val(body_price + lense1_price + lense2_price);
      $("#sale_cost").val(parseInt($("#sale_stocking_price").val()) + parseInt($("#sale_bonus_price").val())).change();
  });

  $(document).on('keyup', "#sale_stocking_price", function (){
      $("#sale_cost").val(parseInt($("#sale_stocking_price").val()) + parseInt($("#sale_bonus_price").val())).change();
  });

  $(document).on('keyup', "#sale_bonus_price", function (){
      $('#sale_stocking_price').trigger('keyup');
  });

  $(document).on('keyup', "#sale_selling_price", function (){
      $("#sale_fee").val(parseInt($("#sale_selling_price").val()) * 0.1);
      $("#sale_sales").val(parseInt($("#sale_selling_price").val()) - parseInt($("#sale_fee").val()) - parseInt($("#sale_shipping_cost").val())).change();
  });

  $(document).on('keyup', "#sale_shipping_cost", function (){
      $("#sale_sales").val(parseInt($("#sale_selling_price").val()) - parseInt($("#sale_fee").val()) - parseInt($("#sale_shipping_cost").val())).change();
  });

  $(document).on('change', "#sale_cost", function (){
      $("#sale_profit").val(parseInt($("#sale_sales").val()) - parseInt($("#sale_cost").val())).change();
  });

  $(document).on('change', "#sale_sales", function (){
      $('#sale_cost').trigger('change');
  });

  $(document).on('change', "#sale_profit", function (){
      $("#sale_profit_rate").val((parseInt($("#sale_profit").val()) / parseInt($("#sale_sales").val())) * 100);
  });

  $(document).on('change', "[id^='sale_extra_id']", function (){
      if ($(this).is(':checked')) {
          $("#sale_bonus_price").val(parseInt($("#sale_bonus_price").val()) + parseInt($("#sale_extra_price_" + $(this).val()).val()));
      } else {
          $("#sale_bonus_price").val(parseInt($("#sale_bonus_price").val()) - parseInt($("#sale_extra_price_" + $(this).val()).val()));
      }
      $('#sale_stocking_price').trigger('keyup');
  });
});
