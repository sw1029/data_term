# data_term

# C-AIR 항공권 예약 플랫폼

> **C-AIR**는 여행자가 항공편을 검색하고 좌석을 예약하며 일정을 관리할 수 있도록 해 주고 관리자는 재고와 사용자를 한눈에 파악하고 제어할 수 있는 풀스택 웹 애플리케이션입니다.

---

## 목차

1. [주요 기능](#주요-기능)
2. [기술 스택](#기술-스택)
3. [프로젝트 구조](#프로젝트-구조)
4. [사전 준비](#사전-준비)
5. [로컬 설정](#로컬-설정)
6. [환경 변수](#환경-변수)
7. [애플리케이션 실행](#애플리케이션-실행)
8. [데이터베이스 마이그레이션](#데이터베이스-마이그레이션)
9. [API 레퍼런스](#api-레퍼런스)
10. [프론트엔드 페이지](#프론트엔드-페이지)
11. [테스트](#테스트)
12. [보안 및 모범 사례](#보안-및-모범-사례)
13. [기여 방법](#기여-방법)
14. [라이선스](#라이선스)

---

## 주요 기능

| 모듈 | 기능 |
| --- | --- |
| **항공편 검색** | 출발지, 도착지, 날짜, 인원 수로 실시간 검색. 편도와 왕복 모두 지원. |
| **예약 엔진** | 좌석 가용성 조회, 요금 계산, 보류/확정 상태의 예약 생성. |
| **사용자 계정** | JWT 기반 인증, 프로필 관리, 지난 여행 내역과 위시리스트. |
| **관리자 포털** | 항공편/좌석 재고 CRUD, 가격 관리, 예약 오버라이드, 악성 사용자 차단. |
| **게시판** | 공지 및 사용자 Q&A를 위한 간단한 포럼(선택 가능). |
| **부가 서비스 목록** | 기내식, 라운지 패스 등 부가 상품 카탈로그와 관리자 CRUD. |
| **API 우선 설계** | 프론트엔드에서 사용하는 RESTful JSON API 제공, OpenAPI 명세 포함. |

---

## 기술 스택

| 레이어 | 기술 |
| --- | --- |
| 프론트엔드 | 프레임워크 없이 기본 HTML/CSS/JS와 Fetch API 사용, 필요 시 React로 확장 가능. |
| 백엔드 | Python 3.10, FastAPI(APIRouter), SQLAlchemy 2 ORM, python-jose 인증. |
| 데이터베이스 | Oracle 19c(on‑prem 또는 ATP). |
| 개발 도구 | Pip + virtualenv, gunicorn, nginx(프로덕션), GitHub Actions(CI), pre-commit 훅(Black, Ruff). |
| 테스트 | pytest, pytest-cov, Playwright(e2e). |

---

## 프로젝트 구조

```
c‑air/
├── backend/
│   ├── main.py               # FastAPI 애플리케이션
│   ├── config.py             # 설정 클래스
│   ├── requirements.txt      # 파이썬 의존성 목록
│   ├── extensions/           # JWT, DB, Marshmallow 초기화 모듈
│   ├── models/               # SQLAlchemy 모델(Customer, Airplane, Seats 등)
│   ├── schemas/              # marshmallow 스키마 <-> 모델 직렬화
│   ├── api/                  # 라우터 모듈(auth, flights, bookings 등)
│   ├── services/             # 비즈니스 로직(가격 계산, 좌석 배치, 결제)
│   ├── tasks/                # 비동기/스케줄 작업(좌석 만료)
│   └── migrations/           # Alembic 스크립트(자동 생성)
├── frontend/
│   ├── assets/
│   │   ├── css/
│   │   │   └── styles.css
│   │   ├── img/
│   │   └── js/
│   │       └── main.js       # Fetch 래퍼와 DOM 헬퍼
│   └── pages/
│       ├── search.html       # 항공편 검색 (wireframe #1)
│       ├── results.html      # 항공편 목록 & 여정 선택 (wireframe #2)
│       └── booking.html      # 예약 상세 & 결제 (wireframe #3)
└── README.md
```

> **왜 HTML 파일을 분리했나요?** 각 와이어프레임은 API로부터 데이터를 받아오는 독립적인 페이지이기 때문에 관심사를 분리할 수 있고 이후 프레임워크 도입도 단계적으로 진행할 수 있습니다.

---

## 사전 준비

* **Oracle Instant Client 21.11** 이상을 설치하고 `PATH` / `LD_LIBRARY_PATH`에 추가합니다.
* **Python 3.10 이상**(3.12 검증 완료).
* `backend/migrations/versions/0_ddl.sql` 스키마가 적용된 **Oracle DB 19c** 인스턴스가 실행 중이어야 합니다.
* 자산을 esbuild로 번들링하려면 Node 18 이상이 필요합니다.

---

## 로컬 설정

```bash
# 1. 저장소 클론
$ git clone https://github.com/sw1029/data_term && cd c‑air

# 2. 백엔드
$ python -m venv .venv && source .venv/bin/activate
(.venv) $ pip install -r backend/requirements.txt

# 3. 프론트엔드(선택 사항)
$ npm i -g esbuild       # 또는 pnpm/yarn
$ cd frontend && npm install && cd ..

# 4. 환경 변수 설정
$ cp backend/.env.example backend/.env   # 값 수정
```

---

## 환경 변수

| 변수 | 예시 | 설명 |
| --- | --- | --- |
| `APP_ENV` | `development` | 애플리케이션 모드 |
| `ORACLE_DSN` | `localhost:1521/FREEPDB1` | 전체 DSN 또는 EZConnect 문자열 |
| `ORACLE_USER` | `CAIR_APP` | 애플리케이션용 DB 사용자 |
| `ORACLE_PASSWORD` | `secret_pw` | 위 사용자 비밀번호 |
| `JWT_SECRET` | `example_secret` | 액세스 토큰 서명용 256비트 비밀 값 |
| `ADMIN_EMAIL` | `admin@c‑air.io` | 기본 관리자 계정 이메일 |

더 많은 설정 항목은 `backend/config.py`에서 확인할 수 있습니다.

---

## 애플리케이션 실행

### 백엔드(FastAPI)

```bash
# 가상 환경이 활성화된 상태에서 실행
$ uvicorn app.main:app --reload  # http://127.0.0.1:8000
```

프로덕션 환경에서는:

```bash
$ gunicorn -k uvicorn.workers.UvicornWorker app.main:app -b 0.0.0.0:8000 --workers 4 --timeout 120
```

### 프론트엔드(정적 서비스)

```bash
$ cd frontend
$ python -m http.server 3000   # http://localhost:3000/pages/search.html
```

esbuild를 사용한다면:

```bash
$ npm run dev                  # esbuild-serve 실시간 리로드
```

---

## 데이터베이스 마이그레이션

| 단계 | 명령 |
| --- | --- |
| 새 버전 생성 | `flask db migrate -m "Add loyalty tier"` |
| DB 적용 | `flask db upgrade` |
| 롤백 | `flask db downgrade` |

기본 DDL은 `/docs/db‑schema.md`에 있는 스키마와 일치합니다.

---

## API 레퍼런스

전체 사양은 `backend/openapi.yaml`에 있으며 주요 엔드포인트는 다음과 같습니다.

| 메서드 | 엔드포인트 | 설명 |
| --- | --- | --- |
| `POST` | `/api/auth/login` | JWT 토큰 발급 |
| `GET` | `/api/flights/search` | 항공편 검색(`origin`, `dest`, `departDate`, `returnDate?`) |
| `POST` | `/api/bookings` | 선택한 항공편과 승객 정보로 예약 생성 |
| `GET` | `/api/bookings/{id}` | 예약 상세 조회 |
| `PATCH` | `/api/admin/flights/{id}` | 항공편 메타데이터 수정(관리자) |

> 보호된 라우트를 호출할 때는 `Authorization: Bearer <access-token>` 헤더를 사용합니다.

---

## 프론트엔드 페이지

| 파일 | 와이어프레임 ID | 설명 |
| --- | --- | --- |
| `pages/search.html` | #1 | 랜딩 및 항공편 검색 위젯 |
| `pages/results.html` | #2 | 검색 결과 목록, 필터, 요금 요약 |
| `pages/booking.html` | #3 | 승객 정보 입력, 좌석 선택, 결제 |

내비게이션 헤더(`<header class="nav-bar">`)는 일관성을 위해 `<template>`을 통해 로드됩니다.

---

## 테스트

```bash
$ pytest -q                     # 단위 + 통합 테스트
$ pytest -m e2e tests/e2e       # Playwright UI 테스트(headless chrome)
$ pytest --cov-report=html      # htmlcov/에 커버리지 리포트 생성
```

---

## 보안 및 모범 사례

* `argon2-cffi`를 이용한 Argon2 패스워드 해싱
* SQL 인젝션을 방지하기 위한 Prepared Statement와 SQLAlchemy ORM 사용
* 변경이 필요한 요청에 대해 CORS 허용 목록과 CSRF 토큰 적용
* 로그인과 검색 엔드포인트에 대한 속도 제한(SlowAPI)
* 관리자 라우트에 대한 역할 기반 접근 제어
* Marshmallow 스키마와 WTForms(프론트엔드) 기반 입력 검증

---

## 기여 방법

1. 저장소를 포크한 뒤 기능 브랜치를 생성합니다.
2. 커밋 메시지는 `feat(scope): message` 형식을 따릅니다.
3. `pre-commit run --all-files`가 통과되어야 합니다.
4. PR은 최소 한 번의 승인 리뷰와 CI 통과가 필요합니다.

---

## 라이선스

이 프로젝트는 MIT 라이선스로 배포됩니다. 자세한 내용은 [`LICENSE`](LICENSE)를 참고하세요.
