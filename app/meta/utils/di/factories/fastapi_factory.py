from fastapi import FastAPI

from app.transports.fastapi.foo import router


class FastAPIFactory:
    def __init__(
        self,
    ):
        self._app = FastAPI()

    def build(self) -> FastAPI:
        app = FastAPI()
        self._include_routers(app)
        return app

    def _include_routers(
        self,
        app: FastAPI,
    ) -> None:
        app.include_router(router)
