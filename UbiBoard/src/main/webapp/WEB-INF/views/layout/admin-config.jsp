<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>관리자 환경설정</title>
    <style>
        :root {
            --primary-color: #4e73df;
            --bg-color: #f8f9fc;
            --card-bg: #ffffff;
            --text-main: #3a3b45;
            --border-color: #e3e6f0;
        }

        body {
            font-family: 'Pretendard', -apple-system, sans-serif;
            background-color: var(--bg-color);
            color: var(--text-main);
            margin: 0; padding: 40px;
        }

        .admin-wrapper { max-width: 1000px; margin: 0 auto; }
        .header { margin-bottom: 30px; display: flex; justify-content: space-between; align-items: center; }
        .header h1 { font-size: 1.5rem; font-weight: 700; color: #4e73df; }

        /* 섹션 카드 스타일 */
        .config-section {
            background: var(--card-bg);
            border: 1px solid var(--border-color);
            border-radius: 12px;
            padding: 25px;
            margin-bottom: 25px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.02);
        }

        .section-title {
            font-size: 1.1rem; font-weight: 600;
            margin-bottom: 20px; padding-bottom: 10px;
            border-bottom: 2px solid var(--bg-color);
            display: flex; align-items: center;
        }

        /* 설정 항목 행 */
        .config-row {
            display: flex; justify-content: space-between; align-items: center;
            padding: 15px 0; border-bottom: 1px line var(--bg-color);
        }
        .config-info { flex: 1; }
        .config-info .label { font-weight: 600; display: block; margin-bottom: 4px; }
        .config-info .desc { font-size: 0.85rem; color: #858796; }

        /* 토글 스위치 디자인 */
        .switch {
            position: relative; display: inline-block; width: 50px; height: 26px;
        }
        .switch input { opacity: 0; width: 0; height: 0; }
        .slider {
            position: absolute; cursor: pointer; top: 0; left: 0; right: 0; bottom: 0;
            background-color: #ccc; transition: .4s; border-radius: 34px;
        }
        .slider:before {
            position: absolute; content: ""; height: 18px; width: 18px;
            left: 4px; bottom: 4px; background-color: white; transition: .4s; border-radius: 50%;
        }
        input:checked + .slider { background-color: var(--primary-color); }
        input:checked + .slider:before { transform: translateX(24px); }

        /* 입력 폼 스타일 */
        .input-field {
            padding: 8px 12px; border: 1px solid var(--border-color);
            border-radius: 6px; width: 80px; text-align: center;
        }

        .save-btn {
            position: fixed; bottom: 40px; right: 40px;
            padding: 15px 40px; background: var(--primary-color);
            color: white; border: none; border-radius: 30px;
            font-size: 1rem; font-weight: bold; cursor: pointer;
            box-shadow: 0 10px 20px rgba(78, 115, 223, 0.3);
        }
        .save-btn:hover { background: #2e59d9; }
    </style>
</head>
<body>

<div class="admin-wrapper">
    <div class="header">
        <h1>⚙️ 시스템 환경설정</h1>
        <button onclick="location.href='${pageContext.request.contextPath}/goMain'" style="background:none; border:none; color:#858796; cursor:pointer;">🏠 메인으로 돌아가기</button>
    </div>

    <form action="${pageContext.request.contextPath}/admin/updateConfig" method="post">
        
        <div class="config-section">
            <div class="section-title">🛡️ 로그인 및 보안 정책</div>
            
            <div class="config-row">
                <div class="config-info">
                    <span class="label">로그인 실패 시 임시 잠금</span>
                    <span class="desc">5회 실패 시 영구잠금 대신 5분간 접속을 차단합니다.</span>
                </div>
                <label class="switch">
                    <input type="checkbox" name="tempLockEnabled" ${config.useTempLock == 'on' ? 'checked' : ''}>
                    <span class="slider"></span>
                </label>
            </div>

            <div class="config-row">
                <div class="config-info">
                    <span class="label">로그인 유지 시간 (세션)</span>
                    <span class="desc">사용자가 활동이 없을 때 자동 로그아웃되는 시간입니다.</span>
                </div>
                <div>
                    <input type="number" name="sessionTimeOut" class="input-field" value="${config.sessionTimeOut}"> <span style="font-size:0.9rem;">분</span>
                </div>
            </div>

<!--             <div class="config-row">
                <div class="config-info">
                    <span class="label">강력한 비밀번호 정책</span>
                    <span class="desc">영문, 숫자, 특수문자 조합을 강제합니다.</span>
                </div>
                <label class="switch">
                    <input type="checkbox" name="strong_pw_policy">
                    <span class="slider"></span>
                </label>
            </div> -->
        </div>

        <div class="config-section">
            <div class="section-title">📝 게시판 콘텐츠 정책</div>
            
            <div class="config-row">
                <div class="config-info">
                    <span class="label">페이지당 게시물 수</span>
                    <span class="desc">목록 한 페이지에 보여줄 게시글의 개수입니다.</span>
                </div>
                <input type="number" name="postsPerPage" class="input-field" value="${config.postsPerPage}">
            </div>

<!--             <div class="config-row">
                <div class="config-info">
                    <span class="label">욕설/비속어 필터링</span>
                    <span class="desc">등록된 금지어가 포함된 게시글 등록을 차단합니다.</span>
                </div>
                <label class="switch">
                    <input type="checkbox" name="filter_enabled" checked>
                    <span class="slider"></span>
                </label>
            </div> -->
            
<!--             <div class="config-row">
                <div class="config-info">
                    <span class="label">신규 회원 글쓰기 제한</span>
                    <span class="desc">가입 후 24시간이 지나야 글 작성이 가능하도록 설정합니다.</span>
                </div>
                <label class="switch">
                    <input type="checkbox" name="new_user_write_limit">
                    <span class="slider"></span>
                </label>
            </div> -->
        </div>

<!--         <div class="config-section" style="border-left: 5px solid #e74a3b;">
            <div class="section-title" style="color:#e74a3b;">⚠️ 시스템 제어</div>
            
            <div class="config-row">
                <div class="config-info">
                    <span class="label">사이트 점검 모드</span>
                    <span class="desc">관리자를 제외한 모든 사용자의 접속을 차단하고 안내 화면을 띄웁니다.</span>
                </div>
                <label class="switch">
                    <input type="checkbox" name="maintenance_mode">
                    <span class="slider"></span>
                </label>
            </div> -->
        </div>

        <button type="submit" class="save-btn">설정 저장하기</button>
    </form>
</div>

</body>
</html>