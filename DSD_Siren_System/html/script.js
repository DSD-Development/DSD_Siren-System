$(function() {
    window.addEventListener("message", function(event) {
        var data = event.data;
        if (data.open) {
            $(".container").show();
        } else {
            $(".container").hide();
        }
    })

    $("#siren1").click(function() {
        $.post("https://" + GetParentResourceName() + "/action", JSON.stringify({
            acc: 'siren1'
        }))
    })

    $("#siren2").click(function() {
        $.post("https://" + GetParentResourceName() + "/action", JSON.stringify({
            acc: 'siren2'
        }))
    })

    $("#siren3").click(function() {
        $.post("https://" + GetParentResourceName() + "/action", JSON.stringify({
            acc: 'siren3'
        }))
    })

    $("#pauseinp").click(function() {
        $.post("https://" + GetParentResourceName() + "/action", JSON.stringify({
            acc: 'pause'
        }))
    })

    setInterval(() => {
        var volumeinp = $("#volinp").val();
        $.post("https://" + GetParentResourceName() + "/action", JSON.stringify({
            acc: 'setvol',
            vol: volumeinp
        }))
    }, 1200);

    $(document).keyup(function(e) {
        if (e.key == "Escape") {
            $.post("https://" + GetParentResourceName() + "/action", JSON.stringify({
                acc: 'close'
            }))
            $(".container").hide();
        }
    })
})