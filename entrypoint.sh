#!/bin/bash

npm install --save-dev @babel/cli @babel/core @babel/preset-env

if [ -z "$INPUT_TYPENAME" ]
then
    INPUT_TYPENAME="release"
fi

transpile_file(){
    if [[ "$directory" != *"${INPUT_TYPENAME}."* ]];
    then
        directory=$1
        basename=$(basename $directory);
        extension="${basename##*.}"
        filename="${basename%.*}"
        if [ -z "$INPUT_OUTPUT" ];
        then
            output="${directory%/*}/"
        else
            mkdir -p $INPUT_OUTPUT
            output="$INPUT_OUTPUT";
        fi
        output_path="${output}${filename}.${INPUT_TYPENAME}.${extension}"
        $(npx babel ${directory} --out-file ${output_path} --presets /github/workspace/node_modules/@babel/preset-env)
        echo "COMPILE ${directory} | OUTPUT ${output_path}"
    fi
}

for fname in "${INPUT_DIRECTORY}*.js"
do
    transpile_file $fname;
done