class CreateUsers < ActiveRecord::Migration[7.1]
  def up
    execute <<-SQL
      CREATE TABLE `users` (
        `id`                   bigint(20)   NOT NULL AUTO_INCREMENT,
        `uuid`                 varchar(36)  NOT NULL,
        `name`                 varchar(255) NOT NULL,
        `email`                text         NOT NULL,
        `created_at`           datetime(6)  NOT NULL,
        `updated_at`           datetime(6)  NOT NULL,

        PRIMARY KEY (`id`),
        UNIQUE KEY `index_users_on_uuid` (`uuid`)
      ) ENGINE=InnoDB COLLATE=utf8mb4_bin;
      SQL
  end

  def down
    drop_table :users
  end
end
