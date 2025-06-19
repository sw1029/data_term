import re
from datetime import datetime
from sqlalchemy import text
from app.database import engine, Base
from app.models import admin, customer, flight, reservation
from pathlib import Path


def _convert_timestamp(match: re.Match) -> str:
    ts = match.group(1)
    dt = datetime.strptime(ts, "%Y-%m-%d %H-%M-%S")
    return f"'{dt.strftime('%Y-%m-%d %H:%M:%S')}'"


def main():
    # Recreate all tables defined in SQLAlchemy models
    Base.metadata.drop_all(bind=engine)
    Base.metadata.create_all(bind=engine)

    sql_path = Path(__file__).parent / "example.sql"
    if not sql_path.exists():
        raise FileNotFoundError(sql_path)

    with engine.begin() as conn:
        content = sql_path.read_text(encoding="utf-8")
        statements = [s.strip() for s in content.split(';') if s.strip()]
        for stmt in statements:
            if not stmt.startswith("INSERT"):
                continue
            stmt = re.sub(r"TO_TIMESTAMP\('([^']+)'[^)]*\)", _convert_timestamp, stmt)
            conn.execute(text(stmt))


if __name__ == "__main__":
    main()
