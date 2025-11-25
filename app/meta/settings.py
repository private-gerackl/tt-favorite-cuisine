from pydantic import BaseModel
from pydantic_settings import BaseSettings


class AppSettings(
    BaseModel,
):
    pass


class EnvSettings(
    BaseSettings,
):
    app_version: str = '0.0.0'
