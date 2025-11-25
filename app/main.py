import asyncio

from app.meta.app_manager import AppManager
from app.meta.utils.di.app_container_factory import AppContainerFactory

async def main() -> None:
    app_container = AppContainerFactory.build()
    app_manager = AppManager(app_container)
    await app_manager.run()


if __name__ == '__main__':
    asyncio.run(main())