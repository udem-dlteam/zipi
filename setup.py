import setuptools

setuptools.setup(
    name="zipi",
    version="0.0.1",
    author="udem-dlteam",
    author_email="author@example.com",  # change!
    description="zipi - Python parsing infrastructure",
    url="https://github.com/udem-dlteam/zipi",
    packages=["zipi", "zipi/zast", "zipi/pyinterp"],
    include_package_data=True,
    python_requires='>=3.8',
)
