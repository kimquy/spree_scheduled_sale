Deface::Override.new(
    :name => "scheduled_sale_tab",
    :virtual_path => "spree/admin/shared/_menu",
    :insert_bottom => "[data-hook='admin_tabs']",
    :text => "<%= tab :scheduled_sales, :icon => 'icon-th-list' %>"
)