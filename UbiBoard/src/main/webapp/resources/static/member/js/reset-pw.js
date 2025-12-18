$(document).ready(function() {
    // 정규식: 9~20자, 영문/숫자/특수문자 모두 포함
    const pwRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+|~={}\[\]:;<>?,./]).{9,20}$/;
    const userId = $("input[name='userId']").val(); // hidden으로 넘어온 userId

    // 1. 새 비밀번호 실시간 검사
    $("#userPw").on("keyup blur", function() {
        const pw = $(this).val();
        const $msg = $("#pwMsg");

        if (pw === "") {
            $msg.hide();
        } else if (!pwRegex.test(pw)) {
            $msg.text("9~20자 이내, 영문/숫자/특수문자를 모두 포함해야 합니다.")
                .removeClass("success-msg").show();
        } else if (pw === userId) {
            $msg.text("아이디와 동일한 비밀번호는 사용할 수 없습니다.")
                .removeClass("success-msg").show();
        } else {
            $msg.text("사용 가능한 비밀번호입니다.")
                .addClass("success-msg").show();
        }
        checkPwMatch(); // 비밀번호 확인란과 일치 여부 재체크
    });

    // 2. 비밀번호 확인 실시간 검증
$("#userPwConfirm").on("keyup focusout", function() {
        checkPwMatch();
    });

// 일치 여부 체크 공통 함수
    function checkPwMatch() {
        const pw = $("#userPw").val();
        const confirmPw = $("#userPwConfirm").val();
        const $confirmMsg = $("#pwConfirmMsg");

        if (confirmPw === "") {
            $confirmMsg.hide();
        } else if (pw !== confirmPw) {
            $confirmMsg.text("비밀번호가 일ย치하지 않습니다.")
                .removeClass("success-msg").show();
        } else {
            $confirmMsg.text("비밀번호가 일치합니다.")
                .addClass("success-msg").show();
        }
    }
});

// 다시 입력 (초기화)
function resetForm() {
    $("#userPw").val("");
    $("#userPwConfirm").val("");
    $(".error-msg").hide();
    $("#userPw").focus();
}

// 최종 변경 전 검증
function changePwCheck() {
    const pw = $("#userPw").val();
    const pwConfirm = $("#userPwConfirm").val();
    const userId = $("input[name='userId']").val();
    const pwRegex = /^(?=.*[a-zA-Z])(?=.*[0-9])(?=.*[!@#$%^&*()_+|~={}\[\]:;<>?,./]).{9,20}$/;

    if (!pwRegex.test(pw)) {
        alert("비밀번호 형식을 확인해주세요.");
        $("#userPw").focus();
        return;
    }
    if (pw === userId) {
        alert("아이디와 동일한 비밀번호는 사용할 수 없습니다.");
        $("#userPw").focus();
        return;
    }
    if (pw !== pwConfirm) {
        alert("비밀번호 확인이 일치하지 않습니다.");
        $("#userPwConfirm").focus();
        return;
    }

    if (confirm("비밀번호를 변경하시겠습니까?")) {
        document.resetPwForm.submit();
    }
}