// 네비게이션 관련 공통 함수를 정의합니다.
/* 공통 네비게이션 출력 */
export function renderNav(isAdmin = false) {
  const nav = document.querySelector("nav");
  nav.innerHTML = isAdmin
    ? `
      <strong>관리자 시스템</strong>
      <div>
        <a href="admin.html">운항 관리</a>
        <a href="#">예약/취소 관리</a>
        <a href="#">통계/리포트</a>
        <a href="#">로그아웃</a>
      </div>`
    : `
      <strong>C-AIR</strong>
      <div>
        <a href="index.html">항공권 예매</a>
        <a href="mypage.html">마이페이지</a>
        <a href="#">고객센터</a>
        <a href="#">로그인/회원가입</a>
      </div>`;
}

/* 단순 fetch 래퍼 (JSON) */
export async function apiFetch(url, opts = {}) {
  const token = localStorage.getItem("access_token");
  const headers = { "Content-Type": "application/json", ...(opts.headers || {}) };
  if (token) headers["Authorization"] = `Bearer ${token}`;
  const res = await fetch(url, { ...opts, headers });
  if (!res.ok) throw new Error(await res.text());
  return res.json();
}

/* 날짜·통화 포맷터 */
export const fmtDateTime = iso => new Date(iso).toLocaleString("ko-KR");
export const fmtMoney = num => num.toLocaleString("ko-KR") + "원";
