$('#toggle').click(function(){
    this.checked?$('.draw').show(500):$('.draw').hide(500);
    this.checked?$('.win-lose').hide(500):$('.win-lose').show(500);
    $(this).closest('form').find("select").val("");
});
