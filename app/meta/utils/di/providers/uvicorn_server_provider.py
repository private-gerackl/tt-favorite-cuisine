from dishka import provide, Provider, Scope
from fastapi import FastAPI
from uvicorn import Config, Server


class UvicornServerProvider(Provider):
    @provide(scope=Scope.APP)
    def get_server_config(
        self,
        app: FastAPI,
    ) -> Config:
        return Config(
            app=app,
        )

    @provide(scope=Scope.APP)
    def get_uvicorn_server(
        self,
        uvicorn_server_config: Config,
    ) -> Server:
        return Server(uvicorn_server_config)
