# app/config.py
from functools import lru_cache
from pydantic_settings import BaseSettings
from pydantic import Field

class Settings(BaseSettings):
    oracle_user: str = Field(..., env="ORACLE_USER")
    oracle_password: str = Field(..., env="ORACLE_PASSWORD")
    oracle_dsn: str = Field(..., env="ORACLE_DSN")  # host:port/service_name
    jwt_secret: str = Field(..., env="JWT_SECRET")
    jwt_alg: str = "HS256"
    app_env: str = Field(..., env="APP_ENV")
    admin_email: str = Field(..., env="ADMIN_EMAIL")

    class Config:
        env_file = ".env"

@lru_cache
def get_settings() -> Settings:
    return Settings()