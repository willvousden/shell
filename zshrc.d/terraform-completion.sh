if type terraform > /dev/null; then
    if type tenv > /dev/null; then
        # Resolve the current Terraform version. We have to use the actual binary for completion, not
        # the proxy binary installed by tenv in /opt/homebrew.
        VERSION=$(tenv tf detect -q | grep -woE '[.0-9]+')
        TERRAFORM_PATH=~/.tenv/Terraform/$VERSION
    else
        TERRAFORM_PATH=$BREW_PREFIX/bin
    fi

    complete -o nospace -C "$TERRAFORM_PATH/terraform" terraform
    complete -o nospace -C "$TERRAFORM_PATH/terraform" tf
fi
