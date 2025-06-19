# app/config.py
from functools import lru_cache
from pydantic import BaseSettings, Field

class Settings(BaseSettings):
    oracle_user: str = Field(..., env="ORACLE_USER")
    oracle_password: str = Field(..., env="ORACLE_PASSWORD")
    oracle_dsn: str = Field(..., env="ORACLE_DSN")  # host:port/service_name
    jwt_secret: str = Field(..., env="JWT_SECRET")
    jwt_alg: str = "HS256"

    class Config:
        env_file = ".env"

@lru_cache
def get_settings() -> Settings:
    return Settings()
