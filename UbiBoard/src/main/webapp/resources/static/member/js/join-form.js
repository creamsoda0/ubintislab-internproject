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
    
    // 정규식 선언 (영문+숫자+특수문자 9자 이상)
    var pwReg = /^(?=.*[a-zA-Z])(?=.*[!@#$%^*+=-])(?=.*[0-9]).{9,25}$/;

    // [1] 비밀번호 유효성 실시간 검사
    $("#password").on("input", function(){
        var pw = $(this).val();
        var $msg = $("#pwMsg"); // 메시지 띄울 span 태그

        if(pw == "") {
            $msg.text(""); // 비어있으면 메시지 지움
            return;
        }

        if(!pwReg.test(pw)) {
            // 조건 불만족
            $msg.text("비밀번호 규칙에 맞지 않습니다 (9자 이상/25자 이하, 영문/숫자/특수문자).");
            $msg.removeClass("success-msg"); // 초록색 제거
        } else {
            // 조건 만족
            $msg.text("사용 가능한 비밀번호입니다.");
            $msg.addClass("success-msg");    // 초록색 추가
        }
        
        // 비밀번호를 고치면 '확인' 칸도 다시 검사해야 함
        $("#passwordConfirm").trigger("input"); 
    });

    // [2] 비밀번호 일치 여부 실시간 검사
    $("#passwordConfirm").on("input", function(){
        var pw = $("#password").val();
        var pwConfirm = $(this).val();
        var $msg = $("#pwConfirmMsg");

        if(pwConfirm == "") {
            $msg.text("");
            return;
        }

        if(pw != pwConfirm) {
            // 불일치
            $msg.text("비밀번호가 일치하지 않습니다.");
            $msg.removeClass("success-msg");
        } else {
            // 일치
            $msg.text("비밀번호가 일치합니다.");
            $msg.addClass("success-msg");
        }
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
    
    // 7-1. 이름 정규식 검사
    // 한글(가-힣)과 영문(a-z, A-Z)만 허용, 2~20자
    var nameReg = /^[가-힣a-zA-Z]{2,20}$/;
    if (!nameReg.test(f.name.value)) {
        alert("이름은 한글 또는 영문으로 2~20자 이내로 입력해주세요.\n(숫자나 특수문자, 공백은 사용할 수 없습니다.)");
        f.name.focus();
        return false;
    }

	// 8. 휴대전화 번호 입력 확인 및 정규식 검사
    var phoneValue = f.phone.value.trim();
    if(phoneValue == "") {
        alert("휴대전화 번호를 입력해주세요.");
        f.phone.focus();
        return false;
    }

    // 휴대전화 정규식: 01x-xxxx-xxxx 형식 (하이픈 필수)
    var phoneReg = /^01(?:0|1|[6-9])-(?:\d{3}|\d{4})-\d{4}$/;
    
    if (!phoneReg.test(phoneValue)) {
        alert("올바른 휴대전화 번호 형식이 아닙니다.\n(예: 010-1234-5678)");
        f.phone.focus();
        return false;
    }
    
// 9. 이메일 입력 및 유효성 검사
    var emailId = f.emailId.value.trim();
    var emailDomain = f.emailDomain.value.trim();

    if(emailId == "") {
        alert("이메일 아이디를 입력해주세요.");
        f.emailId.focus();
        return false;
    }
    if(emailDomain == "") {
        alert("이메일 도메인을 입력해주세요.");
        f.emailDomain.focus();
        return false;
    }

    // 전체 이메일 조합
    var fullEmail = emailId + "@" + emailDomain;

    // 이메일 정규식: 영문, 숫자, 특수문자(._%+- ) @ 영문, 숫자, 점(.) 포함 도메인 . 2자 이상 국가코드
    var emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    if(!emailReg.test(fullEmail)) {
        alert("올바르지 않은 이메일 형식입니다.\n(한글이나 허용되지 않은 특수문자는 사용할 수 없습니다.)");
        f.emailId.focus();
        return false;
    }

    // 길이 제한 체크 (DB 컬럼 크기에 맞춤)
    if(fullEmail.length > 50) {
        alert("이메일 주소가 너무 깁니다. 합쳐서 50자 이내로 입력해주세요.");
        f.emailId.focus();
        return false;
    }
    
    // 10. 주소 입력 확인 (우편번호/기본주소)
    if(f.zipCode.value == "" || f.addr1.value == "") {
        alert("주소 검색을 통해 주소를 입력해주세요.");
        return false;
    }

    // 11. 상세 주소 검증
    var addr2Value = f.addr2.value.trim();
    if(addr2Value == "") {
        alert("상세 주소를 입력해주세요.");
        f.addr2.focus();
        return false;
    }

    // 상세 주소 정규식: 한글, 영문, 숫자, 공백, 특수문자(- ( ) , .) 허용
    // < > script 등 보안에 취약한 문자를 원천 차단하기 위함입니다.
    var addr2Reg = /^[가-힣a-zA-Z0-9\s\(\)\-\.,]*$/;
    if(!addr2Reg.test(addr2Value)) {
        alert("상세 주소에 허용되지 않는 특수문자가 포함되어 있습니다.");
        f.addr2.focus();
        return false;
    }

    // 길이 제한 (DB 컬럼 크기에 맞춰 조절, 보통 100자)
    if(addr2Value.length > 100) {
        alert("상세 주소가 너무 깁니다. 100자 이내로 입력해주세요.");
        f.addr2.focus();
        return false;
    }
    
    if(f.emailDomain.value.trim() == "") {
        alert("이메일 도메인을 입력해주세요.");
        f.emailDomain.focus();
        return false;
    }
    
    // 이메일 정규식 검사 (특수문자 차단 및 형식 체크)
        var fullEmail = f.emailId.value + "@" + f.emailDomain.value;
    
    // 이메일 정규식: 영문자, 숫자, 일부 특수문자(._-)만 허용 @ 도메인 . 끝자리
    var emailReg = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;

    if(!emailReg.test(fullEmail)) {
        alert("올바르지 않은 이메일 형식입니다.\n(한글이나 허용되지 않은 특수문자는 사용할 수 없습니다.)");
        f.emailId.focus();
        return false;
    }
    
    var fullEmail = f.emailId.value + "@" + f.emailDomain.value;
    if(fullEmail.length > 50) {
        alert("이메일 주소가 너무 깁니다. 50자 이내로 입력해주세요.");
        f.emailId.focus();
        return false;
    }
    
    // 비밀번호 힌트 검사
    
    // 1. 질문 선택 여부 검사
    if(f.hintId.value == "") {
        alert("비밀번호 힌트 질문을 선택해주세요.");
        f.hintId.focus();
        return false;
    }

    // 2. 정답 입력 여부 검사
    if(f.hintAnswer.value.trim() == "") {
        alert("비밀번호 힌트 정답을 입력해주세요.");
        f.hintAnswer.focus();
        return false;
    }
    
    // 3. (혹시 모를) 길이 검사
    if(f.hintAnswer.value.length > 50) {
        alert("힌트 정답은 50자 이내로 입력해주세요.");
        f.hintAnswer.focus();
        return false;
    }

    f.submit();
}

// 아이디 중복 체크
function checkId() {
    var userId = $("#userId").val();
    
    // 1. 빈 값 체크
    if(userId.trim() == "") {
        alert("아이디를 입력해주세요.");
        $("#userId").focus();
        return;
    }

    // 2. 유효성 검사 (AJAX 전, 여기서 먼저 체크!)
    // 영문 소문자 + 숫자 조합, 5~20자
    var idReg = /^[a-z0-9]{5,20}$/; 
    
    if (!idReg.test(userId)) {
        alert("아이디는 영문 소문자와 숫자를 포함해 5~20자로 입력해야 합니다.\n(한글, 특수문자, 대문자 불가)");
        $("#userId").focus();
        return; 
    }

    // 3. 서버 중복 확인 (형식이 맞을 때만 실행)
    $.ajax({
        url: contextPath + "/member/idCheck", 
        type: "post",
        data: { "userId" : userId },
        dataType: 'json',
        success: function(result) {
            if(result == 1) {
                // 이미 존재하는 아이디
                alert("이미 사용 중인 아이디입니다.");
                $("#userId").val("").focus();
                isIdChecked = false; // 중복확인 실패 상태
            } else {
                // 사용 가능한 아이디
                alert("사용 가능한 아이디입니다.");
                isIdChecked = true;  // 중복확인 성공 상태
                
                // (선택사항) 사용자가 아이디를 못 바꾸게 막으려면 아래 주석 해제
                // $("#userId").attr("readonly", true);
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