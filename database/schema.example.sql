-- OficioVolt - esquema de referencia no productivo
-- No ejecutar sobre produccion sin comparar con el esquema existente y hacer backup.
-- Compatible con MySQL 8/MariaDB reciente.

CREATE TABLE admins (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    username VARCHAR(80) NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_login_at DATETIME NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uq_admins_username (username)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE clientes (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nombre VARCHAR(160) NOT NULL,
    zona VARCHAR(160) NULL,
    idioma CHAR(2) NOT NULL DEFAULT 'es',
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_clientes_zona (zona)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE bonos (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    cliente_id INT UNSIGNED NOT NULL,
    codigo VARCHAR(40) NOT NULL,
    pin_hash VARCHAR(255) NOT NULL,
    titulo VARCHAR(160) NOT NULL,
    estado VARCHAR(16) NOT NULL DEFAULT 'activo',
    fecha_inicio DATE NOT NULL,
    fecha_fin DATE NOT NULL,
    horas_iniciales DECIMAL(10,2) NOT NULL,
    horas_usadas DECIMAL(10,2) NOT NULL DEFAULT 0,
    horas_disponibles DECIMAL(10,2) NOT NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    UNIQUE KEY uq_bonos_codigo (codigo),
    KEY idx_bonos_cliente (cliente_id),
    KEY idx_bonos_estado_fin (estado, fecha_fin),
    CONSTRAINT fk_bonos_cliente FOREIGN KEY (cliente_id) REFERENCES clientes (id),
    CONSTRAINT chk_bonos_horas CHECK (horas_iniciales >= 0 AND horas_usadas >= 0 AND horas_disponibles >= 0),
    CONSTRAINT chk_bonos_estado CHECK (estado IN ('activo', 'agotado', 'caducado', 'pausado'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE movimientos_bono (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    bono_id INT UNSIGNED NOT NULL,
    fecha DATE NOT NULL,
    descripcion VARCHAR(1000) NOT NULL,
    horas_usadas DECIMAL(10,2) NOT NULL,
    notas_cliente VARCHAR(1000) NULL,
    visible_cliente TINYINT(1) NOT NULL DEFAULT 0,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_movimientos_bono_fecha (bono_id, fecha, id),
    CONSTRAINT fk_movimientos_bono FOREIGN KEY (bono_id) REFERENCES bonos (id) ON DELETE CASCADE,
    CONSTRAINT chk_movimientos_horas CHECK (horas_usadas > 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE auditoria_admin (
    id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT,
    admin_id INT UNSIGNED NULL,
    accion VARCHAR(80) NOT NULL,
    entidad VARCHAR(80) NULL,
    entidad_id INT UNSIGNED NULL,
    ip VARCHAR(45) NULL,
    detalles JSON NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    KEY idx_auditoria_admin_fecha (created_at),
    KEY idx_auditoria_admin_entidad (entidad, entidad_id),
    CONSTRAINT fk_auditoria_admin FOREIGN KEY (admin_id) REFERENCES admins (id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
