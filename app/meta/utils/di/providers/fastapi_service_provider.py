from dishka import provide, Scope, Provider
from fastapi import FastAPI

from app.meta.utils.di.factories.fastapi_factory import FastAPIFactory


class FastAPIServiceProvider(Provider):
    @provide(scope=Scope.APP)
    def get_fastapi_factory(
        self,
    ) -> FastAPIFactory:
        return FastAPIFactory()

    @provide(scope=Scope.APP)
    def get_fastapi(
        self,
        fastapi_factory: FastAPIFactory,
    ) -> FastAPI:
        return fastapi_factory.build()
