def j(obj):
    import json
    try:
        from django.db.models import Model
        if isinstance(obj, Model):
            d = {'___model': obj.__class__.__name__}
            for field in obj._meta.concrete_fields:
                d[field.name] = getattr(
                    obj,
                    field.attname if field.is_relation else field.name,
                    None)
            obj = d
    except ImportError:
        pass

    print(json.dumps(obj, indent=2, sort_keys=True, default=str))
