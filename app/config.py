# app/config.py
from functools import lru_cache
from pydantic_settings import BaseSettings
from pydantic import Field

class Settings(BaseSettings):
    sqlite_path: str = Field("data.db", env="SQLITE_PATH")
    jwt_secret: str = Field(..., env="JWT_SECRET")
    jwt_alg: str = "HS256"
    app_env: str = Field(..., env="APP_ENV")
    admin_email: str = Field(..., env="ADMIN_EMAIL")

    class Config:
        env_file = ".env"

@lru_cache
def get_settings() -> Settings:
    return Settings()