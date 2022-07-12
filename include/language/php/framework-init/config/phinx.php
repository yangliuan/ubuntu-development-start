<?php
/**
 * phinx数据迁移文档
 * DOC: https://tsy12321.gitbooks.io/phinx-doc/content/
 */
return [
    "paths" => [
        "migrations" => "database/migrations",
        "seeds"      => "database/seeds",
    ],
    "environments" => [
        "default_migration_table" => "migration",
        "default_database"        => "dev",
        "default_environment"     => "dev",
        "dev" => [
            "adapter" => "mysql",
            "host"    => '127.0.0.1',
            "name"    => '',
            "user"    => 'root',
            "pass"    => '123456',
            "port"    => 3306,
            "charset" => "utf8mb4",
        ],
    ],
];
