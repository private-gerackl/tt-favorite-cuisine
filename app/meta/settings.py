from pydantic import BaseModel, IPvAnyAddress, PositiveInt
from pydantic_settings import BaseSettings


class AppSettings(
    BaseModel,
):
    pass


class EnvSettings(
    BaseSettings,
):
    app_version: str = "0.0.0"
    uvicorn_workers_count: PositiveInt = 1
    uvicorn_host: IPvAnyAddress = '0.0.0.0'
    uvicorn_port: PositiveInt = 80
