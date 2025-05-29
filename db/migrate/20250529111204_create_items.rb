class CreateItems < ActiveRecord::Migration[8.0]
  def up
    execute <<-SQL
      CREATE TABLE `items` (
        `id`                   bigint(20)    NOT NULL AUTO_INCREMENT,
        `uuid`                 varchar(36)   NOT NULL,
        `price`                decimal(10,2) NOT NULL, -- Adjusted precision for decimals
        `brand`                varchar(255)  NOT NULL,
        `photo_url`            text          NOT NULL,
        `status`               tinyint       NOT NULL DEFAULT 1,
        `user_id`              bigint        NOT NULL,
        `created_at`           datetime(6)   NOT NULL,
        `updated_at`           datetime(6)   NOT NULL,
        
        PRIMARY KEY (`id`),
        UNIQUE KEY  `index_items_on_uuid` (`uuid`),
        -- Correct foreign key syntax
        KEY (`user_id`) REFERENCES `users`(`id`)
      ) ENGINE=InnoDB COLLATE=utf8mb4_bin;
    SQL
  end

  def down
    drop_table :items
  end
end