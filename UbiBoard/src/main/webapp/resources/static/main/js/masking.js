$(document).ready(function() {
    
    // 1. 아이디 마스킹 처리 (앞 3자리 노출)
    $(".mask-id").each(function() {
        var originStr = $(this).text().trim();
        if (originStr.length > 3) {
            var visible = originStr.substring(0, 3);
            var masked = "*".repeat(originStr.length - 3);
            $(this).text(visible + masked);
        }
    });

    // 2. 이름 마스킹 처리
    $(".mask-name").each(function() {
        var originStr = $(this).text().trim();
        var len = originStr.length;
        var maskedStr = originStr;

        if (len == 2) {
            // 2글자: 뒤 1글자 마스킹 (김철 -> 김*)
            maskedStr = originStr.substring(0, 1) + "*";
        } else if (len >= 3) {
            // 3글자 이상: 앞뒤 1글자 제외하고 마스킹 (홍길동 -> 홍*동)
            var first = originStr.substring(0, 1);
            var last = originStr.substring(len - 1);
            var middle = "*".repeat(len - 2);
            maskedStr = first + middle + last;
        }
        
        $(this).text(maskedStr);
    });
    
});
