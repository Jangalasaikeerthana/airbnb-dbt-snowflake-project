{% set flag = 2 %}




select * from {{ ref('bronze_bookings') }}
{% if flag == 1 %}
    where booking_id >1
{% else %}
    where booking_id = 1
{% endif %}