# Alenx Scheduler
[![Build Status](https://travis-ci.org/yknx4/alenx_scheduler.svg?branch=master)](https://travis-ci.org/yknx4/alenx_scheduler)
[![Code Climate](https://codeclimate.com/github/yknx4/alenx_scheduler/badges/gpa.svg)](https://codeclimate.com/github/yknx4/alenx_scheduler)
[![Test Coverage](https://codeclimate.com/github/yknx4/alenx_scheduler/badges/coverage.svg)](https://codeclimate.com/github/yknx4/alenx_scheduler/coverage)
[![Issue Count](https://codeclimate.com/github/yknx4/alenx_scheduler/badges/issue_count.svg)](https://codeclimate.com/github/yknx4/alenx_scheduler)

Es un servicio para agendar citas que le permite a las organizaciones agregar prestadores de servicios. Los usuarios pueden agendar citas con ellos dependiendo de la disponibilidad de cada prestador de servicio y de los horarios establecidos por la organización.

## Características

El horario de disponibilidad se define por varios factores:

* Limitantes que la organización define (ej. horarios)
* Un horario global permanente de cada prestador de servicio(ej. De Lunes a Viernes, de 9 am a 5 pm)
* Habilidad de agregar días/horas no disponibles (ej. Los siguientes dos días el prestador de servicio no está disponible).
* Las citas previamente agendadas.

Características de los espacios

* Duración por default (ej. 15 min)
* Extensión en incrementos predispuestos (ej. En vez de 15 min quiero 45 min).

Los usuarios no pueden ver la información de otros proveedores de servicios y los proveedores de servicios no pueden ver la información de usuarios fuera de su servicio.

Habilidad de los usuarios y prestadores de servicio de modificar la fecha de su cita o cancelar
Configurable para que un admin apruebe la petición (o no)

## Funcionamiento

* Create organizations (multitenant)
* Organization admin sign up
* Service provider sign up
* User sign up
* Admin can invite service providers via email
* Service providers can add schedule fixed 
* Let user to query the available slots for service providers (by time, by service, by specific service provider)
* Let user to see all service provider's free slot
* Create appointment
* Service provider can put off/cancel appointment
* Org admin can put off/cancel appointment
* User can put off/cancel appointment
* Notifiy service provider/users about a new appointment
* Org admin can see all appointments
* Organization adds services (type and specs)
* Add service providers somehow vetted by organization
* Configure the organization (availability, hours, limits, etc)
* Configuration for the service provider (availability, hours, calendar, etc)

API for:

* Select service
* Select date and time
* Select service provider
* Reserve slot for service
* Add user info
* Make reservation
* Cancel appointment
* Add services providers to own organization
* Ability to configure settings

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
