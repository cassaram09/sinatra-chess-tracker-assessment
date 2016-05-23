$('#toggle').click(function(){
<<<<<<< HEAD
    this.checked?$('.draw').show(500):$('.draw').hide(500);
    this.checked?$('.win-lose').hide(500):$('.win-lose').show(500);
    $(this).closest('form').find("select").val("");
});
=======
    this.checked?$('#block').show(1000):$('#block').hide(1000);
});
>>>>>>> parent of 440d7a8... changed model and migrations so draws can belong to more than one user
