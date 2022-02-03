function mkcd {
    mkdir $args[0]
    cd $args[0]
}

function touch {
    Out-File -FilePath $args[0]
}
