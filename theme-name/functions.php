<?php
add_action( 'after_setup_theme', function () {
	load_theme_textdomain( 'theme-name', get_template_directory() . '/languages' );
} );