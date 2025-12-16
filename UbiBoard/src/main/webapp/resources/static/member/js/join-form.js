var isIdChecked = false; // 아이디 중복 확인 여부

// 문서 로딩 완료 후 실행될 이벤트들 통합
$(document).ready(function(){
    
    // 1. 아이디 입력값 변경 시 중복 확인 초기화
    $("#userId").on("input", function(){
        isIdChecked = false;
    });

    // 2. 휴대전화 입력 시 자동 하이픈(-) 및 숫자만 입력
    $("input[name='phone']").on("input", function() {
        let number = $(this).val().replace(/[^0-9]/g, ""); 
        let tel = "";

        if (number.length < 4) {
            return $(this).val(number);
        } else if (number.length < 8) {
            tel += number.substr(0, 3) + "-" + number.substr(3);
        } else if (number.length < 12) {
            tel += number.substr(0, 3) + "-" + number.substr(3, 4) + "-" + number.substr(7);
        } else {
            tel += number.substr(0, 3) + "-" + number.substr(3, 4) + "-" + number.substr(7, 4);
        }
        $(this).val(tel);
    });

    // 3. 생년월일 달력 (Datepicker) 설정
    $("input[name='birth']").datepicker({
        dateFormat: 'yy-mm-dd',
        changeMonth: true,
        changeYear: true,
        yearRange: '1900:2025',
        maxDate: 0,
        dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
        monthNamesShort: ['1월','2월','3월','4월','5월','6월','7월','8월','9월','10월','11월','12월']
    });

}); // end ready


// ==========================================
// 함수 정의 영역
// ==========================================

// 회원가입 폼 유효성 검사 (submit 버튼 클릭 시 실행)
function checkForm() {
    var f = document.joinForm;

    // 1. 아이디 필수 입력
    if(f.userId.value.trim() == "") {
        alert("아이디를 입력해주세요.");
        f.userId.focus();
        return false;
    }
    
    // 2. 정규식 검사 (아이디) - 위치 이동됨!
    var idReg = /^[a-z0-9]{5,20}$/;
    if (!idReg.test(f.userId.value)) {
        alert("아이디는 영문 소문자와 숫자를 포함해 5~20자로 입력해야 합니다.");
        f.userId.focus();
        return false;
    }

    // 3. 중복 확인 여부
    if(!isIdChecked) {
        alert("아이디 중복 확인을 해주세요.");
        return false;
    }

    // 4. 비밀번호 필수 입력
    if(f.password.value == "") {
        alert("비밀번호를 입력해주세요.");
        f.password.focus();
        return false;
    }

    // 5. 정규식 검사 (비밀번호) - 위치 이동됨!
    var pwReg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{9,25}$/;
    if (!pwReg.test(f.password.value)) {
        alert("비밀번호는 영문, 숫자, 특수문자를 포함하여 9자 이상이어야 합니다.");
        f.password.focus();
        return false;
    }

    // 6. 비밀번호 일치 확인
    if(f.password.value != f.passwordConfirm.value) {
        alert("비밀번호가 일치하지 않습니다.");
        f.passwordConfirm.focus();
        return false;
    }

    // 7. 이름 입력 확인
    if(f.name.value.trim() == "") {
        alert("이름을 입력해주세요.");
        f.name.focus();
        return false;
    }

    // 8. 전화번호 입력 확인
    if(f.phone.value.trim() == "") {
        alert("휴대전화 번호를 입력해주세요.");
        f.phone.focus();
        return false;
    }

    f.submit();
}

// 아이디 중복 체크
function checkId() {
    var userId = $("#userId").val();

    if(userId.trim() == "") {
        alert("아이디를 입력해주세요.");
        $("#userId").focus();
        return;
    }

    $.ajax({
        // JSP에서 선언한 전역변수 contextPath 사용
        url: contextPath + "/member/idCheck", 
        type: "post",
        data: { "userId" : userId },
        dataType: 'json',
        success: function(result) {
            if(result == 1) {
                alert("이미 사용 중인 아이디입니다.");
                $("#userId").val("").focus();
                isIdChecked = false;
            } else {
                alert("사용 가능한 아이디입니다.");
                isIdChecked = true;
            }
        },
        error: function() {
            alert("서버 통신 오류입니다. 잠시 후 다시 시도해주세요.");
        }
    });
}

// 주소 찾기 (Daum API)
function openZipSearch() {
    new daum.Postcode({
        oncomplete: function(data) {
            $("#zipCode").val(data.zonecode);
            $("#addr1").val(data.address);
            $("#addr2").focus();
        }
    }).open();
}

// 이메일 도메인 선택
function changeEmailDomain() {
    var domain = $("#emailDomainSelect").val();
    if(domain == "direct") {
        $("#emailDomain").val("").attr("readonly", false).focus();
    } else {
        $("#emailDomain").val(domain).attr("readonly", true);
    }
}