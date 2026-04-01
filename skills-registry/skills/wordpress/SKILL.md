---
name: wordpress
description: WordPress development. Triggers on wordpress, wp, theme, plugin, gutenberg.
---

## WordPress
**Hooks:** add_action/add_filter (priority: lower=first, default=10).
**Security:** ALWAYS sanitize, use nonces, use $wpdb->prepare(). NEVER extract() user data.
**Performance:** wp_enqueue properly. Transients for expensive queries.
**CPT:** register_post_type with show_in_rest=true for Gutenberg.
