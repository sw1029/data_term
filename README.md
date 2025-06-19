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
| 데이터베이스 | SQLite 3 파일 DB. |
| 개발 도구 | Pip + virtualenv, gunicorn, nginx(프로덕션), GitHub Actions(CI), pre-commit 훅(Black, Ruff). |
| 테스트 | pytest, pytest-cov, Playwright(e2e). |

---

## 프로젝트 구조

```
data_term/
├── app/
│   ├── main.py              # FastAPI 연락 점
│   ├── config.py            # 환경 설정
│   ├── database.py          # SQLAlchemy 설정
│   ├── api/
│   │   └── v1/              # 라우터 모듈
│   ├── models/              # 데이터 모델
│   ├── schemas/             # Pydantic 스키마
│   ├── crud/                # CRUD 로직
│   └── core/                # 보안 의존성 모듈
├── public/
│   ├── index.html
│   ├── admin.html
│   ├── mypage.html
│   ├── css/
│   │   └── styles.css
│   └── js/
│       └── common.js
├── example.sql             # 초기 SQL 예제
├── requirements.txt        # Python 의존성
└── README.md
```

> **왜 HTML 파일을 분리했나요?** 각 와이어프레임은 API로부터 데이터를 받아오는 독립적인 페이지이기 때문에 관심사를 분리할 수 있고 이후 프레임워크 도입도 단계적으로 진행할 수 있습니다.

---

## 사전 준비

* **Python 3.10 이상**(3.12 검증 완료).
* 로컬에서 SQLite를 사용하므로 별도의 DB 설치가 필요하지 않습니다.
* 자산을 esbuild로 번들링하려면 Node 18 이상이 필요합니다.

---

## 로컬 설정

```bash
# 1. 저장소 클론
$ git clone https://github.com/sw1029/data_term && cd data_term

# 2. 의존성 설치
$ python -m venv .venv && source .venv/bin/activate
(.venv) $ pip install -r requirements.txt

# 3. 환경 변수 파일 생성
$ touch .env   # 아래 표를 참고해 값을 입력
```

---

## 환경 변수

프로젝트 루트에 `.env` 파일을 생성하고 아래 변수들을 설정합니다.

| 변수 | 예시 | 설명 |
| --- | --- | --- |
| `APP_ENV` | `development` | 애플리케이션 모드 |
| `SQLITE_PATH` | `./data.db` | 생성될 SQLite 파일 경로 |
| `JWT_SECRET` | `example_secret` | 액세스 토큰 서명용 256비트 비밀 값 |
| `ADMIN_EMAIL` | `admin@c‑air.io` | 기본 관리자 계정 이메일 |
| `ALLOW_ORIGINS` | `http://localhost:3000` | 허용할 프론트엔드 오리진(콤마 구분) |

더 많은 설정 항목은 `app/config.py`에서 확인할 수 있습니다.

---

## 애플리케이션 실행

### 백엔드(FastAPI)

```bash
# 가상 환경이 활성화된 상태에서 실행
$ uvicorn app.main:app --reload  # http://127.0.0.1:8000
```

로컬 프론트엔드(포트 3000)에서 API를 호출하려면 CORS 헤더를 허용해야 합니다.
`app/main.py`에서 이를 설정했으므로 서버를 재시작하면 즉시 적용됩니다.

프로덕션 환경에서는:

```bash
$ gunicorn -k uvicorn.workers.UvicornWorker app.main:app -b 0.0.0.0:8000 --workers 4 --timeout 120
```

### 프론트엔드(정적 서비스)

```bash
$ cd frontend
$ python -m http.server 3000   # http://localhost:3000/index.html
```

esbuild를 사용한다면:

```bash
$ npm run dev                  # esbuild-serve 실시간 리로드
```

---

## 데이터베이스 마이그레이션

| 단계 | 명령 |
| --- | --- |
| 데이터베이스 생성 | `python init_sqlite.py` |

예제 데이터는 `example.sql`을 파싱하여 SQLite로 삽입됩니다.

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