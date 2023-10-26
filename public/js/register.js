document.getElementById('senhaConfirm').addEventListener('input', function() {
    var senha = document.getElementById('senha').value;
    var senhaConfirm = document.getElementById('senhaConfirm').value;
    var senhaErro = document.getElementById('senhaErro');
    var senhaCorreta = document.getElementById('senhaCorreta');

    if (senha !== senhaConfirm) {
        senhaErro.style.display = 'block';
        senhaCorreta.style.display = 'none';
    } else if (senha === senhaConfirm && senha !== "") {
        senhaErro.style.display = 'none';
        senhaCorreta.style.display = 'block';
    } else {
        senhaErro.style.display = 'none';
        senhaCorreta.style.display = 'none';
    }
});

document.querySelector('form').addEventListener('submit', function(event) {
    var senha = document.getElementById('senha').value;
    var senhaConfirm = document.getElementById('senhaConfirm').value;

    if (senha !== senhaConfirm) {
        event.preventDefault();
        document.getElementById('senhaErro').style.display = 'block';
        document.getElementById('senhaCorreta').style.display = 'none';
    }
});