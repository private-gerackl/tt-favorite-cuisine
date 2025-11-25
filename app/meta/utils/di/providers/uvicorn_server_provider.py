from dishka import provide, Provider, Scope
from fastapi import FastAPI
from uvicorn import Config, Server

from app.meta.settings import EnvSettings


class UvicornServerProvider(Provider):
    @provide(scope=Scope.APP)
    def get_server_config(
        self,
        app: FastAPI,
        env_settings: EnvSettings,
    ) -> Config:
        return Config(
            app=app,
            workers=env_settings.uvicorn_workers_count,
            host=str(env_settings.uvicorn_host),
            port=env_settings.uvicorn_port,
            server_header=False,
            proxy_headers=True,
        )

    @provide(scope=Scope.APP)
    def get_uvicorn_server(
        self,
        uvicorn_server_config: Config,
    ) -> Server:
        return Server(uvicorn_server_config)
