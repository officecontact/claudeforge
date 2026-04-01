---
name: django
description: Django web framework. Triggers on django, DRF, manage.py, wsgi.
---

## Django
**Models:** Always __str__. Meta.ordering. select_related (FK) + prefetch_related (M2M).
**DRF:** ViewSets for CRUD. Always permission_classes. is_valid(raise_exception=True).
**Security:** SECRET_KEY from env. DEBUG=False in prod. ALLOWED_HOSTS explicit.
