# AE4 — Aplicación web con base de datos en contenedores

## 1. Objetivo del proyecto

El objetivo de esta práctica es desplegar una aplicación web contenerizada con Django y Gunicorn, PostgreSQL como base de datos, pgAdmin para administrar los datos y nginx como proxy inverso.

La infraestructura se definirá mediante Docker Compose. El despliegue se automatizará con un script `deploy.sh` y se comprobará mediante comandos estándar.

## 2. Arquitectura

El proyecto estará formado por cuatro servicios:

- **nginx:** recibe las peticiones web a través del puerto 8000 del equipo anfitrión y las reenvía a Django.
- **app:** ejecuta Django mediante Gunicorn y proporciona las páginas HTML y los endpoints de la API.
- **db:** almacena los datos de los lugares en PostgreSQL.
- **pgadmin:** permite administrar PostgreSQL desde el navegador.

Los servicios se comunicarán mediante la red interna de Docker Compose.

### Diagrama de arquitectura

```mermaid
flowchart TD
    C[Cliente / navegador]
    N[nginx]
    A[Django + Gunicorn]
    D[(PostgreSQL)]
    P[pgAdmin]

    C -->|localhost:8000| N
    N -->|app:8000| A
    A -->|db:5432| D
    P -->|db:5432| D
    C -->|localhost:5050| P
