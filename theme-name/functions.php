<?php
/**
 * All functions and definitions
 *
 * @package theme-name
 */

/**
 * Load Composer Autoloader
 */
if ( file_exists( get_template_directory() . '/vendor/autoload.php' ) ) {
	require_once get_template_directory() . '/vendor/autoload.php';
}
/**
 * Theme functions and definitions
 */
require get_template_directory() . '/inc/functions.php';
