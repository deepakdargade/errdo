class ErrdoCreate<%= table_name.camelize %> < ActiveRecord::Migration<%= migration_version %>
  def change
    create_table :<%= table_name %> do |t|
      t.string :exception_class_name
      t.string :exception_message
      t.string :http_method
      t.string :host_name
      t.string :url

      t.text :backtrace

      t.string :backtrace_hash
      t.integer :occurrence_count, default: 1

<% attributes.each do |attribute| -%>
      t.<%= attribute.type %> :<%= attribute.name %>
<% end -%>

      t.timestamps null: false
    end

    create_table :<%= occurrence_table_name %> do |t|
      t.integer :<%= table_name.singularize %>_id

      t.string :experiencer_class
      t.integer :experiencer_id

      t.string :ip
      t.string :user_agent
      t.string :referer
      t.string :query_string
      t.string :form_values
      t.string :param_values
      t.string :cookie_values
      t.string :header_values

      t.integer :ocurrence_count, default: 1
      t.timestamps null: false
    end

    add_index :<%= table_name %>, :backtrace_hash, unique: true
    add_index :<%= occurrence_table_name %>, :experiencer_id
    add_index :<%= occurrence_table_name %>, :experiencer_type
    add_index :<%= occurrence_table_name %>, :<%= table_name.singularize %>_id
  end
end
