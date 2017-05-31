name "configure-node"
description "Configures RVM, NGINX, and Ruby app"
run_list ["recipe[myrvm]", "recipe[mynginx]", "recipe[rails-deploy]"]
override_attributes({
})
