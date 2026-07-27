def find_by_id(items, item_id):
    for item in items:
        if item["id"] == item_id:
            return item
    return None
