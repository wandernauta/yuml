from distutils.core import setup

setup(
    name='yuml',
    description='A command-line client for the yUML service',
    author='Wander Nauta',
    author_email='info@wandernauta.nl',
    version='0.1',
    scripts=['yuml'],
    url='http://github.com/wandernauta/yuml/',
    license='COPYING',
    long_description=open('README.rst').read(),

    classifiers=[
        'Environment :: Console',
        'License :: OSI Approved :: ISC License (ISCL)',
        'Programming Language :: Python',
    ],
)
