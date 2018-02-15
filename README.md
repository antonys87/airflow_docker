Information:
Airflow Docker image based on Ubuntu official Image and uses the official Postgres as backend and Redis as queue
Install Docker
Install Docker Compose

Installation
Pull the image from the Docker repository.

docker pull antonyrajs87/airflow_docker

Build

docker build --rm -t antonyrajs87/airflow_docker .
Setup:

For CeleryExecutor :

docker-compose -f docker-compose-.yml up -d
If you want to run Ad hoc query, make sure you've configured connections:
Airflow URL --> Go to Admin --> Connections and Edit "postgres_default" set this values (as mentioned in airflow.cfg/docker-compose.yml) :

Host : postgres
Schema : airflow
Login : airflow
Password : airflow
For encrypted connection passwords (Celery Executor), you must have the same fernet_key. By default docker-airflow generates the fernet_key at startup, you have to set an environment variable in the docker-compose file to set the same key accross containers.

To generate a fernet_key :

python -c "from cryptography.fernet import Fernet; FERNET_KEY = Fernet.generate_key().decode(); print FERNET_KEY"
Install custom python package
Create a file "requirements.txt" with the desired python modules
Mount this file as a volume -v $(pwd)/requirements.txt:/requirements.txt
The entrypoint.sh script execute the pip install command (with --user option)
UI Links
Airflow: localhost:8080
Flower: localhost:5555
